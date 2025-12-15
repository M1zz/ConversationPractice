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

    enum Speaker: String {
        case user = "user"
        case native = "native"
    }

    // 특정 모국어에 맞는 번역 반환
    func translation(for language: Language) -> String? {
        return translations[language]
    }
}

// MARK: - 시나리오 모델
struct Scenario: Identifiable {
    let id: String
    let learningLanguage: Language             // 이 시나리오의 학습 언어
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

    // MARK: - 인도네시아어 시나리오
    static let indonesianScenarios: [Scenario] = [
        Scenario(
            id: "id-bathroom",
            learningLanguage: .indonesian,
            icon: "🚻",
            title: [
                .korean: "화장실 찾기",
                .english: "Finding the Bathroom",
                .japanese: "トイレを探す",
                .chinese: "找厕所",
                .spanish: "Buscar el baño"
            ],
            description: [
                .korean: "화장실 위치를 물어보는 연습",
                .english: "Practice asking for bathroom location",
                .japanese: "トイレの場所を尋ねる練習",
                .chinese: "练习询问厕所位置",
                .spanish: "Practica preguntar por el baño"
            ],
            startingPhrase: "Di mana toilet?",
            startingPhraseTranslations: [
                .korean: "화장실이 어디에요?",
                .english: "Where is the bathroom?",
                .japanese: "トイレはどこですか？",
                .chinese: "厕所在哪里？",
                .spanish: "¿Dónde está el baño?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-response1",
                    speaker: .native,
                    text: "Di sana, belok kiri terus jalan lurus.",
                    translations: [
                        .korean: "저기요, 왼쪽으로 돌아서 직진하세요.",
                        .english: "Over there, turn left and go straight.",
                        .japanese: "あそこです、左に曲がってまっすぐ行ってください。",
                        .chinese: "在那边，左转然后直走。",
                        .spanish: "Por allí, gira a la izquierda y sigue recto."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-followup1-1",
                            speaker: .user,
                            text: "Terima kasih!",
                            translations: [
                                .korean: "감사합니다!",
                                .english: "Thank you!",
                                .japanese: "ありがとうございます！",
                                .chinese: "谢谢！",
                                .spanish: "¡Gracias!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-end1-1",
                                    speaker: .native,
                                    text: "Sama-sama!",
                                    translations: [
                                        .korean: "천만에요!",
                                        .english: "You're welcome!",
                                        .japanese: "どういたしまして！",
                                        .chinese: "不客气！",
                                        .spanish: "¡De nada!"
                                    ],
                                    responses: nil
                                )
                            ]
                        ),
                        ConversationNode(
                            id: "id-followup1-2",
                            speaker: .user,
                            text: "Apakah jauh dari sini?",
                            translations: [
                                .korean: "여기서 멀어요?",
                                .english: "Is it far from here?",
                                .japanese: "ここから遠いですか？",
                                .chinese: "离这里远吗？",
                                .spanish: "¿Está lejos de aquí?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-clarify1-2",
                                    speaker: .native,
                                    text: "Tidak, hanya satu menit jalan kaki.",
                                    translations: [
                                        .korean: "아니요, 걸어서 1분이에요.",
                                        .english: "No, just one minute walk.",
                                        .japanese: "いいえ、歩いて1分です。",
                                        .chinese: "不远，走路只要一分钟。",
                                        .spanish: "No, solo un minuto caminando."
                                    ],
                                    responses: [
                                        ConversationNode(
                                            id: "id-end1-2",
                                            speaker: .user,
                                            text: "Baik, terima kasih!",
                                            translations: [
                                                .korean: "네, 감사합니다!",
                                                .english: "Okay, thank you!",
                                                .japanese: "わかりました、ありがとう！",
                                                .chinese: "好的，谢谢！",
                                                .spanish: "Vale, ¡gracias!"
                                            ],
                                            responses: nil
                                        )
                                    ]
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ordering",
            learningLanguage: .indonesian,
            icon: "🍜",
            title: [
                .korean: "음식 주문하기",
                .english: "Ordering Food",
                .japanese: "料理を注文する",
                .chinese: "点餐",
                .spanish: "Pedir comida"
            ],
            description: [
                .korean: "식당에서 음식을 주문하는 연습",
                .english: "Practice ordering food at a restaurant",
                .japanese: "レストランで料理を注文する練習",
                .chinese: "练习在餐厅点餐",
                .spanish: "Practica pedir comida en un restaurante"
            ],
            startingPhrase: "Saya mau pesan.",
            startingPhraseTranslations: [
                .korean: "주문하고 싶어요.",
                .english: "I'd like to order.",
                .japanese: "注文したいです。",
                .chinese: "我想点餐。",
                .spanish: "Quiero pedir."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-order-response1",
                    speaker: .native,
                    text: "Ya, mau pesan apa?",
                    translations: [
                        .korean: "네, 뭘 주문하시겠어요?",
                        .english: "Yes, what would you like to order?",
                        .japanese: "はい、何を注文しますか？",
                        .chinese: "好的，您想点什么？",
                        .spanish: "Sí, ¿qué quiere pedir?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-order-followup1-1",
                            speaker: .user,
                            text: "Nasi goreng satu.",
                            translations: [
                                .korean: "나시고랭 하나요.",
                                .english: "One fried rice please.",
                                .japanese: "ナシゴレン一つください。",
                                .chinese: "一份炒饭。",
                                .spanish: "Un arroz frito."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-order-clarify1-1",
                                    speaker: .native,
                                    text: "Mau pedas atau tidak?",
                                    translations: [
                                        .korean: "매운 거 괜찮으세요?",
                                        .english: "Spicy or not?",
                                        .japanese: "辛いのは大丈夫ですか？",
                                        .chinese: "要辣的还是不辣的？",
                                        .spanish: "¿Picante o no?"
                                    ],
                                    responses: [
                                        ConversationNode(
                                            id: "id-order-end1-1a",
                                            speaker: .user,
                                            text: "Tidak pedas, terima kasih.",
                                            translations: [
                                                .korean: "안 매운 걸로요, 감사합니다.",
                                                .english: "Not spicy, thank you.",
                                                .japanese: "辛くないのでお願いします。",
                                                .chinese: "不要辣的，谢谢。",
                                                .spanish: "No picante, gracias."
                                            ],
                                            responses: nil
                                        ),
                                        ConversationNode(
                                            id: "id-order-end1-1b",
                                            speaker: .user,
                                            text: "Pedas sedikit saja.",
                                            translations: [
                                                .korean: "조금만 맵게 해주세요.",
                                                .english: "Just a little spicy.",
                                                .japanese: "少しだけ辛くしてください。",
                                                .chinese: "稍微辣一点就好。",
                                                .spanish: "Solo un poco picante."
                                            ],
                                            responses: nil
                                        )
                                    ]
                                )
                            ]
                        )
                    ]
                )
            ]
        ),

