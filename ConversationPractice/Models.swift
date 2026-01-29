import Foundation

// MARK: - 언어 모델 (모국어 & 학습 언어 공통)
enum Language: String, CaseIterable, Identifiable, Codable {
    // Original 6 languages with full UI translation
    case korean = "ko-KR"
    case english = "en-US"
    case japanese = "ja-JP"
    case chinese = "zh-CN"
    case spanish = "es-ES"
    case indonesian = "id-ID"

    // Additional languages supported by Translation framework
    case arabic = "ar-SA"
    case dutch = "nl-NL"
    case french = "fr-FR"
    case german = "de-DE"
    case hindi = "hi-IN"
    case italian = "it-IT"
    case polish = "pl-PL"
    case portuguese = "pt-BR"
    case russian = "ru-RU"
    case thai = "th-TH"
    case turkish = "tr-TR"
    case ukrainian = "uk-UA"
    case vietnamese = "vi-VN"
    case swedish = "sv-SE"
    case danish = "da-DK"
    case norwegian = "nb-NO"
    case finnish = "fi-FI"
    case czech = "cs-CZ"
    case hebrew = "he-IL"
    case romanian = "ro-RO"

    var id: String { rawValue }

    // Only original 6 languages have complete UI translation
    var hasFullUITranslation: Bool {
        switch self {
        case .korean, .english, .japanese, .chinese, .spanish, .indonesian:
            return true
        default:
            return false
        }
    }

    var displayName: String {
        switch self {
        case .korean: return "한국어"
        case .english: return "English"
        case .japanese: return "日本語"
        case .chinese: return "中文"
        case .spanish: return "Español"
        case .indonesian: return "Bahasa Indonesia"
        case .arabic: return "العربية"
        case .dutch: return "Nederlands"
        case .french: return "Français"
        case .german: return "Deutsch"
        case .hindi: return "हिन्दी"
        case .italian: return "Italiano"
        case .polish: return "Polski"
        case .portuguese: return "Português"
        case .russian: return "Русский"
        case .thai: return "ไทย"
        case .turkish: return "Türkçe"
        case .ukrainian: return "Українська"
        case .vietnamese: return "Tiếng Việt"
        case .swedish: return "Svenska"
        case .danish: return "Dansk"
        case .norwegian: return "Norsk"
        case .finnish: return "Suomi"
        case .czech: return "Čeština"
        case .hebrew: return "עברית"
        case .romanian: return "Română"
        }
    }

    var flag: String {
        switch self {
        case .korean: return "🇰🇷"
        case .english: return "🇺🇸"
        case .japanese: return "🇯🇵"
        case .chinese: return "🇨🇳"
        case .spanish: return "🇪🇸"
        case .indonesian: return "🇮🇩"
        case .arabic: return "🇸🇦"
        case .dutch: return "🇳🇱"
        case .french: return "🇫🇷"
        case .german: return "🇩🇪"
        case .hindi: return "🇮🇳"
        case .italian: return "🇮🇹"
        case .polish: return "🇵🇱"
        case .portuguese: return "🇧🇷"
        case .russian: return "🇷🇺"
        case .thai: return "🇹🇭"
        case .turkish: return "🇹🇷"
        case .ukrainian: return "🇺🇦"
        case .vietnamese: return "🇻🇳"
        case .swedish: return "🇸🇪"
        case .danish: return "🇩🇰"
        case .norwegian: return "🇳🇴"
        case .finnish: return "🇫🇮"
        case .czech: return "🇨🇿"
        case .hebrew: return "🇮🇱"
        case .romanian: return "🇷🇴"
        }
    }
}

// MARK: - 다국어 인터페이스 텍스트
struct LocalizedText {
    let nativeLanguage: Language

    // 모국어 선택 화면
    var selectNativeLanguage: String {
        switch nativeLanguage {
        case .korean: return "모국어 선택"
        case .english: return "Select Your Language"
        case .japanese: return "母国語を選択"
        case .chinese: return "选择母语"
        case .spanish: return "Selecciona tu idioma"
        case .indonesian: return "Pilih Bahasa Anda"
        default: return "Select Your Language"
        }
    }

