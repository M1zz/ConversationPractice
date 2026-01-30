import Foundation

// MARK: - Custom Scenario Models
struct CustomScenario: Identifiable, Codable {
    let id: String
    let createdAt: Date
    let nativeLanguage: Language  // 시나리오를 작성한 언어
    let learningLanguage: Language  // 연습할 언어
    let icon: String
    let title: String  // 모국어로 작성된 제목
    let description: String  // 모국어로 작성된 설명
    let conversationTurns: [ConversationTurn]

    init(id: String = UUID().uuidString,
         createdAt: Date = Date(),
         nativeLanguage: Language,
         learningLanguage: Language,
         icon: String,
         title: String,
         description: String,
         conversationTurns: [ConversationTurn]) {
        self.id = id
        self.createdAt = createdAt
        self.nativeLanguage = nativeLanguage
        self.learningLanguage = learningLanguage
        self.icon = icon
        self.title = title
        self.description = description
        self.conversationTurns = conversationTurns
    }

    // Scenario로 변환
    func toScenario() -> Scenario {
        // 첫 번째 사용자 발화를 시작 문장으로 사용 (랜덤 옵션 선택)
        let firstUserTurn = conversationTurns.first(where: { $0.speaker == .user })
        let selectedOption = firstUserTurn?.randomOption()
        let startingPhrase = selectedOption?.learningText ?? ""
        let startingTranslation = selectedOption?.nativeText ?? ""

        // 대화 트리 생성
        let conversationTree = buildConversationTree()

        // 제목과 설명을 딕셔너리로 변환
        var titleDict: [Language: String] = [:]
        titleDict[nativeLanguage] = title

        var descDict: [Language: String] = [:]
        descDict[nativeLanguage] = description

        var startingPhraseTranslations: [Language: String] = [:]
        startingPhraseTranslations[nativeLanguage] = startingTranslation

        return Scenario(
            id: id,
            learningLanguage: learningLanguage,
            category: .casual,
            icon: icon,
            title: titleDict,
            description: descDict,
            startingPhrase: startingPhrase,
            startingPhraseTranslations: startingPhraseTranslations,
            conversationTree: conversationTree
        )
    }

    private func buildConversationTree() -> [ConversationNode] {
        guard !conversationTurns.isEmpty else { return [] }

        var startIndex = 0

        // 첫 번째 턴이 사용자 발화면 건너뜀 (시작 문장으로 사용됨)
        if conversationTurns[0].speaker == .user {
            startIndex = 1
        }

        return buildNodes(from: Array(conversationTurns.dropFirst(startIndex)))
    }

    private func buildNodes(from turns: [ConversationTurn]) -> [ConversationNode] {
        guard let firstTurn = turns.first else { return [] }

        // 분기가 있는 경우: 각 분기별로 별도 노드 생성
        if let branches = firstTurn.branches, !branches.isEmpty {
            return branches.map { branch in
                let optionIndex = min(branch.optionIndex, firstTurn.textOptions.count - 1)
                let option = firstTurn.textOptions[max(0, optionIndex)]

                var translations: [Language: String] = [:]
                translations[nativeLanguage] = option.nativeText

                // 분기의 childTurns를 재귀적으로 변환
                let childNodes = buildNodes(from: branch.childTurns)

                return ConversationNode(
                    id: "\(id)-\(firstTurn.id)-branch\(branch.id)",
                    speaker: firstTurn.speaker == .user ? .user : .native,
                    text: option.learningText,
                    translations: translations,
                    responses: childNodes.isEmpty ? nil : childNodes
                )
            }
        }

        // 분기 없음: 선형 진행
        let option = firstTurn.textOptions.first ?? ConversationTurn.TextOption(nativeText: "", learningText: "")
        var translations: [Language: String] = [:]
        translations[nativeLanguage] = option.nativeText

        let remaining = Array(turns.dropFirst())
        let responses = remaining.isEmpty ? nil : buildNodes(from: remaining)

        return [
            ConversationNode(
                id: "\(id)-\(firstTurn.id)",
                speaker: firstTurn.speaker == .user ? .user : .native,
                text: option.learningText,
                translations: translations,
                responses: responses
            )
        ]
    }
}

struct ConversationTurn: Identifiable, Codable {
    let id: String
    let speaker: TurnSpeaker
    let textOptions: [TextOption]  // 여러 옵션 지원
    let branches: [BranchTurn]?    // 분기 경로들

    enum TurnSpeaker: String, Codable {
        case user = "user"
        case ai = "ai"
    }

    struct TextOption: Codable {
        let nativeText: String
        let learningText: String
    }

    struct BranchTurn: Codable {
        let id: String
        let label: String
        let optionIndex: Int
        let childTurns: [ConversationTurn]

        init(id: String = UUID().uuidString, label: String, optionIndex: Int, childTurns: [ConversationTurn]) {
            self.id = id
            self.label = label
            self.optionIndex = optionIndex
            self.childTurns = childTurns
        }
    }

    init(id: String = UUID().uuidString,
         speaker: TurnSpeaker,
         nativeLanguageText: String,
         learningLanguageText: String) {
        self.id = id
        self.speaker = speaker
        // 기존 단일 텍스트 지원 (하위 호환성)
        self.textOptions = [TextOption(nativeText: nativeLanguageText, learningText: learningLanguageText)]
        self.branches = nil
    }

    init(id: String = UUID().uuidString,
         speaker: TurnSpeaker,
         textOptions: [TextOption],
         branches: [BranchTurn]? = nil) {
        self.id = id
        self.speaker = speaker
        self.textOptions = textOptions.isEmpty ? [TextOption(nativeText: "", learningText: "")] : textOptions
        self.branches = branches
    }

    // 기존 코드 호환성을 위한 computed properties
    var nativeLanguageText: String {
        textOptions.first?.nativeText ?? ""
    }

    var learningLanguageText: String {
        textOptions.first?.learningText ?? ""
    }

    // 랜덤으로 옵션 선택
    func randomOption() -> TextOption {
        textOptions.randomElement() ?? TextOption(nativeText: "", learningText: "")
    }

    // 분기가 있는지 확인
    var hasBranches: Bool {
        if let branches = branches, !branches.isEmpty {
            return true
        }
        return false
    }
}

// MARK: - Custom Scenario Manager
class CustomScenarioManager: ObservableObject {
    static let shared = CustomScenarioManager()

    @Published var customScenarios: [CustomScenario] = []

    private let userDefaultsKey = "customScenarios"

    private init() {
        loadScenarios()
    }

    func saveScenario(_ scenario: CustomScenario) {
        if let index = customScenarios.firstIndex(where: { $0.id == scenario.id }) {
            customScenarios[index] = scenario
        } else {
            customScenarios.append(scenario)
        }
        persistScenarios()
    }

    func deleteScenario(_ scenario: CustomScenario) {
        customScenarios.removeAll { $0.id == scenario.id }
        persistScenarios()
    }

    func scenarios(for learningLanguage: Language) -> [CustomScenario] {
        return customScenarios.filter { $0.learningLanguage == learningLanguage }
    }

    private func persistScenarios() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(customScenarios) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    private func loadScenarios() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([CustomScenario].self, from: data) {
                customScenarios = decoded
            }
        }
    }
}
