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
        guard conversationTurns.count > 0 else { return [] }

        var nodes: [ConversationNode] = []
        var index = 0

        // 첫 번째 턴이 사용자 발화면 건너뜀 (시작 문장으로 사용됨)
        if conversationTurns[0].speaker == .user {
            index = 1
        }

        // 나머지 턴들을 노드로 변환
        while index < conversationTurns.count {
            let turn = conversationTurns[index]

            // 랜덤으로 옵션 선택
            let selectedOption = turn.randomOption()

            var translations: [Language: String] = [:]
            translations[nativeLanguage] = selectedOption.nativeText

            var responses: [ConversationNode]? = nil

            // 다음 턴이 있으면 responses로 추가
            if index + 1 < conversationTurns.count {
                let nextTurn = conversationTurns[index + 1]
                let nextSelectedOption = nextTurn.randomOption()
                var nextTranslations: [Language: String] = [:]
                nextTranslations[nativeLanguage] = nextSelectedOption.nativeText

                var nextResponses: [ConversationNode]? = nil

                // 그 다음 턴이 있으면 계속 연결
                if index + 2 < conversationTurns.count {
                    nextResponses = buildRemainingNodes(from: index + 2)
                }

                responses = [
                    ConversationNode(
                        id: "\(id)-turn\(index + 1)",
                        speaker: nextTurn.speaker == .user ? .user : .native,
                        text: nextSelectedOption.learningText,
                        translations: nextTranslations,
                        responses: nextResponses
                    )
                ]
            }

            nodes.append(
                ConversationNode(
                    id: "\(id)-turn\(index)",
                    speaker: turn.speaker == .user ? .user : .native,
                    text: selectedOption.learningText,
                    translations: translations,
                    responses: responses
                )
            )

            break  // 첫 번째 노드만 생성하고 나머지는 responses로 연결됨
        }

        return nodes
    }

    private func buildRemainingNodes(from startIndex: Int) -> [ConversationNode] {
        guard startIndex < conversationTurns.count else { return [] }

        let turn = conversationTurns[startIndex]
        let selectedOption = turn.randomOption()
        var translations: [Language: String] = [:]
        translations[nativeLanguage] = selectedOption.nativeText

        var responses: [ConversationNode]? = nil
        if startIndex + 1 < conversationTurns.count {
            responses = buildRemainingNodes(from: startIndex + 1)
        }

        return [
            ConversationNode(
                id: "\(id)-turn\(startIndex)",
                speaker: turn.speaker == .user ? .user : .native,
                text: selectedOption.learningText,
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

    enum TurnSpeaker: String, Codable {
        case user = "user"
        case ai = "ai"
    }

    struct TextOption: Codable {
        let nativeText: String
        let learningText: String
    }

    init(id: String = UUID().uuidString,
         speaker: TurnSpeaker,
         nativeLanguageText: String,
         learningLanguageText: String) {
        self.id = id
        self.speaker = speaker
        // 기존 단일 텍스트 지원 (하위 호환성)
        self.textOptions = [TextOption(nativeText: nativeLanguageText, learningText: learningLanguageText)]
    }

    init(id: String = UUID().uuidString,
         speaker: TurnSpeaker,
         textOptions: [TextOption]) {
        self.id = id
        self.speaker = speaker
        self.textOptions = textOptions.isEmpty ? [TextOption(nativeText: "", learningText: "")] : textOptions
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