    var whatIsYourNativeLanguage: String {
        switch nativeLanguage {
        case .korean: return "모국어가 무엇인가요?"
        case .english: return "What is your native language?"
        case .japanese: return "母国語は何ですか？"
        case .chinese: return "您的母语是什么？"
        case .spanish: return "¿Cuál es tu idioma nativo?"
        case .indonesian: return "Apa bahasa ibu Anda?"
        default: return "What is your native language?"
        }
    }

    // 학습 언어 선택 화면
    var selectLearningLanguage: String {
        switch nativeLanguage {
        case .korean: return "학습 언어 선택"
        case .english: return "Select Language to Learn"
        case .japanese: return "学習言語を選択"
        case .chinese: return "选择学习语言"
        case .spanish: return "Selecciona idioma a aprender"
        case .indonesian: return "Pilih Bahasa untuk Dipelajari"
        default: return "Select Language to Learn"
        }
    }

    var whatDoYouWantToLearn: String {
        switch nativeLanguage {
        case .korean: return "어떤 언어를 배우고 싶으세요?"
        case .english: return "What language do you want to learn?"
        case .japanese: return "何語を学びたいですか？"
        case .chinese: return "您想学习什么语言？"
        case .spanish: return "¿Qué idioma quieres aprender?"
        case .indonesian: return "Bahasa apa yang ingin Anda pelajari?"
        default: return "What language do you want to learn?"
        }
    }

    // 모드 선택 화면
    var selectMode: String {
        switch nativeLanguage {
        case .korean: return "연습 모드 선택"
        case .english: return "Select Practice Mode"
        case .japanese: return "練習モードを選択"
        case .chinese: return "选择练习模式"
        case .spanish: return "Selecciona modo de práctica"
        case .indonesian: return "Pilih Mode Latihan"
        default: return "Select Practice Mode"
        }
    }

    var practice: String {
        switch nativeLanguage {
        case .korean: return "연습"
        case .english: return "Practice"
        case .japanese: return "練習"
        case .chinese: return "练习"
        case .spanish: return "Práctica"
        case .indonesian: return "Latihan"
        default: return "Practice"
        }
    }

    // 대화 화면
    var freeConversation: String {
        switch nativeLanguage {
        case .korean: return "자유 대화"
        case .english: return "Free Conversation"
        case .japanese: return "フリートーク"
        case .chinese: return "自由对话"
        case .spanish: return "Conversación libre"
        case .indonesian: return "Percakapan Bebas"
        default: return "Free Conversation"
        }
    }

    var freeConversationDesc: String {
        switch nativeLanguage {
        case .korean: return "AI와 자유롭게 대화하며 연습"
        case .english: return "Practice by chatting freely with AI"
        case .japanese: return "AIと自由に会話して練習"
        case .chinese: return "与AI自由对话练习"
        case .spanish: return "Practica conversando libremente con IA"
        case .indonesian: return "Berlatih dengan berbicara bebas dengan AI"
        default: return "Practice by chatting freely with AI"
        }
    }

    var scenarioPractice: String {
        switch nativeLanguage {
        case .korean: return "시나리오 연습"
        case .english: return "Scenario Practice"
        case .japanese: return "シナリオ練習"
        case .chinese: return "情景练习"
        case .spanish: return "Práctica de escenarios"
        case .indonesian: return "Latihan Skenario"
        default: return "Scenario Practice"
        }
    }

    var scenarioPracticeDesc: String {
        switch nativeLanguage {
        case .korean: return "실제 상황별 대화 연습"
        case .english: return "Practice conversations for real situations"
        case .japanese: return "実際の状況での会話練習"
        case .chinese: return "实际情景对话练习"
        case .spanish: return "Practica conversaciones para situaciones reales"
        case .indonesian: return "Latihan percakapan untuk situasi nyata"
        default: return "Practice conversations for real situations"
        }
    }

    var pronunciationPractice: String {
        switch nativeLanguage {
        case .korean: return "발음 연습"
        case .english: return "Pronunciation Practice"
        case .japanese: return "発音練習"
        case .chinese: return "发音练习"
        case .spanish: return "Práctica de pronunciación"
        case .indonesian: return "Latihan Pengucapan"
        default: return "Pronunciation Practice"
        }
    }