        // MARK: - 공항/비행기 카테고리
        Scenario(
            id: "id-airport-checkin",
            learningLanguage: .indonesian,
            icon: "✈️",
            title: [
                .korean: "공항 체크인",
                .english: "Airport Check-in",
                .japanese: "空港チェックイン",
                .chinese: "机场值机",
                .spanish: "Check-in en aeropuerto"
            ],
            description: [
                .korean: "공항에서 체크인하는 연습",
                .english: "Practice checking in at the airport",
                .japanese: "空港でチェックインする練習",
                .chinese: "练习在机场办理值机",
                .spanish: "Practica el check-in en el aeropuerto"
            ],
            startingPhrase: "Saya mau check-in.",
            startingPhraseTranslations: [
                .korean: "체크인하고 싶어요.",
                .english: "I'd like to check in.",
                .japanese: "チェックインしたいです。",
                .chinese: "我想办理值机。",
                .spanish: "Quiero hacer el check-in."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-checkin-response1",
                    speaker: .native,
                    text: "Boleh lihat paspor dan tiket Anda?",
                    translations: [
                        .korean: "여권과 티켓 좀 보여주시겠어요?",
                        .english: "May I see your passport and ticket?",
                        .japanese: "パスポートとチケットを見せていただけますか？",
                        .chinese: "可以看一下您的护照和机票吗？",
                        .spanish: "¿Puedo ver su pasaporte y boleto?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-checkin-followup1",
                            speaker: .user,
                            text: "Ya, ini.",
                            translations: [
                                .korean: "네, 여기요.",
                                .english: "Yes, here you go.",
                                .japanese: "はい、どうぞ。",
                                .chinese: "好的，这是。",
                                .spanish: "Sí, aquí está."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-checkin-end1",
                                    speaker: .native,
                                    text: "Baik, ini boarding pass Anda. Gate C5.",
                                    translations: [
                                        .korean: "네, 여기 탑승권이에요. C5 게이트입니다.",
                                        .english: "Okay, here's your boarding pass. Gate C5.",
                                        .japanese: "はい、搭乗券です。ゲートC5です。",
                                        .chinese: "好的，这是您的登机牌。C5登机口。",
                                        .spanish: "Bien, aquí está su pase de abordar. Puerta C5."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-find-gate",
            learningLanguage: .indonesian,
            icon: "🚪",
            title: [
                .korean: "탑승구 찾기",
                .english: "Finding the Gate",
                .japanese: "搭乗ゲートを探す",
                .chinese: "找登机口",
                .spanish: "Buscar la puerta de embarque"
            ],
            description: [
                .korean: "탑승구 위치를 물어보는 연습",
                .english: "Practice asking for gate location",
                .japanese: "ゲートの場所を尋ねる練習",
                .chinese: "练习询问登机口位置",
                .spanish: "Practica preguntar por la puerta"
            ],
            startingPhrase: "Gate C5 di mana ya?",
            startingPhraseTranslations: [
                .korean: "C5 게이트가 어디에요?",
                .english: "Where is gate C5?",
                .japanese: "C5ゲートはどこですか？",
                .chinese: "C5登机口在哪里？",
                .spanish: "¿Dónde está la puerta C5?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-gate-response1",
                    speaker: .native,
                    text: "Lurus terus, nanti belok kanan.",
                    translations: [
                        .korean: "쭉 가다가 오른쪽으로 도세요.",
                        .english: "Go straight, then turn right.",
                        .japanese: "まっすぐ行って、右に曲がってください。",
                        .chinese: "一直走，然后右转。",
                        .spanish: "Sigue recto, luego gira a la derecha."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-gate-followup1",
                            speaker: .user,
                            text: "Kira-kira berapa menit jalan kaki?",
                            translations: [
                                .korean: "걸어서 몇 분 정도 걸려요?",
                                .english: "About how many minutes walking?",
                                .japanese: "歩いて何分くらいですか？",
                                .chinese: "走路大概几分钟？",
                                .spanish: "¿Cuántos minutos caminando?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-gate-end1",
                                    speaker: .native,
                                    text: "Lima menit saja. Tidak jauh kok.",
                                    translations: [
                                        .korean: "5분이면 돼요. 멀지 않아요.",
                                        .english: "Just five minutes. Not far.",
                                        .japanese: "5分だけです。遠くないですよ。",
                                        .chinese: "只要五分钟。不远。",
                                        .spanish: "Solo cinco minutos. No está lejos."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-flight-drink",
            learningLanguage: .indonesian,
            icon: "🥤",
            title: [
                .korean: "기내 음료 주문",
                .english: "In-flight Drink Order",
                .japanese: "機内飲み物注文",
                .chinese: "机上饮料点单",
                .spanish: "Pedir bebida en el vuelo"
            ],
            description: [
                .korean: "비행기 안에서 음료를 주문하는 연습",
                .english: "Practice ordering drinks on a flight",
                .japanese: "機内で飲み物を注文する練習",
                .chinese: "练习在飞机上点饮料",
                .spanish: "Practica pedir bebidas en el vuelo"
            ],
            startingPhrase: "Boleh minta air putih?",
            startingPhraseTranslations: [
                .korean: "물 좀 주시겠어요?",
                .english: "Can I have some water?",
                .japanese: "お水をいただけますか？",
                .chinese: "可以给我水吗？",
                .spanish: "¿Puedo tener agua?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-drink-response1",
                    speaker: .native,
                    text: "Tentu. Mau yang dingin atau biasa?",
                    translations: [
                        .korean: "물론이죠. 차가운 거요, 상온이요?",
                        .english: "Sure. Cold or room temperature?",
                        .japanese: "もちろん。冷たいのと常温、どちらがいいですか？",
                        .chinese: "当然。要冷的还是常温的？",
                        .spanish: "Claro. ¿Fría o al tiempo?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-drink-followup1",
                            speaker: .user,
                            text: "Yang dingin, terima kasih.",
                            translations: [
                                .korean: "차가운 걸로요, 감사합니다.",
                                .english: "Cold please, thank you.",
                                .japanese: "冷たいのでお願いします。",
                                .chinese: "冷的，谢谢。",
                                .spanish: "Fría por favor, gracias."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-drink-end1",
                                    speaker: .native,
                                    text: "Silakan.",
                                    translations: [
                                        .korean: "여기요.",
                                        .english: "Here you go.",
                                        .japanese: "どうぞ。",
                                        .chinese: "请。",
                                        .spanish: "Aquí tiene."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-baggage-claim",
            learningLanguage: .indonesian,
            icon: "🧳",
            title: [
                .korean: "수하물 찾기",
                .english: "Baggage Claim",
                .japanese: "荷物受取",
                .chinese: "取行李",
                .spanish: "Recogida de equipaje"
            ],
            description: [
                .korean: "수하물 찾는 곳을 물어보는 연습",
                .english: "Practice asking for baggage claim",
                .japanese: "荷物受取所を尋ねる練習",
                .chinese: "练习询问行李提取处",
                .spanish: "Practica preguntar por la recogida de equipaje"
            ],
            startingPhrase: "Permisi, baggage claim di mana?",
            startingPhraseTranslations: [
                .korean: "실례합니다, 수하물 찾는 곳이 어디에요?",
                .english: "Excuse me, where is baggage claim?",
                .japanese: "すみません、手荷物受取所はどこですか？",
                .chinese: "请问，行李提取处在哪里？",
                .spanish: "Disculpe, ¿dónde está la recogida de equipaje?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-baggage-response1",
                    speaker: .native,
                    text: "Ikut tanda panah ke bawah, ada di lantai satu.",
                    translations: [
                        .korean: "아래 화살표 따라가시면 1층에 있어요.",
                        .english: "Follow the arrows down, it's on the first floor.",
                        .japanese: "矢印を下に従ってください、1階にあります。",
                        .chinese: "跟着箭头往下走，在一楼。",
                        .spanish: "Sigue las flechas hacia abajo, está en el primer piso."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-baggage-followup1",
                            speaker: .user,
                            text: "Terima kasih banyak!",
                            translations: [
                                .korean: "정말 감사합니다!",
                                .english: "Thank you very much!",
                                .japanese: "どうもありがとうございます！",
                                .chinese: "非常感谢！",
                                .spanish: "¡Muchas gracias!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-baggage-end1",
                                    speaker: .native,
                                    text: "Sama-sama, selamat datang!",
                                    translations: [
                                        .korean: "천만에요, 환영합니다!",
                                        .english: "You're welcome, welcome!",
                                        .japanese: "どういたしまして、ようこそ！",
                                        .chinese: "不客气，欢迎！",
                                        .spanish: "¡De nada, bienvenido!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-customs",
            learningLanguage: .indonesian,
            icon: "🛃",
            title: [
                .korean: "세관 통과",
                .english: "Going Through Customs",
                .japanese: "税関通過",
                .chinese: "过海关",
                .spanish: "Pasar por la aduana"
            ],
            description: [
                .korean: "세관에서 질문에 답하는 연습",
                .english: "Practice answering customs questions",
                .japanese: "税関で質問に答える練習",
                .chinese: "练习回答海关问题",
                .spanish: "Practica responder preguntas de aduana"
            ],
            startingPhrase: "Tidak ada yang perlu dideklarasikan.",
            startingPhraseTranslations: [
                .korean: "신고할 물건이 없어요.",
                .english: "Nothing to declare.",
                .japanese: "申告するものはありません。",
                .chinese: "没有需要申报的。",
                .spanish: "Nada que declarar."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-customs-response1",
                    speaker: .native,
                    text: "Tujuan kunjungan Anda apa?",
                    translations: [
                        .korean: "방문 목적이 무엇인가요?",
                        .english: "What is the purpose of your visit?",
                        .japanese: "訪問の目的は何ですか？",
                        .chinese: "您访问的目的是什么？",
                        .spanish: "¿Cuál es el propósito de su visita?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-customs-followup1",
                            speaker: .user,
                            text: "Liburan, wisata saja.",
                            translations: [
                                .korean: "휴가요, 관광이요.",
                                .english: "Vacation, just tourism.",
                                .japanese: "休暇です、観光だけです。",
                                .chinese: "度假，只是旅游。",
                                .spanish: "Vacaciones, solo turismo."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-customs-end1",
                                    speaker: .native,
                                    text: "Baik, selamat menikmati liburan Anda.",
                                    translations: [
                                        .korean: "네, 휴가 잘 보내세요.",
                                        .english: "Okay, enjoy your vacation.",
                                        .japanese: "わかりました、良い休暇を。",
                                        .chinese: "好的，祝您假期愉快。",
                                        .spanish: "Bien, disfrute sus vacaciones."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-money-exchange",
            learningLanguage: .indonesian,
            icon: "💱",
            title: [
                .korean: "환전하기",
                .english: "Currency Exchange",
                .japanese: "両替",
                .chinese: "换钱",
                .spanish: "Cambio de moneda"
            ],
            description: [
                .korean: "돈을 환전하는 연습",
                .english: "Practice exchanging money",
                .japanese: "両替する練習",
                .chinese: "练习换钱",
                .spanish: "Practica cambiar dinero"
            ],
            startingPhrase: "Saya mau tukar uang.",
            startingPhraseTranslations: [
                .korean: "환전하고 싶어요.",
                .english: "I'd like to exchange money.",
                .japanese: "両替したいです。",
                .chinese: "我想换钱。",
                .spanish: "Quiero cambiar dinero."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-exchange-response1",
                    speaker: .native,
                    text: "Mau tukar mata uang apa?",
                    translations: [
                        .korean: "어떤 통화로 바꾸시겠어요?",
                        .english: "What currency would you like to exchange?",
                        .japanese: "何の通貨に両替しますか？",
                        .chinese: "您想换什么货币？",
                        .spanish: "¿Qué moneda quiere cambiar?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-exchange-followup1",
                            speaker: .user,
                            text: "Dolar ke rupiah.",
                            translations: [
                                .korean: "달러를 루피아로요.",
                                .english: "Dollars to rupiah.",
                                .japanese: "ドルをルピアに。",
                                .chinese: "美元换印尼盾。",
                                .spanish: "Dólares a rupias."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-exchange-clarify1",
                                    speaker: .native,
                                    text: "Berapa banyak yang mau ditukar?",
                                    translations: [
                                        .korean: "얼마나 바꾸시겠어요?",
                                        .english: "How much would you like to exchange?",
                                        .japanese: "いくら両替しますか？",
                                        .chinese: "您想换多少？",
                                        .spanish: "¿Cuánto quiere cambiar?"
                                    ],
                                    responses: [
                                        ConversationNode(
                                            id: "id-exchange-end1",
                                            speaker: .user,
                                            text: "Seratus dolar.",
                                            translations: [
                                                .korean: "100달러요.",
                                                .english: "One hundred dollars.",
                                                .japanese: "100ドルです。",
                                                .chinese: "一百美元。",
                                                .spanish: "Cien dólares."
                                            ],
                                            responses: nil
                                        )
                                    ]
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-seat-change",
            learningLanguage: .indonesian,
            icon: "💺",
            title: [
                .korean: "좌석 변경",
                .english: "Seat Change",
                .japanese: "座席変更",
                .chinese: "换座位",
                .spanish: "Cambio de asiento"
            ],
            description: [
                .korean: "비행기 좌석을 바꾸는 연습",
                .english: "Practice changing airplane seats",
                .japanese: "飛行機の座席を変える練習",
                .chinese: "练习换飞机座位",
                .spanish: "Practica cambiar de asiento en el avión"
            ],
            startingPhrase: "Permisi, boleh tukar tempat duduk?",
            startingPhraseTranslations: [
                .korean: "실례합니다, 좌석을 바꿔도 될까요?",
                .english: "Excuse me, can I change seats?",
                .japanese: "すみません、席を変えてもいいですか？",
                .chinese: "请问，可以换座位吗？",
                .spanish: "Disculpe, ¿puedo cambiar de asiento?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-seat-response1",
                    speaker: .native,
                    text: "Ada masalah dengan kursi Anda?",
                    translations: [
                        .korean: "좌석에 문제가 있나요?",
                        .english: "Is there a problem with your seat?",
                        .japanese: "座席に問題がありますか？",
                        .chinese: "您的座位有问题吗？",
                        .spanish: "¿Hay algún problema con su asiento?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-seat-followup1",
                            speaker: .user,
                            text: "Saya mau duduk di dekat jendela.",
                            translations: [
                                .korean: "창문 쪽에 앉고 싶어요.",
                                .english: "I'd like to sit by the window.",
                                .japanese: "窓側に座りたいです。",
                                .chinese: "我想坐在靠窗的位置。",
                                .spanish: "Me gustaría sentarme junto a la ventana."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-seat-end1",
                                    speaker: .native,
                                    text: "Baik, ada kursi kosong di baris 12.",
                                    translations: [
                                        .korean: "네, 12번 줄에 빈 자리가 있어요.",
                                        .english: "Okay, there's an empty seat in row 12.",
                                        .japanese: "わかりました、12列に空席があります。",
                                        .chinese: "好的，第12排有空位。",
                                        .spanish: "Bien, hay un asiento vacío en la fila 12."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),

        // MARK: - 숙박 카테고리
        Scenario(
            id: "id-hotel-checkin",
            learningLanguage: .indonesian,
            icon: "🏨",
            title: [
                .korean: "호텔 체크인",
                .english: "Hotel Check-in",
                .japanese: "ホテルチェックイン",
                .chinese: "酒店入住",
                .spanish: "Check-in en hotel"
            ],
            description: [
                .korean: "호텔에서 체크인하는 연습",
                .english: "Practice checking in at a hotel",
                .japanese: "ホテルでチェックインする練習",
                .chinese: "练习在酒店办理入住",
                .spanish: "Practica el check-in en un hotel"
            ],
            startingPhrase: "Saya sudah booking kamar atas nama Kim.",
            startingPhraseTranslations: [
                .korean: "김 이름으로 방을 예약했어요.",
                .english: "I booked a room under the name Kim.",
                .japanese: "キムという名前で部屋を予約しました。",
                .chinese: "我用Kim的名字预订了房间。",
                .spanish: "Reservé una habitación a nombre de Kim."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-hotelcheckin-response1",
                    speaker: .native,
                    text: "Baik, boleh saya lihat paspor Anda?",
                    translations: [
                        .korean: "네, 여권을 좀 보여주시겠어요?",
                        .english: "Okay, may I see your passport?",
                        .japanese: "はい、パスポートを見せていただけますか？",
                        .chinese: "好的，可以看一下您的护照吗？",
                        .spanish: "Bien, ¿puedo ver su pasaporte?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-hotelcheckin-followup1",
                            speaker: .user,
                            text: "Ya, ini dia.",
                            translations: [
                                .korean: "네, 여기요.",
                                .english: "Yes, here it is.",
                                .japanese: "はい、どうぞ。",
                                .chinese: "好的，在这里。",
                                .spanish: "Sí, aquí está."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-hotelcheckin-end1",
                                    speaker: .native,
                                    text: "Terima kasih. Ini kunci kamar 305. Selamat beristirahat.",
                                    translations: [
                                        .korean: "감사합니다. 여기 305호 키입니다. 편히 쉬세요.",
                                        .english: "Thank you. Here's the key to room 305. Enjoy your stay.",
                                        .japanese: "ありがとうございます。305号室の鍵です。ごゆっくり。",
                                        .chinese: "谢谢。这是305号房间的钥匙。祝您住得愉快。",
                                        .spanish: "Gracias. Aquí está la llave de la habitación 305. Que disfrute su estancia."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-guesthouse-checkin",
            learningLanguage: .indonesian,
            icon: "🏠",
            title: [
                .korean: "게스트하우스 체크인",
                .english: "Guesthouse Check-in",
                .japanese: "ゲストハウスチェックイン",
                .chinese: "民宿入住",
                .spanish: "Check-in en hostal"
            ],
            description: [
                .korean: "게스트하우스에서 체크인하는 연습",
                .english: "Practice checking in at a guesthouse",
                .japanese: "ゲストハウスでチェックインする練習",
                .chinese: "练习在民宿办理入住",
                .spanish: "Practica el check-in en un hostal"
            ],
            startingPhrase: "Halo, aku pesan kamar semalam.",
            startingPhraseTranslations: [
                .korean: "안녕하세요, 어젯밤에 방 예약했어요.",
                .english: "Hi, I booked a room last night.",
                .japanese: "こんにちは、昨夜部屋を予約しました。",
                .chinese: "你好，我昨晚预订了房间。",
                .spanish: "Hola, reservé una habitación anoche."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-guestcheckin-response1",
                    speaker: .native,
                    text: "Oh ya? Atas nama siapa?",
                    translations: [
                        .korean: "아, 그래요? 누구 이름으로요?",
                        .english: "Oh yeah? Under what name?",
                        .japanese: "あ、そう？誰の名前で？",
                        .chinese: "哦，是吗？用谁的名字？",
                        .spanish: "¿Ah sí? ¿A nombre de quién?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-guestcheckin-followup1",
                            speaker: .user,
                            text: "Kim. Kamar untuk dua orang.",
                            translations: [
                                .korean: "김이요. 2인실이요.",
                                .english: "Kim. A room for two people.",
                                .japanese: "キムです。2人部屋です。",
                                .chinese: "Kim。双人间。",
                                .spanish: "Kim. Una habitación para dos personas."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-guestcheckin-end1",
                                    speaker: .native,
                                    text: "Oke, ada nih. Kamar nomor 7, lantai dua. Ini kuncinya.",
                                    translations: [
                                        .korean: "네, 있어요. 7호실, 2층이에요. 여기 키요.",
                                        .english: "Okay, got it. Room number 7, second floor. Here's the key.",
                                        .japanese: "オッケー、ありますよ。7号室、2階です。鍵です。",
                                        .chinese: "好的，有的。7号房间，二楼。这是钥匙。",
                                        .spanish: "Ok, aquí está. Habitación número 7, segundo piso. Aquí está la llave."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-room-service",
            learningLanguage: .indonesian,
            icon: "🍽️",
            title: [
                .korean: "룸서비스",
                .english: "Room Service",
                .japanese: "ルームサービス",
                .chinese: "客房服务",
                .spanish: "Servicio de habitación"
            ],
            description: [
                .korean: "룸서비스를 주문하는 연습",
                .english: "Practice ordering room service",
                .japanese: "ルームサービスを注文する練習",
                .chinese: "练习订客房服务",
                .spanish: "Practica pedir servicio de habitación"
            ],
            startingPhrase: "Saya mau pesan makanan ke kamar.",
            startingPhraseTranslations: [
                .korean: "객실로 음식을 주문하고 싶어요.",
                .english: "I'd like to order food to my room.",
                .japanese: "部屋に食事を注文したいです。",
                .chinese: "我想订餐到房间。",
                .spanish: "Me gustaría pedir comida a mi habitación."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-roomservice-response1",
                    speaker: .native,
                    text: "Tentu, nomor kamar Anda berapa?",
                    translations: [
                        .korean: "물론이죠, 객실 번호가 어떻게 되시나요?",
                        .english: "Of course, what's your room number?",
                        .japanese: "もちろんです、お部屋番号は？",
                        .chinese: "当然，您的房间号是多少？",
                        .spanish: "Por supuesto, ¿cuál es su número de habitación?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-roomservice-followup1",
                            speaker: .user,
                            text: "305. Saya mau nasi goreng dan jus jeruk.",
                            translations: [
                                .korean: "305호요. 볶음밥이랑 오렌지 주스 주세요.",
                                .english: "305. I'd like fried rice and orange juice.",
                                .japanese: "305号です。チャーハンとオレンジジュースをお願いします。",
                                .chinese: "305号。我要炒饭和橙汁。",
                                .spanish: "305. Quiero arroz frito y jugo de naranja."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-roomservice-end1",
                                    speaker: .native,
                                    text: "Baik, akan diantar dalam 20 menit.",
                                    translations: [
                                        .korean: "네, 20분 안에 가져다 드리겠습니다.",
                                        .english: "Okay, it will be delivered in 20 minutes.",
                                        .japanese: "わかりました、20分以内にお届けします。",
                                        .chinese: "好的，20分钟内送到。",
                                        .spanish: "Bien, se entregará en 20 minutos."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-breakfast-time",
            learningLanguage: .indonesian,
            icon: "🍳",
            title: [
                .korean: "조식 시간 문의",
                .english: "Asking About Breakfast",
                .japanese: "朝食時間を尋ねる",
                .chinese: "询问早餐时间",
                .spanish: "Preguntar por el desayuno"
            ],
            description: [
                .korean: "조식 시간을 물어보는 연습",
                .english: "Practice asking about breakfast time",
                .japanese: "朝食の時間を尋ねる練習",
                .chinese: "练习询问早餐时间",
                .spanish: "Practica preguntar por el horario del desayuno"
            ],
            startingPhrase: "Jam berapa sarapan pagi?",
            startingPhraseTranslations: [
                .korean: "아침식사가 몇 시에요?",
                .english: "What time is breakfast?",
                .japanese: "朝食は何時ですか？",
                .chinese: "早餐几点？",
                .spanish: "¿A qué hora es el desayuno?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-breakfast-response1",
                    speaker: .native,
                    text: "Dari jam 6 sampai jam 10 pagi.",
                    translations: [
                        .korean: "아침 6시부터 10시까지예요.",
                        .english: "From 6 AM to 10 AM.",
                        .japanese: "朝6時から10時までです。",
                        .chinese: "早上6点到10点。",
                        .spanish: "De 6 a 10 de la mañana."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-breakfast-followup1",
                            speaker: .user,
                            text: "Di mana tempatnya?",
                            translations: [
                                .korean: "어디서 먹어요?",
                                .english: "Where is it?",
                                .japanese: "どこですか？",
                                .chinese: "在哪里？",
                                .spanish: "¿Dónde es?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-breakfast-end1",
                                    speaker: .native,
                                    text: "Di lantai satu, sebelah lobi.",
                                    translations: [
                                        .korean: "1층이요, 로비 옆이에요.",
                                        .english: "On the first floor, next to the lobby.",
                                        .japanese: "1階です、ロビーの隣です。",
                                        .chinese: "在一楼，大厅旁边。",
                                        .spanish: "En el primer piso, al lado del lobby."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-hotel-checkout",
            learningLanguage: .indonesian,
            icon: "🚪",
            title: [
                .korean: "호텔 체크아웃",
                .english: "Hotel Checkout",
                .japanese: "ホテルチェックアウト",
                .chinese: "酒店退房",
                .spanish: "Check-out del hotel"
            ],
            description: [
                .korean: "호텔에서 체크아웃하는 연습",
                .english: "Practice checking out of a hotel",
                .japanese: "ホテルでチェックアウトする練習",
                .chinese: "练习在酒店退房",
                .spanish: "Practica el check-out del hotel"
            ],
            startingPhrase: "Saya mau check-out.",
            startingPhraseTranslations: [
                .korean: "체크아웃하고 싶어요.",
                .english: "I'd like to check out.",
                .japanese: "チェックアウトしたいです。",
                .chinese: "我想退房。",
                .spanish: "Quiero hacer el check-out."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-checkout-response1",
                    speaker: .native,
                    text: "Baik, nomor kamar berapa?",
                    translations: [
                        .korean: "네, 객실 번호가 어떻게 되시나요?",
                        .english: "Okay, what room number?",
                        .japanese: "はい、お部屋番号は？",
                        .chinese: "好的，房间号是多少？",
                        .spanish: "Bien, ¿qué número de habitación?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-checkout-followup1",
                            speaker: .user,
                            text: "305. Apakah ada biaya tambahan?",
                            translations: [
                                .korean: "305호요. 추가 요금이 있나요?",
                                .english: "305. Are there any additional charges?",
                                .japanese: "305号です。追加料金はありますか？",
                                .chinese: "305号。有额外费用吗？",
                                .spanish: "305. ¿Hay cargos adicionales?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-checkout-end1",
                                    speaker: .native,
                                    text: "Tidak ada. Total sesuai reservasi. Terima kasih sudah menginap.",
                                    translations: [
                                        .korean: "없어요. 예약한 금액과 동일합니다. 투숙해주셔서 감사합니다.",
                                        .english: "No. Total matches your reservation. Thank you for staying.",
                                        .japanese: "ありません。予約通りです。ご宿泊ありがとうございました。",
                                        .chinese: "没有。总额与预订一致。感谢您的入住。",
                                        .spanish: "No. El total coincide con su reserva. Gracias por hospedarse."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-luggage-storage",
            learningLanguage: .indonesian,
            icon: "🎒",
            title: [
                .korean: "짐 보관 요청",
                .english: "Luggage Storage Request",
                .japanese: "荷物預かり依頼",
                .chinese: "寄存行李",
                .spanish: "Solicitud de guardaequipaje"
            ],
            description: [
                .korean: "짐을 맡기는 연습",
                .english: "Practice storing luggage",
                .japanese: "荷物を預ける練習",
                .chinese: "练习寄存行李",
                .spanish: "Practica guardar equipaje"
            ],
            startingPhrase: "Bisa simpan koper di sini?",
            startingPhraseTranslations: [
                .korean: "여기 캐리어 맡겨도 돼요?",
                .english: "Can I store my suitcase here?",
                .japanese: "ここにスーツケースを預けられますか？",
                .chinese: "可以把行李箱存在这里吗？",
                .spanish: "¿Puedo guardar mi maleta aquí?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-storage-response1",
                    speaker: .native,
                    text: "Tentu bisa. Sampai jam berapa?",
                    translations: [
                        .korean: "물론이죠. 몇 시까지요?",
                        .english: "Sure. Until what time?",
                        .japanese: "もちろんです。何時までですか？",
                        .chinese: "当然可以。到几点？",
                        .spanish: "Claro. ¿Hasta qué hora?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-storage-followup1",
                            speaker: .user,
                            text: "Jam 5 sore. Boleh ya?",
                            translations: [
                                .korean: "오후 5시요. 괜찮죠?",
                                .english: "5 PM. Is that okay?",
                                .japanese: "午後5時です。いいですか？",
                                .chinese: "下午5点。可以吗？",
                                .spanish: "5 de la tarde. ¿Está bien?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-storage-end1",
                                    speaker: .native,
                                    text: "Tidak masalah. Ini nomor tagihannya.",
                                    translations: [
                                        .korean: "문제없어요. 여기 보관증이에요.",
                                        .english: "No problem. Here's your claim ticket.",
                                        .japanese: "問題ありません。預かり証です。",
                                        .chinese: "没问题。这是您的寄存单。",
                                        .spanish: "Sin problema. Aquí está su comprobante."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-towel-request",
            learningLanguage: .indonesian,
            icon: "🛁",
            title: [
                .korean: "타월 요청",
                .english: "Towel Request",
                .japanese: "タオル依頼",
                .chinese: "要毛巾",
                .spanish: "Solicitud de toalla"
            ],
            description: [
                .korean: "타월을 요청하는 연습",
                .english: "Practice requesting towels",
                .japanese: "タオルをお願いする練習",
                .chinese: "练习要毛巾",
                .spanish: "Practica pedir toallas"
            ],
            startingPhrase: "Boleh minta handuk tambahan?",
            startingPhraseTranslations: [
                .korean: "타월 추가로 주실 수 있어요?",
                .english: "Can I get extra towels?",
                .japanese: "タオルを追加でもらえますか？",
                .chinese: "可以再要一些毛巾吗？",
                .spanish: "¿Puedo tener toallas extra?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-towel-response1",
                    speaker: .native,
                    text: "Tentu. Berapa banyak yang Anda butuhkan?",
                    translations: [
                        .korean: "물론이죠. 몇 개 필요하세요?",
                        .english: "Sure. How many do you need?",
                        .japanese: "もちろん。何枚必要ですか？",
                        .chinese: "当然。您需要几条？",
                        .spanish: "Claro. ¿Cuántas necesita?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-towel-followup1",
                            speaker: .user,
                            text: "Dua handuk saja. Terima kasih.",
                            translations: [
                                .korean: "두 개만요. 감사합니다.",
                                .english: "Just two towels. Thank you.",
                                .japanese: "2枚だけです。ありがとう。",
                                .chinese: "只要两条。谢谢。",
                                .spanish: "Solo dos toallas. Gracias."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-towel-end1",
                                    speaker: .native,
                                    text: "Baik, saya antarkan ke kamar Anda sebentar lagi.",
                                    translations: [
                                        .korean: "네, 곧 객실로 가져다 드리겠습니다.",
                                        .english: "Okay, I'll bring them to your room shortly.",
                                        .japanese: "はい、すぐにお部屋にお持ちします。",
                                        .chinese: "好的，我马上送到您房间。",
                                        .spanish: "Bien, las llevaré a su habitación enseguida."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-wifi-password",
            learningLanguage: .indonesian,
            icon: "📶",
            title: [
                .korean: "와이파이 비밀번호",
                .english: "WiFi Password",
                .japanese: "WiFiパスワード",
                .chinese: "WiFi密码",
                .spanish: "Contraseña WiFi"
            ],
            description: [
                .korean: "와이파이 비밀번호를 묻는 연습",
                .english: "Practice asking for WiFi password",
                .japanese: "WiFiパスワードを尋ねる練習",
                .chinese: "练习询问WiFi密码",
                .spanish: "Practica preguntar por la contraseña WiFi"
            ],
            startingPhrase: "Password WiFi-nya apa?",
            startingPhraseTranslations: [
                .korean: "와이파이 비밀번호가 뭐예요?",
                .english: "What's the WiFi password?",
                .japanese: "WiFiのパスワードは何ですか？",
                .chinese: "WiFi密码是什么？",
                .spanish: "¿Cuál es la contraseña del WiFi?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-wifi-response1",
                    speaker: .native,
                    text: "Sebentar ya, saya tuliskan. Ini dia.",
                    translations: [
                        .korean: "잠깐만요, 써드릴게요. 여기요.",
                        .english: "One moment, I'll write it down. Here it is.",
                        .japanese: "ちょっと待って、書きますね。これです。",
                        .chinese: "稍等，我写下来。这是。",
                        .spanish: "Un momento, lo anoto. Aquí está."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-wifi-followup1",
                            speaker: .user,
                            text: "Makasih ya!",
                            translations: [
                                .korean: "고마워요!",
                                .english: "Thanks!",
                                .japanese: "ありがとう！",
                                .chinese: "谢谢！",
                                .spanish: "¡Gracias!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-wifi-end1",
                                    speaker: .native,
                                    text: "Sama-sama. Kalau ada masalah, bilang aja ya.",
                                    translations: [
                                        .korean: "천만에요. 문제 있으면 말씀하세요.",
                                        .english: "You're welcome. If there's any problem, just let me know.",
                                        .japanese: "どういたしまして。問題があれば言ってくださいね。",
                                        .chinese: "不客气。有问题就说。",
                                        .spanish: "De nada. Si hay algún problema, avísame."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),

        // MARK: - 식당/카페 카테고리 (추가)
        Scenario(
            id: "id-table-reservation",
            learningLanguage: .indonesian,
            icon: "📅",
            title: [
                .korean: "테이블 예약",
                .english: "Table Reservation",
                .japanese: "テーブル予約",
                .chinese: "预订桌位",
                .spanish: "Reserva de mesa"
            ],
            description: [
                .korean: "식당 테이블을 예약하는 연습",
                .english: "Practice reserving a table",
                .japanese: "レストランの予約をする練習",
                .chinese: "练习预订餐桌",
                .spanish: "Practica reservar una mesa"
            ],
            startingPhrase: "Saya mau booking meja untuk malam ini.",
            startingPhraseTranslations: [
                .korean: "오늘 저녁 테이블 예약하고 싶어요.",
                .english: "I'd like to book a table for tonight.",
                .japanese: "今夜のテーブルを予約したいです。",
                .chinese: "我想预订今晚的桌位。",
                .spanish: "Quiero reservar una mesa para esta noche."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-reservation-response1",
                    speaker: .native,
                    text: "Untuk berapa orang?",
                    translations: [
                        .korean: "몇 분이세요?",
                        .english: "For how many people?",
                        .japanese: "何名様ですか？",
                        .chinese: "几位？",
                        .spanish: "¿Para cuántas personas?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-reservation-followup1",
                            speaker: .user,
                            text: "Empat orang. Jam 7 malam.",
                            translations: [
                                .korean: "4명이요. 저녁 7시요.",
                                .english: "Four people. 7 PM.",
                                .japanese: "4名です。午後7時です。",
                                .chinese: "四位。晚上7点。",
                                .spanish: "Cuatro personas. 7 PM."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-reservation-end1",
                                    speaker: .native,
                                    text: "Baik, boleh tahu nama Anda?",
                                    translations: [
                                        .korean: "네, 성함이 어떻게 되세요?",
                                        .english: "Okay, may I have your name?",
                                        .japanese: "はい、お名前をお伺いできますか？",
                                        .chinese: "好的，请问您贵姓？",
                                        .spanish: "Bien, ¿puedo saber su nombre?"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-menu-recommendation",
            learningLanguage: .indonesian,
            icon: "⭐",
            title: [
                .korean: "메뉴 추천",
                .english: "Menu Recommendation",
                .japanese: "メニュー推薦",
                .chinese: "菜单推荐",
                .spanish: "Recomendación de menú"
            ],
            description: [
                .korean: "메뉴 추천을 요청하는 연습",
                .english: "Practice asking for menu recommendations",
                .japanese: "メニューのおすすめを聞く練習",
                .chinese: "练习询问菜单推荐",
                .spanish: "Practica pedir recomendaciones del menú"
            ],
            startingPhrase: "Ada rekomendasi makanan yang enak?",
            startingPhraseTranslations: [
                .korean: "맛있는 음식 추천해주실 수 있어요?",
                .english: "Any good food recommendations?",
                .japanese: "おいしい料理のおすすめはありますか？",
                .chinese: "有什么好吃的推荐吗？",
                .spanish: "¿Alguna recomendación de comida buena?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-recommend-response1",
                    speaker: .native,
                    text: "Rendang kami terkenal lho. Mau coba?",
                    translations: [
                        .korean: "저희 렌당이 유명해요. 드셔보시겠어요?",
                        .english: "Our rendang is famous. Want to try?",
                        .japanese: "うちのレンダンは有名ですよ。試してみますか？",
                        .chinese: "我们的仁当很有名。要试试吗？",
                        .spanish: "Nuestro rendang es famoso. ¿Quiere probarlo?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-recommend-followup1",
                            speaker: .user,
                            text: "Boleh! Itu pedas nggak?",
                            translations: [
                                .korean: "좋아요! 그거 매워요?",
                                .english: "Sure! Is it spicy?",
                                .japanese: "いいですね！辛いですか？",
                                .chinese: "好啊！辣吗？",
                                .spanish: "¡Claro! ¿Es picante?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-recommend-end1",
                                    speaker: .native,
                                    text: "Sedikit pedas, tapi enak banget!",
                                    translations: [
                                        .korean: "조금 매운데, 정말 맛있어요!",
                                        .english: "A little spicy, but really delicious!",
                                        .japanese: "少し辛いですが、とてもおいしいですよ！",
                                        .chinese: "有点辣，但是很好吃！",
                                        .spanish: "Un poco picante, ¡pero muy rico!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-allergy-inquiry",
            learningLanguage: .indonesian,
            icon: "🚫",
            title: [
                .korean: "알레르기 문의",
                .english: "Allergy Inquiry",
                .japanese: "アレルギー問い合わせ",
                .chinese: "过敏咨询",
                .spanish: "Consulta de alergia"
            ],
            description: [
                .korean: "음식 알레르기에 대해 문의하는 연습",
                .english: "Practice asking about food allergies",
                .japanese: "食物アレルギーについて尋ねる練習",
                .chinese: "练习咨询食物过敏",
                .spanish: "Practica preguntar sobre alergias alimentarias"
            ],
            startingPhrase: "Apakah ini mengandung kacang?",
            startingPhraseTranslations: [
                .korean: "이거 땅콩 들어가요?",
                .english: "Does this contain peanuts?",
                .japanese: "これにピーナッツは入っていますか？",
                .chinese: "这个含花生吗？",
                .spanish: "¿Esto contiene cacahuetes?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-allergy-response1",
                    speaker: .native,
                    text: "Saya cek dulu ya. Anda alergi kacang?",
                    translations: [
                        .korean: "확인해볼게요. 땅콩 알레르기가 있으세요?",
                        .english: "Let me check. Are you allergic to peanuts?",
                        .japanese: "確認しますね。ピーナッツアレルギーですか？",
                        .chinese: "我查一下。您对花生过敏吗？",
                        .spanish: "Déjame revisar. ¿Es alérgico a los cacahuetes?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-allergy-followup1",
                            speaker: .user,
                            text: "Iya, alergi parah.",
                            translations: [
                                .korean: "네, 심한 알레르기예요.",
                                .english: "Yes, severe allergy.",
                                .japanese: "はい、重度のアレルギーです。",
                                .chinese: "是的，严重过敏。",
                                .spanish: "Sí, alergia severa."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-allergy-end1",
                                    speaker: .native,
                                    text: "Baik, saya carikan menu yang aman untuk Anda.",
                                    translations: [
                                        .korean: "네, 안전한 메뉴를 찾아드릴게요.",
                                        .english: "Okay, I'll find a safe menu for you.",
                                        .japanese: "わかりました、安全なメニューを探しますね。",
                                        .chinese: "好的，我给您找安全的菜单。",
                                        .spanish: "Bien, le buscaré un menú seguro."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-bill",
            learningLanguage: .indonesian,
            icon: "🧾",
            title: [
                .korean: "계산서 요청",
                .english: "Asking for the Bill",
                .japanese: "会計依頼",
                .chinese: "要账单",
                .spanish: "Pedir la cuenta"
            ],
            description: [
                .korean: "계산서를 요청하는 연습",
                .english: "Practice asking for the bill",
                .japanese: "会計をお願いする練習",
                .chinese: "练习要账单",
                .spanish: "Practica pedir la cuenta"
            ],
            startingPhrase: "Minta bon nya dong.",
            startingPhraseTranslations: [
                .korean: "계산서 주세요.",
                .english: "Can I have the bill please?",
                .japanese: "お会計お願いします。",
                .chinese: "请给我账单。",
                .spanish: "La cuenta por favor."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-bill-response1",
                    speaker: .native,
                    text: "Baik, sebentar ya.",
                    translations: [
                        .korean: "네, 잠시만요.",
                        .english: "Okay, just a moment.",
                        .japanese: "はい、少々お待ちください。",
                        .chinese: "好的，稍等。",
                        .spanish: "Bien, un momento."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-bill-followup1",
                            speaker: .user,
                            text: "Bisa pakai kartu kredit?",
                            translations: [
                                .korean: "신용카드 돼요?",
                                .english: "Can I pay with credit card?",
                                .japanese: "クレジットカードで払えますか？",
                                .chinese: "可以用信用卡吗？",
                                .spanish: "¿Puedo pagar con tarjeta de crédito?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-bill-end1",
                                    speaker: .native,
                                    text: "Bisa kok. Ini mesin EDC-nya.",
                                    translations: [
                                        .korean: "물론이죠. 여기 카드 단말기요.",
                                        .english: "Yes. Here's the card machine.",
                                        .japanese: "大丈夫です。こちらがカード決済機です。",
                                        .chinese: "可以。这是刷卡机。",
                                        .spanish: "Sí. Aquí está el datáfono."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-takeout-order",
            learningLanguage: .indonesian,
            icon: "🥡",
            title: [
                .korean: "테이크아웃 주문",
                .english: "Takeout Order",
                .japanese: "テイクアウト注文",
                .chinese: "外卖订单",
                .spanish: "Pedido para llevar"
            ],
            description: [
                .korean: "테이크아웃을 주문하는 연습",
                .english: "Practice ordering takeout",
                .japanese: "テイクアウトを注文する練習",
                .chinese: "练习订外卖",
                .spanish: "Practica pedir comida para llevar"
            ],
            startingPhrase: "Bisa bungkus nggak?",
            startingPhraseTranslations: [
                .korean: "포장 되나요?",
                .english: "Can I get it to go?",
                .japanese: "持ち帰りできますか？",
                .chinese: "可以打包吗？",
                .spanish: "¿Puedo pedir para llevar?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-takeout-response1",
                    speaker: .native,
                    text: "Bisa banget. Mau pesan apa?",
                    translations: [
                        .korean: "물론이죠. 뭐 주문하시겠어요?",
                        .english: "Of course. What would you like to order?",
                        .japanese: "もちろんです。何を注文しますか？",
                        .chinese: "当然可以。您想点什么？",
                        .spanish: "Claro que sí. ¿Qué quiere pedir?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-takeout-followup1",
                            speaker: .user,
                            text: "Satu nasi goreng sama es teh manis.",
                            translations: [
                                .korean: "볶음밥 하나랑 아이스티요.",
                                .english: "One fried rice and an iced sweet tea.",
                                .japanese: "チャーハン一つと甘いアイスティーです。",
                                .chinese: "一份炒饭和冰甜茶。",
                                .spanish: "Un arroz frito y un té helado dulce."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-takeout-end1",
                                    speaker: .native,
                                    text: "Siap! Tunggu sekitar 15 menit ya.",
                                    translations: [
                                        .korean: "알겠습니다! 15분 정도 기다려주세요.",
                                        .english: "Got it! Wait about 15 minutes.",
                                        .japanese: "了解！15分ほどお待ちください。",
                                        .chinese: "好的！等大约15分钟。",
                                        .spanish: "¡Listo! Espere unos 15 minutos."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-coffee-order",
            learningLanguage: .indonesian,
            icon: "☕",
            title: [
                .korean: "커피 주문",
                .english: "Coffee Order",
                .japanese: "コーヒー注文",
                .chinese: "点咖啡",
                .spanish: "Pedir café"
            ],
            description: [
                .korean: "카페에서 커피를 주문하는 연습",
                .english: "Practice ordering coffee",
                .japanese: "カフェでコーヒーを注文する練習",
                .chinese: "练习在咖啡馆点咖啡",
                .spanish: "Practica pedir café"
            ],
            startingPhrase: "Satu kopi susu panas.",
            startingPhraseTranslations: [
                .korean: "따뜻한 카페라떼 하나요.",
                .english: "One hot coffee with milk.",
                .japanese: "ホットカフェラテ一つです。",
                .chinese: "一杯热牛奶咖啡。",
                .spanish: "Un café con leche caliente."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-coffee-response1",
                    speaker: .native,
                    text: "Ukuran apa? Medium atau large?",
                    translations: [
                        .korean: "사이즈 어떻게 하시겠어요? 미디엄? 라지?",
                        .english: "What size? Medium or large?",
                        .japanese: "サイズは？ミディアムかラージ？",
                        .chinese: "什么尺寸？中杯还是大杯？",
                        .spanish: "¿Qué tamaño? ¿Mediano o grande?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-coffee-followup1",
                            speaker: .user,
                            text: "Medium aja. Gula dikit ya.",
                            translations: [
                                .korean: "미디엄이요. 설탕 조금만요.",
                                .english: "Medium. Just a little sugar.",
                                .japanese: "ミディアムで。砂糖は少しだけ。",
                                .chinese: "中杯就好。糖少一点。",
                                .spanish: "Mediano. Solo un poco de azúcar."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-coffee-end1",
                                    speaker: .native,
                                    text: "Oke, total 25 ribu.",
                                    translations: [
                                        .korean: "알겠습니다, 총 25,000루피아예요.",
                                        .english: "Okay, that's 25 thousand total.",
                                        .japanese: "わかりました、合計25,000ルピアです。",
                                        .chinese: "好的，总共2万5千。",
                                        .spanish: "Ok, son 25 mil en total."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-water-request",
            learningLanguage: .indonesian,
            icon: "💧",
            title: [
                .korean: "물 요청",
                .english: "Water Request",
                .japanese: "水依頼",
                .chinese: "要水",
                .spanish: "Solicitud de agua"
            ],
            description: [
                .korean: "식당에서 물을 요청하는 연습",
                .english: "Practice requesting water at a restaurant",
                .japanese: "レストランで水をお願いする練習",
                .chinese: "练习在餐厅要水",
                .spanish: "Practica pedir agua en un restaurante"
            ],
            startingPhrase: "Boleh minta air putih?",
            startingPhraseTranslations: [
                .korean: "물 좀 주시겠어요?",
                .english: "Can I have some water?",
                .japanese: "お水をいただけますか？",
                .chinese: "可以给我水吗？",
                .spanish: "¿Puedo tener agua?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-water-response1",
                    speaker: .native,
                    text: "Tentu, sebentar ya.",
                    translations: [
                        .korean: "물론이죠, 잠시만요.",
                        .english: "Sure, one moment.",
                        .japanese: "もちろん、少々お待ちください。",
                        .chinese: "当然，稍等。",
                        .spanish: "Claro, un momento."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-water-followup1",
                            speaker: .user,
                            text: "Makasih banyak!",
                            translations: [
                                .korean: "정말 감사합니다!",
                                .english: "Thank you so much!",
                                .japanese: "どうもありがとう！",
                                .chinese: "非常感谢！",
                                .spanish: "¡Muchas gracias!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-water-end1",
                                    speaker: .native,
                                    text: "Sama-sama. Silakan.",
                                    translations: [
                                        .korean: "천만에요. 여기요.",
                                        .english: "You're welcome. Here you go.",
                                        .japanese: "どういたしまして。どうぞ。",
                                        .chinese: "不客气。请。",
                                        .spanish: "De nada. Aquí tiene."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-vegetarian-menu",
            learningLanguage: .indonesian,
            icon: "🥗",
            title: [
                .korean: "채식 메뉴 문의",
                .english: "Vegetarian Menu Inquiry",
                .japanese: "ベジタリアンメニュー問い合わせ",
                .chinese: "素食菜单咨询",
                .spanish: "Consulta de menú vegetariano"
            ],
            description: [
                .korean: "채식 메뉴를 문의하는 연습",
                .english: "Practice asking about vegetarian menu",
                .japanese: "ベジタリアンメニューを尋ねる練習",
                .chinese: "练习询问素食菜单",
                .spanish: "Practica preguntar por el menú vegetariano"
            ],
            startingPhrase: "Ada menu vegetarian?",
            startingPhraseTranslations: [
                .korean: "채식 메뉴 있나요?",
                .english: "Do you have vegetarian menu?",
                .japanese: "ベジタリアンメニューはありますか？",
                .chinese: "有素食菜单吗？",
                .spanish: "¿Tienen menú vegetariano?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-vegetarian-response1",
                    speaker: .native,
                    text: "Ada. Anda mau yang tanpa daging sama sekali?",
                    translations: [
                        .korean: "있어요. 고기가 전혀 안 들어간 걸로 드릴까요?",
                        .english: "Yes. Would you like something with no meat at all?",
                        .japanese: "あります。肉が全く入っていないものがいいですか？",
                        .chinese: "有的。您要完全不含肉的吗？",
                        .spanish: "Sí. ¿Quiere algo sin nada de carne?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-vegetarian-followup1",
                            speaker: .user,
                            text: "Iya, saya vegetarian.",
                            translations: [
                                .korean: "네, 저 채식주의자예요.",
                                .english: "Yes, I'm vegetarian.",
                                .japanese: "はい、ベジタリアンです。",
                                .chinese: "是的，我吃素。",
                                .spanish: "Sí, soy vegetariano."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-vegetarian-end1",
                                    speaker: .native,
                                    text: "Baik, saya rekomendasikan gado-gado atau cap cay.",
                                    translations: [
                                        .korean: "네, 가도가도나 잡채 추천드려요.",
                                        .english: "Okay, I recommend gado-gado or cap cay.",
                                        .japanese: "わかりました、ガドガドかチャプチャイをおすすめします。",
                                        .chinese: "好的，我推荐加多加多或炒杂菜。",
                                        .spanish: "Bien, recomiendo gado-gado o cap cay."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),

        // MARK: - 교통 카테고리
        Scenario(
            id: "id-taxi-call",
            learningLanguage: .indonesian,
            icon: "🚕",
            title: [
                .korean: "택시 호출",
                .english: "Calling a Taxi",
                .japanese: "タクシーを呼ぶ",
                .chinese: "叫出租车",
                .spanish: "Llamar un taxi"
            ],
            description: [
                .korean: "택시를 부르는 연습",
                .english: "Practice calling a taxi",
                .japanese: "タクシーを呼ぶ練習",
                .chinese: "练习叫出租车",
                .spanish: "Practica llamar un taxi"
            ],
            startingPhrase: "Bisa panggilkan taksi?",
            startingPhraseTranslations: [
                .korean: "택시 좀 불러주시겠어요?",
                .english: "Can you call a taxi for me?",
                .japanese: "タクシーを呼んでいただけますか？",
                .chinese: "可以帮我叫辆出租车吗？",
                .spanish: "¿Puede llamar un taxi?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-taxi-response1",
                    speaker: .native,
                    text: "Tentu. Mau ke mana?",
                    translations: [
                        .korean: "물론이죠. 어디 가세요?",
                        .english: "Sure. Where to?",
                        .japanese: "もちろん。どちらまで？",
                        .chinese: "当然。去哪里？",
                        .spanish: "Claro. ¿A dónde?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-taxi-followup1",
                            speaker: .user,
                            text: "Ke bandara.",
                            translations: [
                                .korean: "공항이요.",
                                .english: "To the airport.",
                                .japanese: "空港まで。",
                                .chinese: "去机场。",
                                .spanish: "Al aeropuerto."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-taxi-end1",
                                    speaker: .native,
                                    text: "Baik, taksi akan datang dalam 5 menit.",
                                    translations: [
                                        .korean: "네, 택시가 5분 안에 올 거예요.",
                                        .english: "Okay, the taxi will arrive in 5 minutes.",
                                        .japanese: "わかりました、タクシーは5分で到着します。",
                                        .chinese: "好的，出租车5分钟内到达。",
                                        .spanish: "Bien, el taxi llegará en 5 minutos."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-tell-destination",
            learningLanguage: .indonesian,
            icon: "📍",
            title: [
                .korean: "목적지 알려주기",
                .english: "Telling the Destination",
                .japanese: "目的地を伝える",
                .chinese: "告知目的地",
                .spanish: "Decir el destino"
            ],
            description: [
                .korean: "택시 기사에게 목적지를 알려주는 연습",
                .english: "Practice telling destination to taxi driver",
                .japanese: "タクシー運転手に目的地を伝える練習",
                .chinese: "练习向出租车司机说明目的地",
                .spanish: "Practica decir el destino al taxista"
            ],
            startingPhrase: "Tolong antar ke hotel Grand Indonesia.",
            startingPhraseTranslations: [
                .korean: "그랜드 인도네시아 호텔로 데려다 주세요.",
                .english: "Please take me to Grand Indonesia hotel.",
                .japanese: "グランドインドネシアホテルまでお願いします。",
                .chinese: "请送我到大印度尼西亚酒店。",
                .spanish: "Por favor lléveme al hotel Grand Indonesia."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-destination-response1",
                    speaker: .native,
                    text: "Baik. Lewat jalan tol atau jalan biasa?",
                    translations: [
                        .korean: "네. 고속도로로 갈까요, 일반 도로로 갈까요?",
                        .english: "Okay. Via toll road or regular road?",
                        .japanese: "わかりました。高速道路か一般道路、どちらがいいですか？",
                        .chinese: "好的。走高速还是普通路？",
                        .spanish: "Bien. ¿Por autopista de peaje o carretera normal?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-destination-followup1",
                            speaker: .user,
                            text: "Yang lebih cepat saja.",
                            translations: [
                                .korean: "더 빠른 걸로 가주세요.",
                                .english: "Whichever is faster.",
                                .japanese: "早い方でお願いします。",
                                .chinese: "走快一点的就好。",
                                .spanish: "El que sea más rápido."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-destination-end1",
                                    speaker: .native,
                                    text: "Siap, lewat tol ya.",
                                    translations: [
                                        .korean: "알겠습니다, 고속도로로 가겠습니다.",
                                        .english: "Got it, we'll take the toll road.",
                                        .japanese: "了解、高速道路で行きます。",
                                        .chinese: "明白了，走高速。",
                                        .spanish: "Entendido, tomaremos la autopista."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-fare",
            learningLanguage: .indonesian,
            icon: "💰",
            title: [
                .korean: "요금 문의",
                .english: "Asking About Fare",
                .japanese: "運賃を尋ねる",
                .chinese: "询问车费",
                .spanish: "Preguntar por la tarifa"
            ],
            description: [
                .korean: "택시 요금을 묻는 연습",
                .english: "Practice asking about taxi fare",
                .japanese: "タクシー料金を尋ねる練習",
                .chinese: "练习询问出租车费",
                .spanish: "Practica preguntar por la tarifa del taxi"
            ],
            startingPhrase: "Berapa ongkosnya ke sana?",
            startingPhraseTranslations: [
                .korean: "거기까지 얼마예요?",
                .english: "How much to get there?",
                .japanese: "そこまでいくらですか？",
                .chinese: "到那里多少钱？",
                .spanish: "¿Cuánto cuesta llegar allí?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-fare-response1",
                    speaker: .native,
                    text: "Kira-kira 80 ribu, tergantung macet atau tidak.",
                    translations: [
                        .korean: "대략 8만 루피아인데, 막히느냐에 따라 다릅니다.",
                        .english: "About 80 thousand, depends on traffic.",
                        .japanese: "約8万ルピアですが、渋滞次第です。",
                        .chinese: "大约8万，要看堵不堵车。",
                        .spanish: "Unos 80 mil, depende del tráfico."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-fare-followup1",
                            speaker: .user,
                            text: "Oke, pakai argo ya?",
                            translations: [
                                .korean: "네, 미터기 켜주세요.",
                                .english: "Okay, use the meter please?",
                                .japanese: "わかりました、メーターでお願いします。",
                                .chinese: "好的，用计价器吧？",
                                .spanish: "Ok, ¿usa el taxímetro?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-fare-end1",
                                    speaker: .native,
                                    text: "Ya, sudah saya nyalakan.",
                                    translations: [
                                        .korean: "네, 이미 켰어요.",
                                        .english: "Yes, I already turned it on.",
                                        .japanese: "はい、もう付けました。",
                                        .chinese: "是的，已经打开了。",
                                        .spanish: "Sí, ya lo encendí."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-metro-route",
            learningLanguage: .indonesian,
            icon: "🚇",
            title: [
                .korean: "지하철 노선 문의",
                .english: "Asking About Metro Route",
                .japanese: "地下鉄路線を尋ねる",
                .chinese: "询问地铁线路",
                .spanish: "Preguntar por la ruta del metro"
            ],
            description: [
                .korean: "지하철 노선을 묻는 연습",
                .english: "Practice asking about metro route",
                .japanese: "地下鉄路線を尋ねる練習",
                .chinese: "练习询问地铁线路",
                .spanish: "Practica preguntar por la ruta del metro"
            ],
            startingPhrase: "Naik kereta apa ke Monas?",
            startingPhraseTranslations: [
                .korean: "모나스까지 어떤 전철 타야 해요?",
                .english: "Which train to take to Monas?",
                .japanese: "モナスまでどの電車に乗ればいいですか？",
                .chinese: "去莫纳斯坐哪趟地铁？",
                .spanish: "¿Qué tren tomar para Monas?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-metro-response1",
                    speaker: .native,
                    text: "Naik jalur merah, turun di stasiun Gambir.",
                    translations: [
                        .korean: "빨간 노선 타고 감비르역에서 내리세요.",
                        .english: "Take the red line, get off at Gambir station.",
                        .japanese: "赤いラインに乗って、ガンビル駅で降りてください。",
                        .chinese: "坐红线，在甘比尔站下车。",
                        .spanish: "Toma la línea roja, baja en la estación Gambir."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-metro-followup1",
                            speaker: .user,
                            text: "Jauh jalan kaki dari stasiun?",
                            translations: [
                                .korean: "역에서 걸어서 멀어요?",
                                .english: "Is it far to walk from the station?",
                                .japanese: "駅から歩いて遠いですか？",
                                .chinese: "从车站走路远吗？",
                                .spanish: "¿Está lejos caminando desde la estación?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-metro-end1",
                                    speaker: .native,
                                    text: "Nggak, cuma 10 menit jalan kaki.",
                                    translations: [
                                        .korean: "아니요, 걸어서 10분밖에 안 걸려요.",
                                        .english: "No, only a 10-minute walk.",
                                        .japanese: "いいえ、歩いて10分だけです。",
                                        .chinese: "不远，走路只要10分钟。",
                                        .spanish: "No, solo 10 minutos caminando."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-bus-stop",
            learningLanguage: .indonesian,
            icon: "🚌",
            title: [
                .korean: "버스 정류장 찾기",
                .english: "Finding Bus Stop",
                .japanese: "バス停を探す",
                .chinese: "找公交站",
                .spanish: "Buscar parada de autobús"
            ],
            description: [
                .korean: "버스 정류장을 찾는 연습",
                .english: "Practice finding a bus stop",
                .japanese: "バス停を探す練習",
                .chinese: "练习找公交站",
                .spanish: "Practica buscar parada de autobús"
            ],
            startingPhrase: "Halte bis ke mall di mana?",
            startingPhraseTranslations: [
                .korean: "쇼핑몰 가는 버스 정류장이 어디예요?",
                .english: "Where's the bus stop to the mall?",
                .japanese: "モールに行くバス停はどこですか？",
                .chinese: "去商场的公交站在哪？",
                .spanish: "¿Dónde está la parada del autobús al centro comercial?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-bus-response1",
                    speaker: .native,
                    text: "Di seberang jalan, naik bis nomor 12.",
                    translations: [
                        .korean: "길 건너편이요, 12번 버스 타세요.",
                        .english: "Across the street, take bus number 12.",
                        .japanese: "道の向かい側です、12番バスに乗ってください。",
                        .chinese: "在马路对面，坐12路公交。",
                        .spanish: "Al otro lado de la calle, toma el autobús número 12."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-bus-followup1",
                            speaker: .user,
                            text: "Makasih ya!",
                            translations: [
                                .korean: "감사합니다!",
                                .english: "Thanks!",
                                .japanese: "ありがとう！",
                                .chinese: "谢谢！",
                                .spanish: "¡Gracias!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-bus-end1",
                                    speaker: .native,
                                    text: "Sama-sama, hati-hati ya!",
                                    translations: [
                                        .korean: "천만에요, 조심하세요!",
                                        .english: "You're welcome, be careful!",
                                        .japanese: "どういたしまして、気をつけて！",
                                        .chinese: "不客气，小心点！",
                                        .spanish: "De nada, ¡ten cuidado!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-buy-ticket",
            learningLanguage: .indonesian,
            icon: "🎫",
            title: [
                .korean: "티켓 구매",
                .english: "Buying Ticket",
                .japanese: "チケット購入",
                .chinese: "买票",
                .spanish: "Comprar boleto"
            ],
            description: [
                .korean: "교통 티켓을 구매하는 연습",
                .english: "Practice buying transportation ticket",
                .japanese: "交通チケットを買う練習",
                .chinese: "练习买交通票",
                .spanish: "Practica comprar boleto de transporte"
            ],
            startingPhrase: "Saya mau beli tiket ke Bandung.",
            startingPhraseTranslations: [
                .korean: "반둥까지 가는 표를 사고 싶어요.",
                .english: "I'd like to buy a ticket to Bandung.",
                .japanese: "バンドンまでのチケットを買いたいです。",
                .chinese: "我想买到万隆的票。",
                .spanish: "Quiero comprar un boleto a Bandung."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-ticket-response1",
                    speaker: .native,
                    text: "Jam berapa keberangkatannya?",
                    translations: [
                        .korean: "몇 시 출발이세요?",
                        .english: "What time departure?",
                        .japanese: "出発時刻は何時ですか？",
                        .chinese: "几点出发？",
                        .spanish: "¿A qué hora sale?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-ticket-followup1",
                            speaker: .user,
                            text: "Yang pagi, sekitar jam 9.",
                            translations: [
                                .korean: "아침이요, 9시쯤이요.",
                                .english: "Morning, around 9 o'clock.",
                                .japanese: "朝です、9時頃です。",
                                .chinese: "早上的，9点左右。",
                                .spanish: "De mañana, alrededor de las 9."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-ticket-end1",
                                    speaker: .native,
                                    text: "Ada kereta jam 9:15. Total 150 ribu.",
                                    translations: [
                                        .korean: "9시 15분 기차 있어요. 총 15만 루피아예요.",
                                        .english: "There's a train at 9:15. Total 150 thousand.",
                                        .japanese: "9時15分の列車があります。合計15万ルピアです。",
                                        .chinese: "有9点15分的火车。总共15万。",
                                        .spanish: "Hay un tren a las 9:15. Total 150 mil."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-transfer",
            learningLanguage: .indonesian,
            icon: "🔄",
            title: [
                .korean: "환승 문의",
                .english: "Asking About Transfer",
                .japanese: "乗り換えを尋ねる",
                .chinese: "询问换乘",
                .spanish: "Preguntar por transbordo"
            ],
            description: [
                .korean: "환승에 대해 묻는 연습",
                .english: "Practice asking about transfers",
                .japanese: "乗り換えについて尋ねる練習",
                .chinese: "练习询问换乘",
                .spanish: "Practica preguntar por transbordos"
            ],
            startingPhrase: "Perlu ganti kereta nggak?",
            startingPhraseTranslations: [
                .korean: "환승해야 하나요?",
                .english: "Do I need to change trains?",
                .japanese: "乗り換えは必要ですか？",
                .chinese: "需要换车吗？",
                .spanish: "¿Necesito cambiar de tren?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-transfer-response1",
                    speaker: .native,
                    text: "Ya, ganti di stasiun Dukuh Atas.",
                    translations: [
                        .korean: "네, 두쿠 아타스역에서 환승하세요.",
                        .english: "Yes, transfer at Dukuh Atas station.",
                        .japanese: "はい、ドゥクアタス駅で乗り換えてください。",
                        .chinese: "是的，在杜库阿塔斯站换乘。",
                        .spanish: "Sí, transborda en la estación Dukuh Atas."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-transfer-followup1",
                            speaker: .user,
                            text: "Susah nggak nyarinya?",
                            translations: [
                                .korean: "찾기 어려워요?",
                                .english: "Is it hard to find?",
                                .japanese: "見つけるのは難しいですか？",
                                .chinese: "难找吗？",
                                .spanish: "¿Es difícil de encontrar?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-transfer-end1",
                                    speaker: .native,
                                    text: "Nggak, ikutin tanda aja. Gampang kok.",
                                    translations: [
                                        .korean: "아니요, 표지판만 따라가면 돼요. 쉬워요.",
                                        .english: "No, just follow the signs. It's easy.",
                                        .japanese: "いいえ、標識に従うだけです。簡単ですよ。",
                                        .chinese: "不难，跟着指示牌就行。很简单。",
                                        .spanish: "No, solo sigue las señales. Es fácil."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ojek",
            learningLanguage: .indonesian,
            icon: "🏍️",
            title: [
                .korean: "오토바이 택시",
                .english: "Motorcycle Taxi",
                .japanese: "バイクタクシー",
                .chinese: "摩托出租车",
                .spanish: "Taxi moto"
            ],
            description: [
                .korean: "오토바이 택시를 이용하는 연습",
                .english: "Practice using motorcycle taxi",
                .japanese: "バイクタクシーを利用する練習",
                .chinese: "练习使用摩托出租车",
                .spanish: "Practica usar taxi moto"
            ],
            startingPhrase: "Bang, ke stasiun berapa?",
            startingPhraseTranslations: [
                .korean: "형, 역까지 얼마예요?",
                .english: "Bro, how much to the station?",
                .japanese: "兄ちゃん、駅までいくら？",
                .chinese: "大哥，到车站多少钱？",
                .spanish: "Hermano, ¿cuánto a la estación?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-ojek-response1",
                    speaker: .native,
                    text: "15 ribu aja, deket kok.",
                    translations: [
                        .korean: "1만 5천만 주세요, 가까워요.",
                        .english: "Just 15 thousand, it's close.",
                        .japanese: "1万5千だけ、近いですよ。",
                        .chinese: "只要1万5千，很近的。",
                        .spanish: "Solo 15 mil, está cerca."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-ojek-followup1",
                            speaker: .user,
                            text: "Oke, gas!",
                            translations: [
                                .korean: "좋아요, 가요!",
                                .english: "Okay, let's go!",
                                .japanese: "オッケー、行こう！",
                                .chinese: "好的，走吧！",
                                .spanish: "¡Ok, vamos!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-ojek-end1",
                                    speaker: .native,
                                    text: "Siap, duduk yang enak ya.",
                                    translations: [
                                        .korean: "알겠습니다, 편하게 앉으세요.",
                                        .english: "Got it, sit comfortably.",
                                        .japanese: "了解、楽に座ってください。",
                                        .chinese: "好的，坐稳了。",
                                        .spanish: "Listo, siéntate cómodo."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),

        // MARK: - 쇼핑 카테고리
        Scenario(
            id: "id-ask-price",
            learningLanguage: .indonesian,
            icon: "💵",
            title: [
                .korean: "가격 문의",
                .english: "Asking Price",
                .japanese: "価格を尋ねる",
                .chinese: "询问价格",
                .spanish: "Preguntar precio"
            ],
            description: [
                .korean: "가격을 묻는 연습",
                .english: "Practice asking about price",
                .japanese: "価格を尋ねる練習",
                .chinese: "练习询问价格",
                .spanish: "Practica preguntar precio"
            ],
            startingPhrase: "Ini harganya berapa?",
            startingPhraseTranslations: [
                .korean: "이거 얼마예요?",
                .english: "How much is this?",
                .japanese: "これはいくらですか？",
                .chinese: "这个多少钱？",
                .spanish: "¿Cuánto cuesta esto?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-price-response1",
                    speaker: .native,
                    text: "250 ribu. Mau beli?",
                    translations: [
                        .korean: "25만 루피아예요. 사실 거예요?",
                        .english: "250 thousand. Want to buy?",
                        .japanese: "25万ルピアです。買いますか？",
                        .chinese: "25万。要买吗？",
                        .spanish: "250 mil. ¿Quiere comprar?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-price-followup1",
                            speaker: .user,
                            text: "Boleh kurang nggak?",
                            translations: [
                                .korean: "깎아주실 수 있어요?",
                                .english: "Can you give a discount?",
                                .japanese: "値引きできますか？",
                                .chinese: "可以便宜点吗？",
                                .spanish: "¿Puede hacer descuento?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-price-end1",
                                    speaker: .native,
                                    text: "Beli dua, saya kasih 450 ribu total.",
                                    translations: [
                                        .korean: "2개 사시면 총 45만 루피아에 드릴게요.",
                                        .english: "Buy two, I'll give you 450 thousand total.",
                                        .japanese: "2つ買えば、合計45万ルピアにします。",
                                        .chinese: "买两个，我给你总共45万。",
                                        .spanish: "Compre dos, le doy 450 mil en total."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-discount",
            learningLanguage: .indonesian,
            icon: "🏷️",
            title: [
                .korean: "할인 문의",
                .english: "Asking for Discount",
                .japanese: "割引を尋ねる",
                .chinese: "询问折扣",
                .spanish: "Preguntar por descuento"
            ],
            description: [
                .korean: "할인을 요청하는 연습",
                .english: "Practice asking for discount",
                .japanese: "割引をお願いする練習",
                .chinese: "练习询问折扣",
                .spanish: "Practica pedir descuento"
            ],
            startingPhrase: "Ada diskon nggak?",
            startingPhraseTranslations: [
                .korean: "할인 있어요?",
                .english: "Is there a discount?",
                .japanese: "割引はありますか？",
                .chinese: "有折扣吗？",
                .spanish: "¿Hay descuento?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-discount-response1",
                    speaker: .native,
                    text: "Sekarang lagi ada promo 20%.",
                    translations: [
                        .korean: "지금 20% 프로모션 중이에요.",
                        .english: "There's a 20% promotion now.",
                        .japanese: "今20%プロモーション中です。",
                        .chinese: "现在有20%的促销。",
                        .spanish: "Ahora hay una promoción del 20%."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-discount-followup1",
                            speaker: .user,
                            text: "Wah, bagus! Saya beli deh.",
                            translations: [
                                .korean: "와, 좋아요! 살게요.",
                                .english: "Wow, great! I'll buy it.",
                                .japanese: "わあ、いいですね！買います。",
                                .chinese: "哇，太好了！我买了。",
                                .spanish: "¡Wow, genial! Lo compro."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-discount-end1",
                                    speaker: .native,
                                    text: "Terima kasih. Mau bayar tunai atau kartu?",
                                    translations: [
                                        .korean: "감사합니다. 현금으로 하시겠어요, 카드로 하시겠어요?",
                                        .english: "Thank you. Cash or card?",
                                        .japanese: "ありがとうございます。現金かカードですか？",
                                        .chinese: "谢谢。现金还是卡？",
                                        .spanish: "Gracias. ¿Efectivo o tarjeta?"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-size",
            learningLanguage: .indonesian,
            icon: "👕",
            title: [
                .korean: "사이즈 문의",
                .english: "Asking About Size",
                .japanese: "サイズを尋ねる",
                .chinese: "询问尺码",
                .spanish: "Preguntar por talla"
            ],
            description: [
                .korean: "옷 사이즈를 묻는 연습",
                .english: "Practice asking about clothing size",
                .japanese: "服のサイズを尋ねる練習",
                .chinese: "练习询问服装尺码",
                .spanish: "Practica preguntar por talla de ropa"
            ],
            startingPhrase: "Ada ukuran M?",
            startingPhraseTranslations: [
                .korean: "M 사이즈 있어요?",
                .english: "Do you have size M?",
                .japanese: "Mサイズはありますか？",
                .chinese: "有M码吗？",
                .spanish: "¿Tienen talla M?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-size-response1",
                    speaker: .native,
                    text: "Ada. Mau warna apa?",
                    translations: [
                        .korean: "있어요. 무슨 색으로 할래요?",
                        .english: "Yes. What color?",
                        .japanese: "あります。何色がいいですか？",
                        .chinese: "有的。要什么颜色？",
                        .spanish: "Sí. ¿Qué color?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-size-followup1",
                            speaker: .user,
                            text: "Yang hitam ada?",
                            translations: [
                                .korean: "검은색 있어요?",
                                .english: "Do you have black?",
                                .japanese: "黒はありますか？",
                                .chinese: "有黑色的吗？",
                                .spanish: "¿Tienen negro?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-size-end1",
                                    speaker: .native,
                                    text: "Ada, ini ya.",
                                    translations: [
                                        .korean: "있어요, 여기요.",
                                        .english: "Yes, here you go.",
                                        .japanese: "あります、これです。",
                                        .chinese: "有，这是。",
                                        .spanish: "Sí, aquí está."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-try-on",
            learningLanguage: .indonesian,
            icon: "🛍️",
            title: [
                .korean: "입어봐도 되는지",
                .english: "Asking to Try On",
                .japanese: "試着してもいいか尋ねる",
                .chinese: "询问试穿",
                .spanish: "Preguntar si puede probarse"
            ],
            description: [
                .korean: "옷을 입어봐도 되는지 묻는 연습",
                .english: "Practice asking to try on clothes",
                .japanese: "服を試着してもいいか尋ねる練習",
                .chinese: "练习询问试穿衣服",
                .spanish: "Practica preguntar si puede probarse ropa"
            ],
            startingPhrase: "Boleh dicoba dulu?",
            startingPhraseTranslations: [
                .korean: "입어봐도 돼요?",
                .english: "Can I try it on?",
                .japanese: "試着してもいいですか？",
                .chinese: "可以试穿吗？",
                .spanish: "¿Puedo probármelo?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-tryon-response1",
                    speaker: .native,
                    text: "Tentu, ruang gantinya di sana.",
                    translations: [
                        .korean: "물론이죠, 탈의실은 저기예요.",
                        .english: "Of course, the fitting room is over there.",
                        .japanese: "もちろんです、試着室はあちらです。",
                        .chinese: "当然，试衣间在那边。",
                        .spanish: "Por supuesto, el probador está allí."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-tryon-followup1",
                            speaker: .user,
                            text: "Terima kasih.",
                            translations: [
                                .korean: "감사합니다.",
                                .english: "Thank you.",
                                .japanese: "ありがとうございます。",
                                .chinese: "谢谢。",
                                .spanish: "Gracias."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-tryon-end1",
                                    speaker: .native,
                                    text: "Sama-sama, bilang kalau butuh bantuan ya.",
                                    translations: [
                                        .korean: "천만에요, 도움 필요하시면 말씀하세요.",
                                        .english: "You're welcome, let me know if you need help.",
                                        .japanese: "どういたしまして、助けが必要なら言ってくださいね。",
                                        .chinese: "不客气，需要帮助就说。",
                                        .spanish: "De nada, avísame si necesitas ayuda."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-refund",
            learningLanguage: .indonesian,
            icon: "↩️",
            title: [
                .korean: "환불 요청",
                .english: "Asking for Refund",
                .japanese: "返金依頼",
                .chinese: "要求退款",
                .spanish: "Solicitar reembolso"
            ],
            description: [
                .korean: "환불을 요청하는 연습",
                .english: "Practice asking for a refund",
                .japanese: "返金をお願いする練習",
                .chinese: "练习要求退款",
                .spanish: "Practica solicitar reembolso"
            ],
            startingPhrase: "Saya mau retur barang ini.",
            startingPhraseTranslations: [
                .korean: "이거 반품하고 싶어요.",
                .english: "I'd like to return this item.",
                .japanese: "この商品を返品したいです。",
                .chinese: "我想退货。",
                .spanish: "Quiero devolver este artículo."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-refund-response1",
                    speaker: .native,
                    text: "Boleh saya tahu kenapa mau diretur?",
                    translations: [
                        .korean: "왜 반품하시는지 여쭤봐도 될까요?",
                        .english: "May I know why you want to return it?",
                        .japanese: "返品理由をお聞きしてもよろしいですか？",
                        .chinese: "可以问一下为什么要退货吗？",
                        .spanish: "¿Puedo saber por qué quiere devolverlo?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-refund-followup1",
                            speaker: .user,
                            text: "Ukurannya kekecilan.",
                            translations: [
                                .korean: "사이즈가 작아요.",
                                .english: "The size is too small.",
                                .japanese: "サイズが小さすぎます。",
                                .chinese: "尺码太小了。",
                                .spanish: "La talla es muy pequeña."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-refund-end1",
                                    speaker: .native,
                                    text: "Baik, ada struk pembeliannya? Bisa ditukar ukuran lebih besar.",
                                    translations: [
                                        .korean: "네, 영수증 있으세요? 더 큰 사이즈로 교환 가능해요.",
                                        .english: "Okay, do you have the receipt? We can exchange for a larger size.",
                                        .japanese: "わかりました、レシートはありますか？大きいサイズに交換できます。",
                                        .chinese: "好的，有收据吗？可以换大一号的。",
                                        .spanish: "Bien, ¿tiene el recibo? Podemos cambiar por una talla más grande."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-gift-wrap",
            learningLanguage: .indonesian,
            icon: "🎁",
            title: [
                .korean: "선물 포장",
                .english: "Gift Wrapping",
                .japanese: "ギフトラッピング",
                .chinese: "礼品包装",
                .spanish: "Envolver regalo"
            ],
            description: [
                .korean: "선물 포장을 요청하는 연습",
                .english: "Practice requesting gift wrapping",
                .japanese: "ギフトラッピングをお願いする練習",
                .chinese: "练习要求礼品包装",
                .spanish: "Practica solicitar envolver regalo"
            ],
            startingPhrase: "Bisa dibungkus untuk kado?",
            startingPhraseTranslations: [
                .korean: "선물 포장 가능해요?",
                .english: "Can this be gift wrapped?",
                .japanese: "ギフトラッピングできますか？",
                .chinese: "可以包装成礼物吗？",
                .spanish: "¿Pueden envolverlo para regalo?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-giftwrap-response1",
                    speaker: .native,
                    text: "Bisa. Mau pilih kertas kado yang mana?",
                    translations: [
                        .korean: "가능해요. 어떤 포장지로 할까요?",
                        .english: "Yes. Which wrapping paper would you like?",
                        .japanese: "できます。どの包装紙にしますか？",
                        .chinese: "可以。您想选哪种包装纸？",
                        .spanish: "Sí. ¿Qué papel de regalo prefiere?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-giftwrap-followup1",
                            speaker: .user,
                            text: "Yang biru itu bagus.",
                            translations: [
                                .korean: "저 파란색 예쁘네요.",
                                .english: "That blue one is nice.",
                                .japanese: "あの青いのがいいですね。",
                                .chinese: "那个蓝色的不错。",
                                .spanish: "Ese azul está bonito."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-giftwrap-end1",
                                    speaker: .native,
                                    text: "Baik, sebentar ya saya bungkuskan.",
                                    translations: [
                                        .korean: "네, 잠시만요, 포장해드릴게요.",
                                        .english: "Okay, one moment, I'll wrap it for you.",
                                        .japanese: "わかりました、少々お待ちください、包装しますね。",
                                        .chinese: "好的，稍等，我帮您包装。",
                                        .spanish: "Bien, un momento, lo envuelvo."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),

        // MARK: - 관광지 카테고리
        Scenario(
            id: "id-buy-entrance-ticket",
            learningLanguage: .indonesian,
            icon: "🎟️",
            title: [
                .korean: "입장권 구매",
                .english: "Buying Entrance Ticket",
                .japanese: "入場券購入",
                .chinese: "买门票",
                .spanish: "Comprar entrada"
            ],
            description: [
                .korean: "관광지 입장권을 사는 연습",
                .english: "Practice buying entrance ticket",
                .japanese: "観光地の入場券を買う練習",
                .chinese: "练习买景点门票",
                .spanish: "Practica comprar entrada"
            ],
            startingPhrase: "Tiket masuknya berapa?",
            startingPhraseTranslations: [
                .korean: "입장료 얼마예요?",
                .english: "How much is the entrance fee?",
                .japanese: "入場料はいくらですか？",
                .chinese: "门票多少钱？",
                .spanish: "¿Cuánto cuesta la entrada?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-entrance-response1",
                    speaker: .native,
                    text: "50 ribu per orang.",
                    translations: [
                        .korean: "1인당 5만 루피아예요.",
                        .english: "50 thousand per person.",
                        .japanese: "一人5万ルピアです。",
                        .chinese: "每人5万。",
                        .spanish: "50 mil por persona."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-entrance-followup1",
                            speaker: .user,
                            text: "Dua orang ya.",
                            translations: [
                                .korean: "2명이요.",
                                .english: "Two people.",
                                .japanese: "2名です。",
                                .chinese: "两个人。",
                                .spanish: "Dos personas."
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-entrance-end1",
                                    speaker: .native,
                                    text: "Total 100 ribu. Ini tiketnya, selamat menikmati.",
                                    translations: [
                                        .korean: "총 10만 루피아예요. 여기 티켓이요, 즐기세요.",
                                        .english: "Total 100 thousand. Here are your tickets, enjoy.",
                                        .japanese: "合計10万ルピアです。チケットです、お楽しみください。",
                                        .chinese: "总共10万。这是您的票，请享受。",
                                        .spanish: "Total 100 mil. Aquí están sus entradas, disfruten."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-photo",
            learningLanguage: .indonesian,
            icon: "📸",
            title: [
                .korean: "사진 촬영 부탁",
                .english: "Asking for Photo",
                .japanese: "写真撮影依頼",
                .chinese: "请求拍照",
                .spanish: "Pedir foto"
            ],
            description: [
                .korean: "사진 찍어달라고 부탁하는 연습",
                .english: "Practice asking someone to take a photo",
                .japanese: "写真を撮ってもらう練習",
                .chinese: "练习请求拍照",
                .spanish: "Practica pedir que tomen foto"
            ],
            startingPhrase: "Tolong fotokan dong!",
            startingPhraseTranslations: [
                .korean: "사진 좀 찍어주세요!",
                .english: "Please take a photo for me!",
                .japanese: "写真を撮ってください！",
                .chinese: "请帮我拍照！",
                .spanish: "¡Por favor tómeme una foto!"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-photo-response1",
                    speaker: .native,
                    text: "Oke, siap-siap ya. Satu, dua, tiga!",
                    translations: [
                        .korean: "네, 준비하세요. 하나, 둘, 셋!",
                        .english: "Okay, get ready. One, two, three!",
                        .japanese: "オッケー、準備して。いち、に、さん！",
                        .chinese: "好的，准备好。一、二、三！",
                        .spanish: "Ok, prepárense. ¡Uno, dos, tres!"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-photo-followup1",
                            speaker: .user,
                            text: "Satu lagi boleh?",
                            translations: [
                                .korean: "한 장 더 찍어도 될까요?",
                                .english: "Can we take one more?",
                                .japanese: "もう一枚いいですか？",
                                .chinese: "可以再拍一张吗？",
                                .spanish: "¿Podemos tomar una más?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-photo-end1",
                                    speaker: .native,
                                    text: "Boleh banget. Ayo, senyum!",
                                    translations: [
                                        .korean: "물론이죠. 자, 웃으세요!",
                                        .english: "Sure. Come on, smile!",
                                        .japanese: "もちろんです。さあ、笑って！",
                                        .chinese: "当然可以。来，笑一笑！",
                                        .spanish: "Claro. ¡Vamos, sonrían!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-recommendation-place",
            learningLanguage: .indonesian,
            icon: "🗺️",
            title: [
                .korean: "추천 장소 문의",
                .english: "Asking for Place Recommendations",
                .japanese: "おすすめの場所を尋ねる",
                .chinese: "询问推荐地点",
                .spanish: "Preguntar por lugares recomendados"
            ],
            description: [
                .korean: "추천 관광지를 묻는 연습",
                .english: "Practice asking for place recommendations",
                .japanese: "おすすめの観光地を尋ねる練習",
                .chinese: "练习询问推荐景点",
                .spanish: "Practica preguntar por lugares recomendados"
            ],
            startingPhrase: "Ada tempat wisata yang bagus di sini?",
            startingPhraseTranslations: [
                .korean: "여기 좋은 관광지 있어요?",
                .english: "Are there any good tourist spots here?",
                .japanese: "ここにいい観光地はありますか？",
                .chinese: "这里有什么好的旅游景点吗？",
                .spanish: "¿Hay buenos lugares turísticos aquí?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-placerec-response1",
                    speaker: .native,
                    text: "Candi Borobudur bagus banget! Wajib ke sana.",
                    translations: [
                        .korean: "보로부두르 사원 정말 좋아요! 꼭 가보세요.",
                        .english: "Borobudur Temple is really great! You must go there.",
                        .japanese: "ボロブドゥール寺院は本当にいいですよ！絶対に行ってください。",
                        .chinese: "婆罗浮屠非常好！一定要去。",
                        .spanish: "¡El Templo de Borobudur es genial! Debe ir allí."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-placerec-followup1",
                            speaker: .user,
                            text: "Dari sini jauh nggak?",
                            translations: [
                                .korean: "여기서 멀어요?",
                                .english: "Is it far from here?",
                                .japanese: "ここから遠いですか？",
                                .chinese: "从这里远吗？",
                                .spanish: "¿Está lejos de aquí?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-placerec-end1",
                                    speaker: .native,
                                    text: "Sekitar 1 jam naik mobil. Worth it banget kok!",
                                    translations: [
                                        .korean: "차로 1시간 정도요. 정말 가볼 만해요!",
                                        .english: "About 1 hour by car. Totally worth it!",
                                        .japanese: "車で1時間くらいです。本当に行く価値ありますよ！",
                                        .chinese: "开车大约1小时。绝对值得！",
                                        .spanish: "Como 1 hora en auto. ¡Totalmente vale la pena!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-opening-hours",
            learningLanguage: .indonesian,
            icon: "🕐",
            title: [
                .korean: "운영 시간 문의",
                .english: "Asking About Opening Hours",
                .japanese: "営業時間を尋ねる",
                .chinese: "询问营业时间",
                .spanish: "Preguntar por horario"
            ],
            description: [
                .korean: "운영 시간을 묻는 연습",
                .english: "Practice asking about opening hours",
                .japanese: "営業時間を尋ねる練習",
                .chinese: "练习询问营业时间",
                .spanish: "Practica preguntar por el horario"
            ],
            startingPhrase: "Buka sampai jam berapa?",
            startingPhraseTranslations: [
                .korean: "몇 시까지 열어요?",
                .english: "What time is it open until?",
                .japanese: "何時まで開いていますか？",
                .chinese: "开到几点？",
                .spanish: "¿Hasta qué hora abre?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-hours-response1",
                    speaker: .native,
                    text: "Sampai jam 5 sore setiap hari.",
                    translations: [
                        .korean: "매일 오후 5시까지예요.",
                        .english: "Until 5 PM every day.",
                        .japanese: "毎日午後5時までです。",
                        .chinese: "每天到下午5点。",
                        .spanish: "Hasta las 5 PM todos los días."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-hours-followup1",
                            speaker: .user,
                            text: "Hari Minggu juga buka?",
                            translations: [
                                .korean: "일요일에도 열어요?",
                                .english: "Open on Sundays too?",
                                .japanese: "日曜日も開いていますか？",
                                .chinese: "星期天也开吗？",
                                .spanish: "¿También abre los domingos?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-hours-end1",
                                    speaker: .native,
                                    text: "Ya, buka setiap hari kecuali hari libur nasional.",
                                    translations: [
                                        .korean: "네, 국경일 빼고 매일 열어요.",
                                        .english: "Yes, open every day except national holidays.",
                                        .japanese: "はい、祝日以外は毎日開いています。",
                                        .chinese: "是的，除了国定假日每天都开。",
                                        .spanish: "Sí, abre todos los días excepto feriados nacionales."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-guided-tour",
            learningLanguage: .indonesian,
            icon: "👨‍🏫",
            title: [
                .korean: "가이드 투어",
                .english: "Guided Tour",
                .japanese: "ガイドツアー",
                .chinese: "导游服务",
                .spanish: "Tour guiado"
            ],
            description: [
                .korean: "가이드 투어를 신청하는 연습",
                .english: "Practice requesting a guided tour",
                .japanese: "ガイドツアーを申し込む練習",
                .chinese: "练习申请导游服务",
                .spanish: "Practica solicitar un tour guiado"
            ],
            startingPhrase: "Ada tour guide berbahasa Inggris?",
            startingPhraseTranslations: [
                .korean: "영어 가이드 있나요?",
                .english: "Is there an English-speaking tour guide?",
                .japanese: "英語を話すガイドはいますか？",
                .chinese: "有说英语的导游吗？",
                .spanish: "¿Hay guía turístico que hable inglés?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-guide-response1",
                    speaker: .native,
                    text: "Ada. Tour mulai jam 10 pagi.",
                    translations: [
                        .korean: "있어요. 투어는 오전 10시에 시작해요.",
                        .english: "Yes. Tours start at 10 AM.",
                        .japanese: "います。ツアーは午前10時に始まります。",
                        .chinese: "有的。导览从早上10点开始。",
                        .spanish: "Sí. Los tours comienzan a las 10 AM."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-guide-followup1",
                            speaker: .user,
                            text: "Berapa biayanya?",
                            translations: [
                                .korean: "비용이 얼마예요?",
                                .english: "How much does it cost?",
                                .japanese: "費用はいくらですか？",
                                .chinese: "费用是多少？",
                                .spanish: "¿Cuánto cuesta?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-guide-end1",
                                    speaker: .native,
                                    text: "200 ribu per orang untuk tour 2 jam.",
                                    translations: [
                                        .korean: "2시간 투어에 1인당 20만 루피아예요.",
                                        .english: "200 thousand per person for a 2-hour tour.",
                                        .japanese: "2時間ツアーで一人20万ルピアです。",
                                        .chinese: "2小时导览每人20万。",
                                        .spanish: "200 mil por persona para un tour de 2 horas."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),

        // MARK: - 긴급 상황 카테고리
        Scenario(
            id: "id-find-pharmacy",
            learningLanguage: .indonesian,
            icon: "💊",
            title: [
                .korean: "약국 찾기",
                .english: "Finding Pharmacy",
                .japanese: "薬局を探す",
                .chinese: "找药店",
                .spanish: "Buscar farmacia"
            ],
            description: [
                .korean: "약국을 찾는 연습",
                .english: "Practice finding a pharmacy",
                .japanese: "薬局を探す練習",
                .chinese: "练习找药店",
                .spanish: "Practica buscar farmacia"
            ],
            startingPhrase: "Permisi, ada apotek terdekat?",
            startingPhraseTranslations: [
                .korean: "실례합니다, 가까운 약국 있나요?",
                .english: "Excuse me, is there a nearby pharmacy?",
                .japanese: "すみません、近くに薬局はありますか？",
                .chinese: "请问，附近有药店吗？",
                .spanish: "Disculpe, ¿hay una farmacia cerca?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-pharmacy-response1",
                    speaker: .native,
                    text: "Ada, jalan lurus 100 meter, di sebelah kanan.",
                    translations: [
                        .korean: "있어요, 직진 100미터, 오른편에 있어요.",
                        .english: "Yes, go straight 100 meters, on the right side.",
                        .japanese: "あります、まっすぐ100メートル、右側にあります。",
                        .chinese: "有，直走100米，在右边。",
                        .spanish: "Sí, vaya recto 100 metros, al lado derecho."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-pharmacy-followup1",
                            speaker: .user,
                            text: "Sekarang masih buka?",
                            translations: [
                                .korean: "지금 열었어요?",
                                .english: "Is it open now?",
                                .japanese: "今開いていますか？",
                                .chinese: "现在还开着吗？",
                                .spanish: "¿Está abierto ahora?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-pharmacy-end1",
                                    speaker: .native,
                                    text: "Ya, buka sampai jam 10 malam.",
                                    translations: [
                                        .korean: "네, 밤 10시까지 열어요.",
                                        .english: "Yes, open until 10 PM.",
                                        .japanese: "はい、夜10時まで開いています。",
                                        .chinese: "是的，开到晚上10点。",
                                        .spanish: "Sí, abre hasta las 10 PM."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-lost-item",
            learningLanguage: .indonesian,
            icon: "📱",
            title: [
                .korean: "물건 분실",
                .english: "Lost Item",
                .japanese: "紛失物",
                .chinese: "丢失物品",
                .spanish: "Objeto perdido"
            ],
            description: [
                .korean: "물건을 잃어버렸을 때 말하는 연습",
                .english: "Practice reporting a lost item",
                .japanese: "紛失物を報告する練習",
                .chinese: "练习报失物品",
                .spanish: "Practica reportar objeto perdido"
            ],
            startingPhrase: "Saya kehilangan dompet.",
            startingPhraseTranslations: [
                .korean: "지갑을 잃어버렸어요.",
                .english: "I lost my wallet.",
                .japanese: "財布をなくしました。",
                .chinese: "我丢了钱包。",
                .spanish: "Perdí mi billetera."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-lost-response1",
                    speaker: .native,
                    text: "Oh tidak! Terakhir lihat di mana?",
                    translations: [
                        .korean: "오, 안됐네요! 마지막으로 어디서 봤어요?",
                        .english: "Oh no! Where did you last see it?",
                        .japanese: "ああ、大変！最後にどこで見ましたか？",
                        .chinese: "哦不！最后在哪里看到的？",
                        .spanish: "¡Oh no! ¿Dónde lo vio por última vez?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-lost-followup1",
                            speaker: .user,
                            text: "Di restoran tadi. Bisa bantu hubungi mereka?",
                            translations: [
                                .korean: "아까 식당이요. 거기 전화 좀 해주시겠어요?",
                                .english: "At the restaurant earlier. Can you help call them?",
                                .japanese: "さっきのレストランです。電話していただけますか？",
                                .chinese: "刚才在餐厅。能帮我打电话给他们吗？",
                                .spanish: "En el restaurante hace rato. ¿Puede ayudarme a llamarlos?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-lost-end1",
                                    speaker: .native,
                                    text: "Tentu, saya telepon sekarang.",
                                    translations: [
                                        .korean: "물론이죠, 지금 전화할게요.",
                                        .english: "Sure, I'll call them now.",
                                        .japanese: "もちろん、今電話します。",
                                        .chinese: "当然，我现在就打电话。",
                                        .spanish: "Claro, los llamo ahora."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-help",
            learningLanguage: .indonesian,
            icon: "🆘",
            title: [
                .korean: "도움 요청",
                .english: "Asking for Help",
                .japanese: "助けを求める",
                .chinese: "寻求帮助",
                .spanish: "Pedir ayuda"
            ],
            description: [
                .korean: "도움을 요청하는 연습",
                .english: "Practice asking for help",
                .japanese: "助けを求める練習",
                .chinese: "练习寻求帮助",
                .spanish: "Practica pedir ayuda"
            ],
            startingPhrase: "Tolong, saya butuh bantuan!",
            startingPhraseTranslations: [
                .korean: "도와주세요, 도움이 필요해요!",
                .english: "Help, I need assistance!",
                .japanese: "助けて、助けが必要です！",
                .chinese: "救命，我需要帮助！",
                .spanish: "¡Ayuda, necesito asistencia!"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-help-response1",
                    speaker: .native,
                    text: "Ada apa? Saya bisa bantu.",
                    translations: [
                        .korean: "무슨 일이에요? 도와드릴게요.",
                        .english: "What's wrong? I can help.",
                        .japanese: "どうしたんですか？手伝いますよ。",
                        .chinese: "怎么了？我可以帮忙。",
                        .spanish: "¿Qué pasa? Puedo ayudar."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-help-followup1",
                            speaker: .user,
                            text: "Teman saya sakit. Rumah sakit di mana?",
                            translations: [
                                .korean: "제 친구가 아파요. 병원이 어디예요?",
                                .english: "My friend is sick. Where's the hospital?",
                                .japanese: "友達が病気です。病院はどこですか？",
                                .chinese: "我朋友病了。医院在哪里？",
                                .spanish: "Mi amigo está enfermo. ¿Dónde está el hospital?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-help-end1",
                                    speaker: .native,
                                    text: "Saya antarkan dengan mobil saya. Ayo ikut!",
                                    translations: [
                                        .korean: "제 차로 데려다 드릴게요. 같이 가요!",
                                        .english: "I'll take you in my car. Let's go!",
                                        .japanese: "私の車で連れて行きます。一緒に行きましょう！",
                                        .chinese: "我用我的车送你们去。走吧！",
                                        .spanish: "Los llevo en mi auto. ¡Vamos!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-find-hospital",
            learningLanguage: .indonesian,
            icon: "🏥",
            title: [
                .korean: "병원 찾기",
                .english: "Finding Hospital",
                .japanese: "病院を探す",
                .chinese: "找医院",
                .spanish: "Buscar hospital"
            ],
            description: [
                .korean: "병원을 찾는 연습",
                .english: "Practice finding a hospital",
                .japanese: "病院を探す練習",
                .chinese: "练习找医院",
                .spanish: "Practica buscar hospital"
            ],
            startingPhrase: "Rumah sakit terdekat ada di mana?",
            startingPhraseTranslations: [
                .korean: "가장 가까운 병원이 어디예요?",
                .english: "Where's the nearest hospital?",
                .japanese: "一番近い病院はどこですか？",
                .chinese: "最近的医院在哪里？",
                .spanish: "¿Dónde está el hospital más cercano?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-hospital-response1",
                    speaker: .native,
                    text: "RS Husada, sekitar 5 menit dari sini.",
                    translations: [
                        .korean: "후사다 병원이요, 여기서 5분 정도 걸려요.",
                        .english: "Husada Hospital, about 5 minutes from here.",
                        .japanese: "フサダ病院です、ここから5分ほどです。",
                        .chinese: "胡萨达医院，离这里大约5分钟。",
                        .spanish: "Hospital Husada, como 5 minutos de aquí."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-hospital-followup1",
                            speaker: .user,
                            text: "Ada UGD?",
                            translations: [
                                .korean: "응급실 있어요?",
                                .english: "Does it have an ER?",
                                .japanese: "救急があります か？",
                                .chinese: "有急诊吗？",
                                .spanish: "¿Tiene emergencias?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-hospital-end1",
                                    speaker: .native,
                                    text: "Ada, 24 jam. Saya tunjukkan jalan ya.",
                                    translations: [
                                        .korean: "있어요, 24시간이에요. 제가 길 알려드릴게요.",
                                        .english: "Yes, 24 hours. Let me show you the way.",
                                        .japanese: "あります、24時間です。道を教えますね。",
                                        .chinese: "有，24小时。我给你指路。",
                                        .spanish: "Sí, 24 horas. Le muestro el camino."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),

        // MARK: - 현지인과 교류 카테고리
        Scenario(
            id: "id-weather-chat",
            learningLanguage: .indonesian,
            icon: "🌤️",
            title: [
                .korean: "날씨 대화",
                .english: "Weather Chat",
                .japanese: "天気の話",
                .chinese: "聊天气",
                .spanish: "Hablar del clima"
            ],
            description: [
                .korean: "날씨에 대해 이야기하는 연습",
                .english: "Practice talking about weather",
                .japanese: "天気について話す練習",
                .chinese: "练习聊天气",
                .spanish: "Practica hablar del clima"
            ],
            startingPhrase: "Cuacanya panas banget ya hari ini!",
            startingPhraseTranslations: [
                .korean: "오늘 날씨 정말 덥네요!",
                .english: "The weather is really hot today!",
                .japanese: "今日は本当に暑いですね！",
                .chinese: "今天天气真热啊！",
                .spanish: "¡El clima está muy caluroso hoy!"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-weather-response1",
                    speaker: .native,
                    text: "Iya, biasanya sih gini. Sudah biasa di sini.",
                    translations: [
                        .korean: "네, 원래 이래요. 여기는 원래 그래요.",
                        .english: "Yeah, it's usually like this. Normal here.",
                        .japanese: "ええ、いつもこんな感じです。ここは普通ですよ。",
                        .chinese: "是啊，一般都这样。这里习以为常。",
                        .spanish: "Sí, usualmente es así. Normal aquí."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-weather-followup1",
                            speaker: .user,
                            text: "Sore nanti hujan nggak ya?",
                            translations: [
                                .korean: "오후에 비 올까요?",
                                .english: "Will it rain this afternoon?",
                                .japanese: "午後に雨が降りますかね？",
                                .chinese: "下午会下雨吗？",
                                .spanish: "¿Lloverá esta tarde?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-weather-end1",
                                    speaker: .native,
                                    text: "Kayaknya sih iya. Bawa payung aja buat jaga-jaga.",
                                    translations: [
                                        .korean: "올 것 같아요. 혹시 몰라 우산 가져가세요.",
                                        .english: "Probably yes. Bring an umbrella just in case.",
                                        .japanese: "たぶんそうですね。念のため傘を持っていってください。",
                                        .chinese: "可能会。带把伞以防万一。",
                                        .spanish: "Probablemente sí. Traiga paraguas por si acaso."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-where-from",
            learningLanguage: .indonesian,
            icon: "🌍",
            title: [
                .korean: "어디서 왔는지",
                .english: "Where You're From",
                .japanese: "出身地の話",
                .chinese: "聊来自哪里",
                .spanish: "De dónde eres"
            ],
            description: [
                .korean: "어디서 왔는지 이야기하는 연습",
                .english: "Practice talking about where you're from",
                .japanese: "出身について話す練習",
                .chinese: "练习聊来自哪里",
                .spanish: "Practica hablar de dónde eres"
            ],
            startingPhrase: "Saya dari Korea.",
            startingPhraseTranslations: [
                .korean: "저는 한국에서 왔어요.",
                .english: "I'm from Korea.",
                .japanese: "私は韓国から来ました。",
                .chinese: "我来自韩国。",
                .spanish: "Soy de Corea."
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-from-response1",
                    speaker: .native,
                    text: "Wah, Korea! Suka K-pop?",
                    translations: [
                        .korean: "와, 한국이요! K-pop 좋아하세요?",
                        .english: "Wow, Korea! Do you like K-pop?",
                        .japanese: "わあ、韓国！K-popは好きですか？",
                        .chinese: "哇，韩国！喜欢K-pop吗？",
                        .spanish: "¡Wow, Corea! ¿Te gusta el K-pop?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-from-followup1",
                            speaker: .user,
                            text: "Lumayan suka. Kamu tahu artis Korea?",
                            translations: [
                                .korean: "꽤 좋아해요. 한국 가수 알아요?",
                                .english: "I like it quite a bit. Do you know Korean artists?",
                                .japanese: "まあまあ好きです。韓国のアーティスト知ってますか？",
                                .chinese: "还挺喜欢的。你知道韩国艺人吗？",
                                .spanish: "Me gusta bastante. ¿Conoces artistas coreanos?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-from-end1",
                                    speaker: .native,
                                    text: "BTS sama Blackpink! Keren banget!",
                                    translations: [
                                        .korean: "BTS랑 블랙핑크요! 정말 멋져요!",
                                        .english: "BTS and Blackpink! They're so cool!",
                                        .japanese: "BTSとBlackpink！すごいですよね！",
                                        .chinese: "BTS和Blackpink！超酷的！",
                                        .spanish: "¡BTS y Blackpink! ¡Son geniales!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-recommend-food",
            learningLanguage: .indonesian,
            icon: "🍲",
            title: [
                .korean: "추천 맛집",
                .english: "Recommending Food",
                .japanese: "おすすめの食べ物",
                .chinese: "推荐美食",
                .spanish: "Recomendar comida"
            ],
            description: [
                .korean: "맛집을 추천받는 연습",
                .english: "Practice getting food recommendations",
                .japanese: "おすすめの店を聞く練習",
                .chinese: "练习获得美食推荐",
                .spanish: "Practica recibir recomendaciones de comida"
            ],
            startingPhrase: "Ada warung makan enak di sekitar sini?",
            startingPhraseTranslations: [
                .korean: "이 근처에 맛있는 식당 있어요?",
                .english: "Are there any good eateries around here?",
                .japanese: "この辺においしい食堂はありますか？",
                .chinese: "这附近有好吃的餐馆吗？",
                .spanish: "¿Hay buenos restaurantes por aquí?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-foodrec-response1",
                    speaker: .native,
                    text: "Ada! Warung Pak Budi, soto ayamnya juara!",
                    translations: [
                        .korean: "있어요! 빠 부디 식당, 소토 아얌이 최고예요!",
                        .english: "Yes! Pak Budi's eatery, their chicken soto is the best!",
                        .japanese: "あります！パックブディの食堂、チキンソトが最高です！",
                        .chinese: "有！布迪大叔的餐馆，鸡肉汤是最棒的！",
                        .spanish: "¡Sí! El puesto de Pak Budi, ¡su soto de pollo es el mejor!"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-foodrec-followup1",
                            speaker: .user,
                            text: "Jauh nggak dari sini?",
                            translations: [
                                .korean: "여기서 멀어요?",
                                .english: "Is it far from here?",
                                .japanese: "ここから遠いですか？",
                                .chinese: "离这里远吗？",
                                .spanish: "¿Está lejos de aquí?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-foodrec-end1",
                                    speaker: .native,
                                    text: "Dekat kok, jalan kaki 5 menit. Wajib coba!",
                                    translations: [
                                        .korean: "가까워요, 걸어서 5분이에요. 꼭 먹어봐야 해요!",
                                        .english: "Close, 5-minute walk. You must try it!",
                                        .japanese: "近いですよ、歩いて5分です。絶対に試してください！",
                                        .chinese: "很近，走路5分钟。一定要试试！",
                                        .spanish: "Cerca, 5 minutos caminando. ¡Debes probarlo!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-ask-directions",
            learningLanguage: .indonesian,
            icon: "🧭",
            title: [
                .korean: "길 물어보기",
                .english: "Asking for Directions",
                .japanese: "道を尋ねる",
                .chinese: "问路",
                .spanish: "Preguntar direcciones"
            ],
            description: [
                .korean: "길을 묻는 연습",
                .english: "Practice asking for directions",
                .japanese: "道を尋ねる練習",
                .chinese: "练习问路",
                .spanish: "Practica preguntar direcciones"
            ],
            startingPhrase: "Maaf, ke stasiun gimana ya?",
            startingPhraseTranslations: [
                .korean: "죄송한데요, 역까지 어떻게 가요?",
                .english: "Excuse me, how do I get to the station?",
                .japanese: "すみません、駅までどう行きますか？",
                .chinese: "不好意思，怎么去车站？",
                .spanish: "Disculpe, ¿cómo llego a la estación?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-directions-response1",
                    speaker: .native,
                    text: "Lurus aja sampai perempatan, terus belok kiri.",
                    translations: [
                        .korean: "쭉 가다가 사거리에서 왼쪽으로 도세요.",
                        .english: "Just go straight to the intersection, then turn left.",
                        .japanese: "交差点までまっすぐ行って、左に曲がってください。",
                        .chinese: "一直走到十字路口，然后左转。",
                        .spanish: "Sigue recto hasta el cruce, luego gira a la izquierda."
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-directions-followup1",
                            speaker: .user,
                            text: "Makasih ya! Kira-kira berapa menit jalan kaki?",
                            translations: [
                                .korean: "감사합니다! 걸어서 몇 분 정도요?",
                                .english: "Thank you! About how many minutes walking?",
                                .japanese: "ありがとう！歩いて何分くらいですか？",
                                .chinese: "谢谢！走路大概几分钟？",
                                .spanish: "¡Gracias! ¿Cuántos minutos caminando?"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-directions-end1",
                                    speaker: .native,
                                    text: "Sekitar 10 menit aja. Santai.",
                                    translations: [
                                        .korean: "10분 정도요. 천천히 가세요.",
                                        .english: "About 10 minutes. Take it easy.",
                                        .japanese: "10分くらいです。ゆっくりどうぞ。",
                                        .chinese: "大约10分钟。慢慢走。",
                                        .spanish: "Como 10 minutos. Tranquilo."
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        Scenario(
            id: "id-greeting-chat",
            learningLanguage: .indonesian,
            icon: "👋",
            title: [
                .korean: "인사 나누기",
                .english: "Greeting Chat",
                .japanese: "挨拶の会話",
                .chinese: "打招呼聊天",
                .spanish: "Charla de saludo"
            ],
            description: [
                .korean: "현지인과 인사를 나누는 연습",
                .english: "Practice greeting locals",
                .japanese: "現地の人と挨拶する練習",
                .chinese: "练习和当地人打招呼",
                .spanish: "Practica saludar a locales"
            ],
            startingPhrase: "Halo! Apa kabar?",
            startingPhraseTranslations: [
                .korean: "안녕하세요! 어떻게 지내세요?",
                .english: "Hello! How are you?",
                .japanese: "こんにちは！お元気ですか？",
                .chinese: "你好！你好吗？",
                .spanish: "¡Hola! ¿Cómo estás?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "id-greeting-response1",
                    speaker: .native,
                    text: "Baik! Kamu baru datang ke Indonesia?",
                    translations: [
                        .korean: "잘 지내요! 인도네시아에 막 오셨어요?",
                        .english: "Good! Did you just arrive in Indonesia?",
                        .japanese: "元気です！インドネシアに来たばかりですか？",
                        .chinese: "很好！你刚到印度尼西亚吗？",
                        .spanish: "¡Bien! ¿Acabas de llegar a Indonesia?"
                    ],
                    responses: [
                        ConversationNode(
                            id: "id-greeting-followup1",
                            speaker: .user,
                            text: "Iya, kemarin baru sampai. Senang bisa ke sini!",
                            translations: [
                                .korean: "네, 어제 막 도착했어요. 여기 와서 기뻐요!",
                                .english: "Yes, just arrived yesterday. Happy to be here!",
                                .japanese: "はい、昨日着いたばかりです。ここに来られて嬉しいです！",
                                .chinese: "是的，昨天刚到。很高兴来这里！",
                                .spanish: "Sí, llegué ayer. ¡Feliz de estar aquí!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "id-greeting-end1",
                                    speaker: .native,
                                    text: "Selamat datang! Kalau butuh bantuan, bilang aja ya!",
                                    translations: [
                                        .korean: "환영합니다! 도움 필요하면 말씀하세요!",
                                        .english: "Welcome! If you need help, just let me know!",
                                        .japanese: "ようこそ！助けが必要なら言ってくださいね！",
                                        .chinese: "欢迎！需要帮助就说！",
                                        .spanish: "¡Bienvenido! ¡Si necesitas ayuda, avísame!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        )
    ]

    // MARK: - 한국어 시나리오
    static let koreanScenarios: [Scenario] = [
        Scenario(
            id: "ko-bathroom",
            learningLanguage: .korean,
            icon: "🚻",
            title: [
                .english: "Finding the Bathroom",
                .indonesian: "Mencari Toilet",
                .japanese: "トイレを探す",
                .chinese: "找厕所",
                .spanish: "Buscar el baño"
            ],
            description: [
                .english: "Practice asking for bathroom location",
                .indonesian: "Latihan menanyakan lokasi toilet",
                .japanese: "トイレの場所を尋ねる練習",
                .chinese: "练习询问厕所位置",
                .spanish: "Practica preguntar por el baño"
            ],
            startingPhrase: "화장실이 어디에요?",
            startingPhraseTranslations: [
                .english: "Where is the bathroom?",
                .indonesian: "Di mana toilet?",
                .japanese: "トイレはどこですか？",
                .chinese: "厕所在哪里？",
                .spanish: "¿Dónde está el baño?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "ko-response1",
                    speaker: .native,
                    text: "저기 왼쪽으로 쭉 가시면 있어요.",
                    translations: [
                        .english: "Go straight to the left over there.",
                        .indonesian: "Di sana, belok kiri terus jalan lurus.",
                        .japanese: "あそこを左にまっすぐ行くとあります。",
                        .chinese: "往那边左转一直走就到了。",
                        .spanish: "Sigue recto a la izquierda por allí."
                    ],
                    responses: [
                        ConversationNode(
                            id: "ko-followup1-1",
                            speaker: .user,
                            text: "감사합니다!",
                            translations: [
                                .english: "Thank you!",
                                .indonesian: "Terima kasih!",
                                .japanese: "ありがとうございます！",
                                .chinese: "谢谢！",
                                .spanish: "¡Gracias!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "ko-end1-1",
                                    speaker: .native,
                                    text: "네, 천만에요!",
                                    translations: [
                                        .english: "You're welcome!",
                                        .indonesian: "Sama-sama!",
                                        .japanese: "どういたしまして！",
                                        .chinese: "不客气！",
                                        .spanish: "¡De nada!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        )
    ]

    // MARK: - 영어 시나리오
    static let englishScenarios: [Scenario] = [
        Scenario(
            id: "en-bathroom",
            learningLanguage: .english,
            icon: "🚻",
            title: [
                .korean: "화장실 찾기",
                .indonesian: "Mencari Toilet",
                .japanese: "トイレを探す",
                .chinese: "找厕所",
                .spanish: "Buscar el baño"
            ],
            description: [
                .korean: "화장실 위치를 물어보는 연습",
                .indonesian: "Latihan menanyakan lokasi toilet",
                .japanese: "トイレの場所を尋ねる練習",
                .chinese: "练习询问厕所位置",
                .spanish: "Practica preguntar por el baño"
            ],
            startingPhrase: "Excuse me, where is the restroom?",
            startingPhraseTranslations: [
                .korean: "실례합니다, 화장실이 어디에요?",
                .indonesian: "Permisi, di mana toilet?",
                .japanese: "すみません、トイレはどこですか？",
                .chinese: "请问，洗手间在哪里？",
                .spanish: "Disculpe, ¿dónde está el baño?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "en-response1",
                    speaker: .native,
                    text: "It's down the hall on your left.",
                    translations: [
                        .korean: "복도 끝 왼쪽에 있어요.",
                        .indonesian: "Di ujung lorong, sebelah kiri.",
                        .japanese: "廊下の突き当たり、左側にあります。",
                        .chinese: "在走廊尽头的左边。",
                        .spanish: "Está al final del pasillo a la izquierda."
                    ],
                    responses: [
                        ConversationNode(
                            id: "en-followup1-1",
                            speaker: .user,
                            text: "Thank you so much!",
                            translations: [
                                .korean: "정말 감사합니다!",
                                .indonesian: "Terima kasih banyak!",
                                .japanese: "どうもありがとうございます！",
                                .chinese: "非常感谢！",
                                .spanish: "¡Muchas gracias!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "en-end1-1",
                                    speaker: .native,
                                    text: "You're welcome!",
                                    translations: [
                                        .korean: "천만에요!",
                                        .indonesian: "Sama-sama!",
                                        .japanese: "どういたしまして！",
                                        .chinese: "不客气！",
                                        .spanish: "¡De nada!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        )
    ]

    // MARK: - 일본어 시나리오
    static let japaneseScenarios: [Scenario] = [
        Scenario(
            id: "ja-bathroom",
            learningLanguage: .japanese,
            icon: "🚻",
            title: [
                .korean: "화장실 찾기",
                .english: "Finding the Bathroom",
                .indonesian: "Mencari Toilet",
                .chinese: "找厕所",
                .spanish: "Buscar el baño"
            ],
            description: [
                .korean: "화장실 위치를 물어보는 연습",
                .english: "Practice asking for bathroom location",
                .indonesian: "Latihan menanyakan lokasi toilet",
                .chinese: "练习询问厕所位置",
                .spanish: "Practica preguntar por el baño"
            ],
            startingPhrase: "すみません、トイレはどこですか？",
            startingPhraseTranslations: [
                .korean: "실례합니다, 화장실이 어디에요?",
                .english: "Excuse me, where is the restroom?",
                .indonesian: "Permisi, di mana toilet?",
                .chinese: "请问，洗手间在哪里？",
                .spanish: "Disculpe, ¿dónde está el baño?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "ja-response1",
                    speaker: .native,
                    text: "あそこの左側にありますよ。",
                    translations: [
                        .korean: "저기 왼쪽에 있어요.",
                        .english: "It's on the left over there.",
                        .indonesian: "Di sana sebelah kiri.",
                        .chinese: "在那边的左边。",
                        .spanish: "Está a la izquierda por allí."
                    ],
                    responses: [
                        ConversationNode(
                            id: "ja-followup1-1",
                            speaker: .user,
                            text: "ありがとうございます！",
                            translations: [
                                .korean: "감사합니다!",
                                .english: "Thank you!",
                                .indonesian: "Terima kasih!",
                                .chinese: "谢谢！",
                                .spanish: "¡Gracias!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "ja-end1-1",
                                    speaker: .native,
                                    text: "どういたしまして！",
                                    translations: [
                                        .korean: "천만에요!",
                                        .english: "You're welcome!",
                                        .indonesian: "Sama-sama!",
                                        .chinese: "不客气！",
                                        .spanish: "¡De nada!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        )
    ]

    // MARK: - 중국어 시나리오
    static let chineseScenarios: [Scenario] = [
        Scenario(
            id: "zh-bathroom",
            learningLanguage: .chinese,
            icon: "🚻",
            title: [
                .korean: "화장실 찾기",
                .english: "Finding the Bathroom",
                .indonesian: "Mencari Toilet",
                .japanese: "トイレを探す",
                .spanish: "Buscar el baño"
            ],
            description: [
                .korean: "화장실 위치를 물어보는 연습",
                .english: "Practice asking for bathroom location",
                .indonesian: "Latihan menanyakan lokasi toilet",
                .japanese: "トイレの場所を尋ねる練習",
                .spanish: "Practica preguntar por el baño"
            ],
            startingPhrase: "请问，洗手间在哪里？",
            startingPhraseTranslations: [
                .korean: "실례합니다, 화장실이 어디에요?",
                .english: "Excuse me, where is the restroom?",
                .indonesian: "Permisi, di mana toilet?",
                .japanese: "すみません、トイレはどこですか？",
                .spanish: "Disculpe, ¿dónde está el baño?"
            ],
            conversationTree: [
                ConversationNode(
                    id: "zh-response1",
                    speaker: .native,
                    text: "在那边，左转就到了。",
                    translations: [
                        .korean: "저기요, 왼쪽으로 가면 있어요.",
                        .english: "Over there, turn left and you'll find it.",
                        .indonesian: "Di sana, belok kiri.",
                        .japanese: "あそこです、左に曲がればあります。",
                        .spanish: "Por allí, gira a la izquierda."
                    ],
                    responses: [
                        ConversationNode(
                            id: "zh-followup1-1",
                            speaker: .user,
                            text: "谢谢！",
                            translations: [
                                .korean: "감사합니다!",
                                .english: "Thank you!",
                                .indonesian: "Terima kasih!",
                                .japanese: "ありがとうございます！",
                                .spanish: "¡Gracias!"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "zh-end1-1",
                                    speaker: .native,
                                    text: "不客气！",
                                    translations: [
                                        .korean: "천만에요!",
                                        .english: "You're welcome!",
                                        .indonesian: "Sama-sama!",
                                        .japanese: "どういたしまして！",
                                        .spanish: "¡De nada!"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        )
    ]

    // MARK: - 스페인어 시나리오
    static let spanishScenarios: [Scenario] = [
        Scenario(
            id: "es-bathroom",
            learningLanguage: .spanish,
            icon: "🚻",
            title: [
                .korean: "화장실 찾기",
                .english: "Finding the Bathroom",
                .indonesian: "Mencari Toilet",
                .japanese: "トイレを探す",
                .chinese: "找厕所"
            ],
            description: [
                .korean: "화장실 위치를 물어보는 연습",
                .english: "Practice asking for bathroom location",
                .indonesian: "Latihan menanyakan lokasi toilet",
                .japanese: "トイレの場所を尋ねる練習",
                .chinese: "练习询问厕所位置"
            ],
            startingPhrase: "Disculpe, ¿dónde está el baño?",
            startingPhraseTranslations: [
                .korean: "실례합니다, 화장실이 어디에요?",
                .english: "Excuse me, where is the bathroom?",
                .indonesian: "Permisi, di mana toilet?",
                .japanese: "すみません、トイレはどこですか？",
                .chinese: "请问，洗手间在哪里？"
            ],
            conversationTree: [
                ConversationNode(
                    id: "es-response1",
                    speaker: .native,
                    text: "Está al fondo a la izquierda.",
                    translations: [
                        .korean: "안쪽 왼편에 있어요.",
                        .english: "It's at the back on the left.",
                        .indonesian: "Di belakang sebelah kiri.",
                        .japanese: "奥の左側にあります。",
                        .chinese: "在里面的左边。"
                    ],
                    responses: [
                        ConversationNode(
                            id: "es-followup1-1",
                            speaker: .user,
                            text: "¡Muchas gracias!",
                            translations: [
                                .korean: "정말 감사합니다!",
                                .english: "Thank you very much!",
                                .indonesian: "Terima kasih banyak!",
                                .japanese: "どうもありがとうございます！",
                                .chinese: "非常感谢！"
                            ],
                            responses: [
                                ConversationNode(
                                    id: "es-end1-1",
                                    speaker: .native,
                                    text: "¡De nada!",
                                    translations: [
                                        .korean: "천만에요!",
                                        .english: "You're welcome!",
                                        .indonesian: "Sama-sama!",
                                        .japanese: "どういたしまして！",
                                        .chinese: "不客气！"
                                    ],
                                    responses: nil
                                )
                            ]
                        )
                    ]
                )
            ]
        )
    ]
}
