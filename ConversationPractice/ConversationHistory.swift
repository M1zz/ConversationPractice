import Foundation

// MARK: - Conversation History Model
struct ConversationHistory: Identifiable {
    let id: String
    let scenarioId: String
    let scenarioTitle: [Language: String]
    let scenarioIcon: String
    let learningLanguage: Language
    let conversationNodes: [ConversationNode]
    let date: Date

    init(
        id: String = UUID().uuidString,
        scenarioId: String,
        scenarioTitle: [Language: String],
        scenarioIcon: String,
        learningLanguage: Language,
        conversationNodes: [ConversationNode],
        date: Date = Date()
    ) {
        self.id = id
        self.scenarioId = scenarioId
        self.scenarioTitle = scenarioTitle
        self.scenarioIcon = scenarioIcon
        self.learningLanguage = learningLanguage
        self.conversationNodes = conversationNodes
        self.date = date
    }

    func getTitle(for language: Language) -> String {
        return scenarioTitle[language] ?? scenarioTitle[.english] ?? "Conversation"
    }
}

// MARK: - Codable Support
extension ConversationHistory: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, scenarioId, scenarioIcon, learningLanguage, conversationNodes, date
        case scenarioTitleData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        scenarioId = try container.decode(String.self, forKey: .scenarioId)
        scenarioIcon = try container.decode(String.self, forKey: .scenarioIcon)
        learningLanguage = try container.decode(Language.self, forKey: .learningLanguage)
        conversationNodes = try container.decode([ConversationNode].self, forKey: .conversationNodes)
        date = try container.decode(Date.self, forKey: .date)

        // Decode dictionary from array of tuples
        let titleData = try container.decode([[String]].self, forKey: .scenarioTitleData)
        var titles: [Language: String] = [:]
        for item in titleData {
            if item.count == 2,
               let language = Language(rawValue: item[0]) {
                titles[language] = item[1]
            }
        }
        scenarioTitle = titles
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(scenarioId, forKey: .scenarioId)
        try container.encode(scenarioIcon, forKey: .scenarioIcon)
        try container.encode(learningLanguage, forKey: .learningLanguage)
        try container.encode(conversationNodes, forKey: .conversationNodes)
        try container.encode(date, forKey: .date)

        // Encode dictionary as array of tuples
        let titleData = scenarioTitle.map { [$0.key.rawValue, $0.value] }
        try container.encode(titleData, forKey: .scenarioTitleData)
    }
}

// MARK: - Conversation History Manager
class ConversationHistoryManager: ObservableObject {
    static let shared = ConversationHistoryManager()

    @Published var histories: [ConversationHistory] = []

    private let saveKey = "conversationHistories"
    private let userDefaults = UserDefaults.standard

    private init() {
        loadHistories()
    }

    // Save a new conversation history
    func saveHistory(_ history: ConversationHistory) {
        histories.insert(history, at: 0) // Add to the beginning
        saveToUserDefaults()
    }

    // Delete a conversation history
    func deleteHistory(_ history: ConversationHistory) {
        histories.removeAll { $0.id == history.id }
        saveToUserDefaults()
    }

    // Delete all histories for a specific scenario
    func deleteHistoriesForScenario(_ scenarioId: String) {
        histories.removeAll { $0.scenarioId == scenarioId }
        saveToUserDefaults()
    }

    // Get histories grouped by scenario
    func historiesGroupedByScenario() -> [(scenarioId: String, scenarioTitle: [Language: String], scenarioIcon: String, learningLanguage: Language, histories: [ConversationHistory])] {
        let grouped = Dictionary(grouping: histories) { $0.scenarioId }

        return grouped.map { (key, value) in
            let sortedHistories = value.sorted { $0.date > $1.date }
            let firstHistory = sortedHistories.first!
            return (
                scenarioId: key,
                scenarioTitle: firstHistory.scenarioTitle,
                scenarioIcon: firstHistory.scenarioIcon,
                learningLanguage: firstHistory.learningLanguage,
                histories: sortedHistories
            )
        }.sorted { group1, group2 in
            // Sort by most recent conversation in each group
            let date1 = group1.histories.first?.date ?? Date.distantPast
            let date2 = group2.histories.first?.date ?? Date.distantPast
            return date1 > date2
        }
    }

    // Get histories for a specific scenario
    func historiesForScenario(_ scenarioId: String) -> [ConversationHistory] {
        return histories
            .filter { $0.scenarioId == scenarioId }
            .sorted { $0.date > $1.date }
    }

    // Clear all histories
    func clearAllHistories() {
        histories.removeAll()
        saveToUserDefaults()
    }

    // MARK: - Persistence

    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(histories) {
            userDefaults.set(encoded, forKey: saveKey)
        }
    }

    private func loadHistories() {
        if let data = userDefaults.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([ConversationHistory].self, from: data) {
            histories = decoded
        }
    }
}