    var pronunciationPracticeDesc: String {
        switch nativeLanguage {
        case .korean: return "정확한 발음 연습"
        case .english: return "Practice accurate pronunciation"
        case .japanese: return "正確な発音の練習"
        case .chinese: return "练习准确发音"
        case .spanish: return "Practica la pronunciación correcta"
        case .indonesian: return "Berlatih pengucapan yang akurat"
        default: return "Practice accurate pronunciation"
        }
    }

    var tapToSpeak: String {
        switch nativeLanguage {
        case .korean: return "탭하여 말하기"
        case .english: return "Tap to speak"
        case .japanese: return "タップして話す"
        case .chinese: return "点击说话"
        case .spanish: return "Toca para hablar"
        case .indonesian: return "Ketuk untuk berbicara"
        default: return "Tap to speak"
        }
    }

    var speaking: String {
        switch nativeLanguage {
        case .korean: return "말하고 있습니다..."
        case .english: return "Speaking..."
        case .japanese: return "話しています..."
        case .chinese: return "正在说话..."
        case .spanish: return "Hablando..."
        case .indonesian: return "Berbicara..."
        default: return "Speaking..."
        }
    }

    var startConversationGuide: String {
        switch nativeLanguage {
        case .korean: return "마이크 버튼을 눌러\n대화를 시작하세요"
        case .english: return "Press the microphone button\nto start conversation"
        case .japanese: return "マイクボタンを押して\n会話を始めましょう"
        case .chinese: return "按下麦克风按钮\n开始对话"
        case .spanish: return "Presiona el botón del micrófono\npara iniciar la conversación"
        case .indonesian: return "Tekan tombol mikrofon\nuntuk memulai percakapan"
        default: return "Press the microphone button\nto start conversation"
        }
    }

    var me: String {
        switch nativeLanguage {
        case .korean: return "나"
        case .english: return "Me"
        case .japanese: return "私"
        case .chinese: return "我"
        case .spanish: return "Yo"
        case .indonesian: return "Saya"
        default: return "Me"
        }
    }

    var partner: String {
        switch nativeLanguage {
        case .korean: return "상대방"
        case .english: return "Partner"
        case .japanese: return "相手"
        case .chinese: return "对方"
        case .spanish: return "Compañero"
        case .indonesian: return "Lawan bicara"
        default: return "Partner"
        }
    }

    var conversationComplete: String {
        switch nativeLanguage {
        case .korean: return "🎉 대화 완료!"
        case .english: return "🎉 Conversation Complete!"
        case .japanese: return "🎉 会話完了!"
        case .chinese: return "🎉 对话完成!"
        case .spanish: return "🎉 ¡Conversación completada!"
        case .indonesian: return "🎉 Percakapan Selesai!"
        default: return "🎉 Conversation Complete!"
        }
    }

    var practiceAgain: String {
        switch nativeLanguage {
        case .korean: return "다시 연습하기"
        case .english: return "Practice Again"
        case .japanese: return "もう一度練習"
        case .chinese: return "再练习一次"
        case .spanish: return "Practicar de nuevo"
        case .indonesian: return "Latihan Lagi"
        default: return "Practice Again"
        }
    }

    var displayModeNative: String {
        switch nativeLanguage {
        case .korean: return "모국어"
        case .english: return "Native"
        case .japanese: return "母国語"
        case .chinese: return "母语"
        case .spanish: return "Nativo"
        case .indonesian: return "Bahasa Ibu"
        default: return "Native"
        }
    }

    var displayModeLearning: String {
        switch nativeLanguage {
        case .korean: return "외국어"
        case .english: return "Learning"
        case .japanese: return "学習言語"
        case .chinese: return "学习语言"
        case .spanish: return "Aprendizaje"
        case .indonesian: return "Bahasa Belajar"
        default: return "Learning"
        }
    }

    var displayModeBoth: String {
        switch nativeLanguage {
        case .korean: return "모두"
        case .english: return "Both"
        case .japanese: return "両方"
        case .chinese: return "两者"
        case .spanish: return "Ambos"
        case .indonesian: return "Keduanya"
        default: return "Both"
        }
    }

