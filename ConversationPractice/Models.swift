import Foundation

// MARK: - 언어 모델 (모국어 & 학습 언어 공통)
enum Language: String, CaseIterable, Identifiable, Codable {
    case korean = "ko-KR"
    case english = "en-US"
    case japanese = "ja-JP"
    case chinese = "zh-CN"
    case spanish = "es-ES"
    case indonesian = "id-ID"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .korean: return "한국어"
        case .english: return "English"
        case .japanese: return "日本語"
        case .chinese: return "中文"
        case .spanish: return "Español"
        case .indonesian: return "Bahasa Indonesia"
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