    var sayThisPhrase: String {
        switch nativeLanguage {
        case .korean: return "이 문장을 말하세요:"
        case .english: return "Say this phrase:"
        case .japanese: return "このフレーズを言ってください:"
        case .chinese: return "请说这句话:"
        case .spanish: return "Di esta frase:"
        case .indonesian: return "Ucapkan kalimat ini:"
        default: return "Say this phrase:"
        }
    }

    var greatJob: String {
        switch nativeLanguage {
        case .korean: return "잘했습니다! ✓"
        case .english: return "Great job! ✓"
        case .japanese: return "よくできました! ✓"
        case .chinese: return "做得好! ✓"
        case .spanish: return "¡Bien hecho! ✓"
        case .indonesian: return "Bagus sekali! ✓"
        default: return "Great job! ✓"
        }
    }

    var tryAgain: String {
        switch nativeLanguage {
        case .korean: return "다시 시도해보세요"
        case .english: return "Try again"
        case .japanese: return "もう一度試してください"
        case .chinese: return "请再试一次"
        case .spanish: return "Inténtalo de nuevo"
        case .indonesian: return "Coba lagi"
        default: return "Try again"
        }
    }

    var settings: String {
        switch nativeLanguage {
        case .korean: return "설정"
        case .english: return "Settings"
        case .japanese: return "設定"
        case .chinese: return "设置"
        case .spanish: return "Configuración"
        case .indonesian: return "Pengaturan"
        default: return "Settings"
        }
    }

    var nativeLanguageLabel: String {
        switch nativeLanguage {
        case .korean: return "모국어"
        case .english: return "Native Language"
        case .japanese: return "母国語"
        case .chinese: return "母语"
        case .spanish: return "Idioma nativo"
        case .indonesian: return "Bahasa Ibu"
        default: return "Native Language"
        }
    }

    var learningLanguageLabel: String {
        switch nativeLanguage {
        case .korean: return "학습 언어"
        case .english: return "Learning Language"
        case .japanese: return "学習言語"
        case .chinese: return "学习语言"
        case .spanish: return "Idioma de aprendizaje"
        case .indonesian: return "Bahasa Belajar"
        default: return "Learning Language"
        }
    }

    var resetSettings: String {
        switch nativeLanguage {
        case .korean: return "설정 초기화"
        case .english: return "Reset Settings"
        case .japanese: return "設定をリセット"
        case .chinese: return "重置设置"
        case .spanish: return "Restablecer configuración"
        case .indonesian: return "Reset Pengaturan"
        default: return "Reset Settings"
        }
    }

    var done: String {
        switch nativeLanguage {
        case .korean: return "완료"
        case .english: return "Done"
        case .japanese: return "完了"
        case .chinese: return "完成"
        case .spanish: return "Listo"
        case .indonesian: return "Selesai"
        default: return "Done"
        }
    }

    var appName: String {
        switch nativeLanguage {
        case .korean: return "스픽플로우"
        case .english: return "SpeakFlow"
        case .japanese: return "スピークフロー"
        case .chinese: return "SpeakFlow"
        case .spanish: return "SpeakFlow"
        case .indonesian: return "SpeakFlow"
        default: return "SpeakFlow"
        }
    }

    var appSubtitle: String {
        switch nativeLanguage {
        case .korean: return "실제 상황에서의 다양한 답변에 대응하는 연습"
        case .english: return "Practice responding to various answers in real situations"
        case .japanese: return "実際の状況でさまざまな回答に対応する練習"
        case .chinese: return "练习在真实情况下应对各种回答"
        case .spanish: return "Practica respondiendo a varias respuestas en situaciones reales"
        case .indonesian: return "Berlatih merespons berbagai jawaban dalam situasi nyata"
        default: return "Practice responding to various answers in real situations"
        }
    }

    var myScenarios: String {
        switch nativeLanguage {
        case .korean: return "내 시나리오"
        case .english: return "My Scenarios"
        case .japanese: return "マイシナリオ"
        case .chinese: return "我的场景"
        case .spanish: return "Mis escenarios"
        case .indonesian: return "Skenario Saya"
        default: return "My Scenarios"
        }
    }

    var builtInScenarios: String {
        switch nativeLanguage {
        case .korean: return "상황별 시나리오"
        case .english: return "Scenarios by Situation"
        case .japanese: return "状況別シナリオ"
        case .chinese: return "按情况分类的场景"
        case .spanish: return "Escenarios por situación"
        case .indonesian: return "Skenario Berdasarkan Situasi"
        default: return "Scenarios by Situation"
        }
    }
}

// MARK: - 연습 모드 모델
enum PracticeMode: String, CaseIterable, Identifiable {
    case freeConversation = "free"
    case scenario = "scenario"
    case pronunciation = "pronunciation"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .freeConversation: return "bubble.left.and.bubble.right"
        case .scenario: return "theatermasks"
        case .pronunciation: return "waveform"
        }
    }

    func displayName(for native: Language) -> String {
        let text = LocalizedText(nativeLanguage: native)
        switch self {
        case .freeConversation: return text.freeConversation
        case .scenario: return text.scenarioPractice
        case .pronunciation: return text.pronunciationPractice
        }
    }

    func description(for native: Language) -> String {
        let text = LocalizedText(nativeLanguage: native)
        switch self {
        case .freeConversation: return text.freeConversationDesc
        case .scenario: return text.scenarioPracticeDesc
        case .pronunciation: return text.pronunciationPracticeDesc
        }
    }
}

// MARK: - 대화 노드 모델
struct ConversationNode: Identifiable {
    let id: String
    let speaker: Speaker
    let text: String                           // 학습 언어 텍스트
    let translations: [Language: String]       // 모국어별 번역
    let responses: [ConversationNode]?

    enum Speaker: String, Codable {
        case user = "user"
        case native = "native"
    }

    // 특정 모국어에 맞는 번역 반환
    func translation(for language: Language) -> String? {
        return translations[language]
    }
}

// MARK: - Codable Support for ConversationNode
extension ConversationNode: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, speaker, text, responses
        case translationsData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        speaker = try container.decode(Speaker.self, forKey: .speaker)
        text = try container.decode(String.self, forKey: .text)
        responses = try container.decodeIfPresent([ConversationNode].self, forKey: .responses)

        // Decode translations dictionary
        let translationsData = try container.decode([[String]].self, forKey: .translationsData)
        var decodedTranslations: [Language: String] = [:]
        for item in translationsData {
            if item.count == 2,
               let language = Language(rawValue: item[0]) {
                decodedTranslations[language] = item[1]
            }
        }
        translations = decodedTranslations
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(speaker, forKey: .speaker)
        try container.encode(text, forKey: .text)
        try container.encodeIfPresent(responses, forKey: .responses)

        // Encode translations dictionary
        let translationsData = translations.map { [$0.key.rawValue, $0.value] }
        try container.encode(translationsData, forKey: .translationsData)
    }
}

// MARK: - 시나리오 카테고리
enum ScenarioCategory: String, CaseIterable, Identifiable {
    case airport = "airport"
    case hotel = "hotel"
    case restaurant = "restaurant"
    case transportation = "transportation"
    case shopping = "shopping"
    case tourism = "tourism"
    case emergency = "emergency"
    case casual = "casual"
    case basic = "basic"

    var id: String { rawValue }

    func getName(for language: Language) -> String {
        switch self {
        case .airport:
            switch language {
            case .korean: return "공항"
            case .english: return "Airport"
            case .japanese: return "空港"
            case .chinese: return "机场"
            case .spanish: return "Aeropuerto"
            case .indonesian: return "Bandara"
            default: return "Airport"
            }
        case .hotel:
            switch language {
            case .korean: return "숙소"
            case .english: return "Accommodation"
            case .japanese: return "宿泊"
            case .chinese: return "住宿"
            case .spanish: return "Alojamiento"
            case .indonesian: return "Akomodasi"
            default: return "Accommodation"
            }
        case .restaurant:
            switch language {
            case .korean: return "식당"
            case .english: return "Restaurant"
            case .japanese: return "レストラン"
            case .chinese: return "餐厅"
            case .spanish: return "Restaurante"
            case .indonesian: return "Restoran"
            default: return "Restaurant"
            }
        case .transportation:
            switch language {
            case .korean: return "교통"
            case .english: return "Transportation"
            case .japanese: return "交通"
            case .chinese: return "交通"
            case .spanish: return "Transporte"
            case .indonesian: return "Transportasi"
            default: return "Transportation"
            }
        case .shopping:
            switch language {
            case .korean: return "쇼핑"
            case .english: return "Shopping"
            case .japanese: return "ショッピング"
            case .chinese: return "购物"
            case .spanish: return "Compras"
            case .indonesian: return "Belanja"
            default: return "Shopping"
            }
        case .tourism:
            switch language {
            case .korean: return "관광"
            case .english: return "Tourism"
            case .japanese: return "観光"
            case .chinese: return "旅游"
            case .spanish: return "Turismo"
            case .indonesian: return "Wisata"
            default: return "Tourism"
            }
        case .emergency:
            switch language {
            case .korean: return "긴급상황"
            case .english: return "Emergency"
            case .japanese: return "緊急"
            case .chinese: return "紧急情况"
            case .spanish: return "Emergencia"
            case .indonesian: return "Darurat"
            default: return "Emergency"
            }
        case .casual:
            switch language {
            case .korean: return "일상대화"
            case .english: return "Casual"
            case .japanese: return "日常会話"
            case .chinese: return "日常对话"
            case .spanish: return "Casual"
            case .indonesian: return "Percakapan Santai"
            default: return "Casual"
            }
        case .basic:
            switch language {
            case .korean: return "기본"
            case .english: return "Basic"
            case .japanese: return "基本"
            case .chinese: return "基础"
            case .spanish: return "Básico"
            case .indonesian: return "Dasar"
            default: return "Basic"
            }
        }
    }

    var icon: String {
        switch self {
        case .airport: return "✈️"
        case .hotel: return "🏨"
        case .restaurant: return "🍽️"
        case .transportation: return "🚗"
        case .shopping: return "🛍️"
        case .tourism: return "🗺️"
        case .emergency: return "🚨"
        case .casual: return "💬"
        case .basic: return "📚"
        }
    }
}

// MARK: - 시나리오 모델
struct Scenario: Identifiable {
    let id: String
    let learningLanguage: Language             // 이 시나리오의 학습 언어
    let category: ScenarioCategory             // 시나리오 카테고리
    let icon: String
    let title: [Language: String]              // 모국어별 시나리오 제목
    let description: [Language: String]        // 모국어별 설명
    let startingPhrase: String                 // 학습 언어로 된 시작 문장
    let startingPhraseTranslations: [Language: String]  // 모국어별 번역
    let conversationTree: [ConversationNode]

    // 특정 모국어에 맞는 제목 반환
    func getTitle(for language: Language) -> String {
        return title[language] ?? title[.english] ?? ""
    }

    // 특정 모국어에 맞는 설명 반환
    func getDescription(for language: Language) -> String {
        return description[language] ?? description[.english] ?? ""
    }

    // 시작 문장의 번역 반환
    func getStartingPhraseTranslation(for language: Language) -> String? {
        return startingPhraseTranslations[language]
    }
}

// MARK: - 시나리오 데이터
class ScenarioData {
    // 학습 언어별 시나리오 가져오기
    static func scenarios(for learningLanguage: Language) -> [Scenario] {
        switch learningLanguage {
        case .indonesian:
            return indonesianScenarios
        case .korean:
            return koreanScenarios
        case .english:
            return englishScenarios
        case .japanese:
            return japaneseScenarios
        case .chinese:
            return chineseScenarios
        case .spanish:
            return spanishScenarios
        // New languages - no pre-built scenarios yet, but users can create/import custom scenarios
        case .arabic, .dutch, .french, .german, .hindi, .italian, .polish,
             .portuguese, .russian, .thai, .turkish, .ukrainian, .vietnamese,
             .swedish, .danish, .norwegian, .finnish, .czech, .hebrew, .romanian:
            return []
        }
    }

}
