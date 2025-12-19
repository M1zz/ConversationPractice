import SwiftUI

extension ScenarioData {
static let japaneseScenarios: [Scenario] = [

    Scenario(
        id: "ja-bathroom",
        learningLanguage: .japanese,
        category: .basic,
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
        startingPhrase: "トイレはどこですか？",
        startingPhraseTranslations: [
            .korean: "화장실이 어디에요?",
            .english: "Where is the bathroom?",
            .japanese: "トイレはどこですか？",
            .chinese: "厕所在哪里？",
            .spanish: "¿Dónde está el baño?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-response1",
                speaker: .native,
                text: "あそこです、左に曲がってまっすぐ行ってください。",
                translations: [
                    .korean: "저기요, 왼쪽으로 돌아서 직진하세요.",
                    .english: "Over there, turn left and go straight.",
                    .japanese: "あそこです、左に曲がってまっすぐ行ってください。",
                    .chinese: "在那边，左转然后直走。",
                    .spanish: "Por allí, gira a la izquierda y sigue recto."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-followup1-1",
                        speaker: .user,
                        text: "ありがとうございます！",
                        translations: [
                            .korean: "감사합니다!",
                            .english: "Thank you!",
                            .japanese: "ありがとうございます！",
                            .chinese: "谢谢！",
                            .spanish: "¡Gracias!"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-continue1-1",
                                speaker: .native,
                                text: "どういたしまして！",
                                translations: [
                                    .korean: "천만에요!",
                                    .english: "You're welcome!",
                                    .japanese: "どういたしまして！",
                                    .chinese: "不客气！",
                                    .spanish: "¡De nada!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-followup1-1-2",
                                        speaker: .user,
                                        text: "障害者用トイレはありますか？",
                                        translations: [
                                            .korean: "장애인 화장실도 있나요?",
                                            .english: "Is there a disabled toilet?",
                                            .japanese: "障害者用トイレはありますか？",
                                            .chinese: "有残疾人厕所吗？",
                                            .spanish: "¿Hay baño para discapacitados?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-end1-1",
                                                speaker: .native,
                                                text: "はい、普通のトイレの隣にあります。",
                                                translations: [
                                                    .korean: "네, 일반 화장실 옆에 있어요.",
                                                    .english: "Yes, it's next to the regular toilet.",
                                                    .japanese: "はい、普通のトイレの隣にあります。",
                                                    .chinese: "是的，在普通厕所旁边。",
                                                    .spanish: "Sí, está al lado del baño normal."
                                                ],
                                                responses: nil
                                            )
                                        ]
                                    )
                                ]
                            )
                        ]
                    ),
                    ConversationNode(
                        id: "ja-followup1-2",
                        speaker: .user,
                        text: "ここから遠いですか？",
                        translations: [
                            .korean: "여기서 멀어요?",
                            .english: "Is it far from here?",
                            .japanese: "ここから遠いですか？",
                            .chinese: "离这里远吗？",
                            .spanish: "¿Está lejos de aquí?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-clarify1-2",
                                speaker: .native,
                                text: "いいえ、歩いて1分です。",
                                translations: [
                                    .korean: "아니요, 걸어서 1분이에요.",
                                    .english: "No, just one minute walk.",
                                    .japanese: "いいえ、歩いて1分です。",
                                    .chinese: "不远，走路只要一分钟。",
                                    .spanish: "No, solo un minuto caminando."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-continue1-2",
                                        speaker: .user,
                                        text: "わかりました、ありがとう！",
                                        translations: [
                                            .korean: "네, 감사합니다!",
                                            .english: "Okay, thank you!",
                                            .japanese: "わかりました、ありがとう！",
                                            .chinese: "好的，谢谢！",
                                            .spanish: "Vale, ¡gracias!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-end1-2",
                                                speaker: .native,
                                                text: "どういたしまして、気をつけてね！",
                                                translations: [
                                                    .korean: "천만에요, 조심히 가세요!",
                                                    .english: "You're welcome, be careful!",
                                                    .japanese: "どういたしまして、気をつけてね！",
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
                    )
                ]
            )
        ]
    ),
    Scenario(
        id: "ja-ordering",
        learningLanguage: .japanese,
        category: .restaurant,
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
        startingPhrase: "注文したいです。",
        startingPhraseTranslations: [
            .korean: "주문하고 싶어요.",
            .english: "I'd like to order.",
            .japanese: "注文したいです。",
            .chinese: "我想点餐。",
            .spanish: "Quiero pedir."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-order-response1",
                speaker: .native,
                text: "はい、何を注文しますか？",
                translations: [
                    .korean: "네, 뭘 주문하시겠어요?",
                    .english: "Yes, what would you like to order?",
                    .japanese: "はい、何を注文しますか？",
                    .chinese: "好的，您想点什么？",
                    .spanish: "Sí, ¿qué quiere pedir?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-order-followup1-1",
                        speaker: .user,
                        text: "ナシゴレン一つください。",
                        translations: [
                            .korean: "나시고랭 하나요.",
                            .english: "One fried rice please.",
                            .japanese: "ナシゴレン一つください。",
                            .chinese: "一份炒饭。",
                            .spanish: "Un arroz frito."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-order-clarify1-1",
                                speaker: .native,
                                text: "辛いのは大丈夫ですか？",
                                translations: [
                                    .korean: "매운 거 괜찮으세요?",
                                    .english: "Spicy or not?",
                                    .japanese: "辛いのは大丈夫ですか？",
                                    .chinese: "要辣的还是不辣的？",
                                    .spanish: "¿Picante o no?"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-order-continue1-1a",
                                        speaker: .user,
                                        text: "辛くないのでお願いします。",
                                        translations: [
                                            .korean: "안 매운 걸로요, 감사합니다.",
                                            .english: "Not spicy, thank you.",
                                            .japanese: "辛くないのでお願いします。",
                                            .chinese: "不要辣的，谢谢。",
                                            .spanish: "No picante, gracias."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-order-end1-1a",
                                                speaker: .native,
                                                text: "わかりました、辛くないナシゴレンですね。少々お待ちください。",
                                                translations: [
                                                    .korean: "알겠습니다, 안 매운 나시고랭이요. 잠시만 기다려주세요.",
                                                    .english: "Okay, fried rice not spicy. Please wait a moment.",
                                                    .japanese: "わかりました、辛くないナシゴレンですね。少々お待ちください。",
                                                    .chinese: "好的，不辣的炒饭。请稍等。",
                                                    .spanish: "Bien, arroz frito no picante. Espere un momento."
                                                ],
                                                responses: nil
                                            )
                                        ]
                                    ),
                                    ConversationNode(
                                        id: "ja-order-continue1-1b",
                                        speaker: .user,
                                        text: "少しだけ辛くしてください。",
                                        translations: [
                                            .korean: "조금만 맵게 해주세요.",
                                            .english: "Just a little spicy.",
                                            .japanese: "少しだけ辛くしてください。",
                                            .chinese: "稍微辣一点就好。",
                                            .spanish: "Solo un poco picante."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-order-end1-1b",
                                                speaker: .native,
                                                text: "わかりました、少し辛くしますね。少々お待ちください。",
                                                translations: [
                                                    .korean: "알겠습니다, 조금만 맵게 만들어드릴게요. 잠시만요.",
                                                    .english: "Okay, I'll make it a little spicy. Just a moment.",
                                                    .japanese: "わかりました、少し辛くしますね。少々お待ちください。",
                                                    .chinese: "好的，我会做得稍微辣一点。请稍等。",
                                                    .spanish: "Bien, lo haré un poco picante. Un momento."
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
    ),

    // MARK: - 공항/비행기 카테고리
    Scenario(
        id: "ja-airport-checkin",
        learningLanguage: .japanese,
        category: .airport,
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
        startingPhrase: "チェックインしたいです。",
        startingPhraseTranslations: [
            .korean: "체크인하고 싶어요.",
            .english: "I'd like to check in.",
            .japanese: "チェックインしたいです。",
            .chinese: "我想办理值机。",
            .spanish: "Quiero hacer el check-in."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-checkin-response1",
                speaker: .native,
                text: "パスポートとチケットを見せていただけますか？",
                translations: [
                    .korean: "여권과 티켓 좀 보여주시겠어요?",
                    .english: "May I see your passport and ticket?",
                    .japanese: "パスポートとチケットを見せていただけますか？",
                    .chinese: "可以看一下您的护照和机票吗？",
                    .spanish: "¿Puedo ver su pasaporte y boleto?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-checkin-followup1",
                        speaker: .user,
                        text: "はい、どうぞ。",
                        translations: [
                            .korean: "네, 여기요.",
                            .english: "Yes, here you go.",
                            .japanese: "はい、どうぞ。",
                            .chinese: "好的，这是。",
                            .spanish: "Sí, aquí está."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-checkin-continue1",
                                speaker: .native,
                                text: "はい、搭乗券です。ゲートC5です。",
                                translations: [
                                    .korean: "네, 여기 탑승권이에요. C5 게이트입니다.",
                                    .english: "Okay, here's your boarding pass. Gate C5.",
                                    .japanese: "はい、搭乗券です。ゲートC5です。",
                                    .chinese: "好的，这是您的登机牌。C5登机口。",
                                    .spanish: "Bien, aquí está su pase de abordar. Puerta C5."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-checkin-followup2",
                                        speaker: .user,
                                        text: "ありがとうございます。搭乗時間はいつですか？",
                                        translations: [
                                            .korean: "감사합니다. 탑승 시간이 언제인가요?",
                                            .english: "Thank you. What time is boarding?",
                                            .japanese: "ありがとうございます。搭乗時間はいつですか？",
                                            .chinese: "谢谢。什么时候登机？",
                                            .spanish: "Gracias. ¿A qué hora es el embarque?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-checkin-end1",
                                                speaker: .native,
                                                text: "搭乗は10時30分に始まります。30分前にお越しください。",
                                                translations: [
                                                    .korean: "탑승은 10시 30분에 시작합니다. 30분 전에 오세요.",
                                                    .english: "Boarding starts at 10:30. Please come 30 minutes early.",
                                                    .japanese: "搭乗は10時30分に始まります。30分前にお越しください。",
                                                    .chinese: "登机从10:30开始。请提前30分钟到达。",
                                                    .spanish: "El embarque comienza a las 10:30. Llegue 30 minutos antes."
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
    ),
    Scenario(
        id: "ja-find-gate",
        learningLanguage: .japanese,
        category: .airport,
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
        startingPhrase: "C5ゲートはどこですか？",
        startingPhraseTranslations: [
            .korean: "C5 게이트가 어디에요?",
            .english: "Where is gate C5?",
            .japanese: "C5ゲートはどこですか？",
            .chinese: "C5登机口在哪里？",
            .spanish: "¿Dónde está la puerta C5?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-gate-response1",
                speaker: .native,
                text: "まっすぐ行って、右に曲がってください。",
                translations: [
                    .korean: "쭉 가다가 오른쪽으로 도세요.",
                    .english: "Go straight, then turn right.",
                    .japanese: "まっすぐ行って、右に曲がってください。",
                    .chinese: "一直走，然后右转。",
                    .spanish: "Sigue recto, luego gira a la derecha."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-gate-followup1",
                        speaker: .user,
                        text: "歩いて何分くらいですか？",
                        translations: [
                            .korean: "걸어서 몇 분 정도 걸려요?",
                            .english: "About how many minutes walking?",
                            .japanese: "歩いて何分くらいですか？",
                            .chinese: "走路大概几分钟？",
                            .spanish: "¿Cuántos minutos caminando?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-gate-continue1",
                                speaker: .native,
                                text: "5分だけです。遠くないですよ。",
                                translations: [
                                    .korean: "5분이면 돼요. 멀지 않아요.",
                                    .english: "Just five minutes. Not far.",
                                    .japanese: "5分だけです。遠くないですよ。",
                                    .chinese: "只要五分钟。不远。",
                                    .spanish: "Solo cinco minutos. No está lejos."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-gate-followup2",
                                        speaker: .user,
                                        text: "わかりました、どうもありがとうございます！",
                                        translations: [
                                            .korean: "알겠습니다, 정말 감사합니다!",
                                            .english: "Okay, thank you very much!",
                                            .japanese: "わかりました、どうもありがとうございます！",
                                            .chinese: "好的，非常感谢！",
                                            .spanish: "Bien, ¡muchas gracias!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-gate-end1",
                                                speaker: .native,
                                                text: "どういたしまして。良い旅を！",
                                                translations: [
                                                    .korean: "천만에요. 잘 가세요!",
                                                    .english: "You're welcome. Have a good trip!",
                                                    .japanese: "どういたしまして。良い旅を！",
                                                    .chinese: "不客气。一路平安！",
                                                    .spanish: "De nada. ¡Buen viaje!"
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
    ),
    Scenario(
        id: "ja-flight-drink",
        learningLanguage: .japanese,
        category: .airport,
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
        startingPhrase: "お水をいただけますか？",
        startingPhraseTranslations: [
            .korean: "물 좀 주시겠어요?",
            .english: "Can I have some water?",
            .japanese: "お水をいただけますか？",
            .chinese: "可以给我水吗？",
            .spanish: "¿Puedo tener agua?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-drink-response1",
                speaker: .native,
                text: "もちろん。冷たいのと常温、どちらがいいですか？",
                translations: [
                    .korean: "물론이죠. 차가운 거요, 상온이요?",
                    .english: "Sure. Cold or room temperature?",
                    .japanese: "もちろん。冷たいのと常温、どちらがいいですか？",
                    .chinese: "当然。要冷的还是常温的？",
                    .spanish: "Claro. ¿Fría o al tiempo?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-drink-followup1",
                        speaker: .user,
                        text: "冷たいのでお願いします。",
                        translations: [
                            .korean: "차가운 걸로요, 감사합니다.",
                            .english: "Cold please, thank you.",
                            .japanese: "冷たいのでお願いします。",
                            .chinese: "冷的，谢谢。",
                            .spanish: "Fría por favor, gracias."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-drink-continue1",
                                speaker: .native,
                                text: "どうぞ。",
                                translations: [
                                    .korean: "여기요.",
                                    .english: "Here you go.",
                                    .japanese: "どうぞ。",
                                    .chinese: "请。",
                                    .spanish: "Aquí tiene."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-drink-followup2",
                                        speaker: .user,
                                        text: "オレンジジュースはありますか？",
                                        translations: [
                                            .korean: "오렌지 주스도 있나요?",
                                            .english: "Do you have orange juice?",
                                            .japanese: "オレンジジュースはありますか？",
                                            .chinese: "有橙汁吗？",
                                            .spanish: "¿Tiene jugo de naranja?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-drink-end1",
                                                speaker: .native,
                                                text: "はい、ございます。すぐにお持ちします。",
                                                translations: [
                                                    .korean: "네 있어요. 잠깐만 가져올게요.",
                                                    .english: "Yes, we have it. I'll get it for you.",
                                                    .japanese: "はい、ございます。すぐにお持ちします。",
                                                    .chinese: "有的。我给您拿一下。",
                                                    .spanish: "Sí, hay. Se lo traigo enseguida."
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
    ),
    Scenario(
        id: "ja-baggage-claim",
        learningLanguage: .japanese,
        category: .airport,
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
        startingPhrase: "すみません、手荷物受取所はどこですか？",
        startingPhraseTranslations: [
            .korean: "실례합니다, 수하물 찾는 곳이 어디에요?",
            .english: "Excuse me, where is baggage claim?",
            .japanese: "すみません、手荷物受取所はどこですか？",
            .chinese: "请问，行李提取处在哪里？",
            .spanish: "Disculpe, ¿dónde está la recogida de equipaje?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-baggage-response1",
                speaker: .native,
                text: "矢印を下に従ってください、1階にあります。",
                translations: [
                    .korean: "아래 화살표 따라가시면 1층에 있어요.",
                    .english: "Follow the arrows down, it's on the first floor.",
                    .japanese: "矢印を下に従ってください、1階にあります。",
                    .chinese: "跟着箭头往下走，在一楼。",
                    .spanish: "Sigue las flechas hacia abajo, está en el primer piso."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-baggage-followup1",
                        speaker: .user,
                        text: "どうもありがとうございます！",
                        translations: [
                            .korean: "정말 감사합니다!",
                            .english: "Thank you very much!",
                            .japanese: "どうもありがとうございます！",
                            .chinese: "非常感谢！",
                            .spanish: "¡Muchas gracias!"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-baggage-continue1",
                                speaker: .native,
                                text: "どういたしまして、ようこそ！",
                                translations: [
                                    .korean: "천만에요, 환영합니다!",
                                    .english: "You're welcome, welcome!",
                                    .japanese: "どういたしまして、ようこそ！",
                                    .chinese: "不客气，欢迎！",
                                    .spanish: "¡De nada, bienvenido!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-baggage-followup2",
                                        speaker: .user,
                                        text: "荷物が出てくるまでどのくらいかかりますか？",
                                        translations: [
                                            .korean: "짐이 나오는데 얼마나 걸리나요?",
                                            .english: "About how long to wait for baggage to come out?",
                                            .japanese: "荷物が出てくるまでどのくらいかかりますか？",
                                            .chinese: "等行李出来要多久？",
                                            .spanish: "¿Cuánto tiempo tarda en salir el equipaje?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-baggage-end1",
                                                speaker: .native,
                                                text: "通常15-20分くらいです。カルーセル番号を画面で確認してください。",
                                                translations: [
                                                    .korean: "보통 15-20분 정도 걸려요. 스크린에서 캐러셀 번호를 확인하세요.",
                                                    .english: "Usually around 15-20 minutes. Check the screen for your carousel number.",
                                                    .japanese: "通常15-20分くらいです。カルーセル番号を画面で確認してください。",
                                                    .chinese: "通常15-20分钟左右。请查看屏幕上您的行李转盘号。",
                                                    .spanish: "Generalmente unos 15-20 minutos. Revise la pantalla para su número de carrusel."
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
    ),
    Scenario(
        id: "ja-customs",
        learningLanguage: .japanese,
        category: .airport,
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
        startingPhrase: "申告するものはありません。",
        startingPhraseTranslations: [
            .korean: "신고할 물건이 없어요.",
            .english: "Nothing to declare.",
            .japanese: "申告するものはありません。",
            .chinese: "没有需要申报的。",
            .spanish: "Nada que declarar."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-customs-response1",
                speaker: .native,
                text: "訪問の目的は何ですか？",
                translations: [
                    .korean: "방문 목적이 무엇인가요?",
                    .english: "What is the purpose of your visit?",
                    .japanese: "訪問の目的は何ですか？",
                    .chinese: "您访问的目的是什么？",
                    .spanish: "¿Cuál es el propósito de su visita?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-customs-followup1",
                        speaker: .user,
                        text: "休暇です、観光だけです。",
                        translations: [
                            .korean: "휴가요, 관광이요.",
                            .english: "Vacation, just tourism.",
                            .japanese: "休暇です、観光だけです。",
                            .chinese: "度假，只是旅游。",
                            .spanish: "Vacaciones, solo turismo."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-customs-continue1",
                                speaker: .native,
                                text: "どのくらい滞在する予定ですか？",
                                translations: [
                                    .korean: "얼마나 머무실 예정인가요?",
                                    .english: "How long will you be staying?",
                                    .japanese: "どのくらい滞在する予定ですか？",
                                    .chinese: "您将停留多久？",
                                    .spanish: "¿Cuánto tiempo se quedará?"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-customs-followup2",
                                        speaker: .user,
                                        text: "一週間です。",
                                        translations: [
                                            .korean: "일주일이요.",
                                            .english: "One week.",
                                            .japanese: "一週間です。",
                                            .chinese: "一周。",
                                            .spanish: "Una semana."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-customs-end1",
                                                speaker: .native,
                                                text: "わかりました、良い休暇を。",
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
                    )
                ]
            )
        ]
    ),
    Scenario(
        id: "ja-money-exchange",
        learningLanguage: .japanese,
        category: .airport,
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
        startingPhrase: "両替したいです。",
        startingPhraseTranslations: [
            .korean: "환전하고 싶어요.",
            .english: "I'd like to exchange money.",
            .japanese: "両替したいです。",
            .chinese: "我想换钱。",
            .spanish: "Quiero cambiar dinero."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-exchange-response1",
                speaker: .native,
                text: "何の通貨に両替しますか？",
                translations: [
                    .korean: "어떤 통화로 바꾸시겠어요?",
                    .english: "What currency would you like to exchange?",
                    .japanese: "何の通貨に両替しますか？",
                    .chinese: "您想换什么货币？",
                    .spanish: "¿Qué moneda quiere cambiar?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-exchange-followup1",
                        speaker: .user,
                        text: "ドルをルピアに。",
                        translations: [
                            .korean: "달러를 루피아로요.",
                            .english: "Dollars to rupiah.",
                            .japanese: "ドルをルピアに。",
                            .chinese: "美元换印尼盾。",
                            .spanish: "Dólares a rupias."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-exchange-clarify1",
                                speaker: .native,
                                text: "いくら両替しますか？",
                                translations: [
                                    .korean: "얼마나 바꾸시겠어요?",
                                    .english: "How much would you like to exchange?",
                                    .japanese: "いくら両替しますか？",
                                    .chinese: "您想换多少？",
                                    .spanish: "¿Cuánto quiere cambiar?"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-exchange-continue1",
                                        speaker: .user,
                                        text: "100ドルです。",
                                        translations: [
                                            .korean: "100달러요.",
                                            .english: "One hundred dollars.",
                                            .japanese: "100ドルです。",
                                            .chinese: "一百美元。",
                                            .spanish: "Cien dólares."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-exchange-followup2",
                                                speaker: .native,
                                                text: "わかりました。今日のレートは1ドル15,000ルピアです。こちらがお金です。",
                                                translations: [
                                                    .korean: "알겠습니다. 오늘 환율은 달러당 15,000루피아입니다. 여기 돈이에요.",
                                                    .english: "Okay. Today's rate is 15,000 rupiah per dollar. Here's your money.",
                                                    .japanese: "わかりました。今日のレートは1ドル15,000ルピアです。こちらがお金です。",
                                                    .chinese: "好的。今天的汇率是每美元15,000印尼盾。这是您的钱。",
                                                    .spanish: "Bien. El tipo de cambio hoy es 15,000 rupias por dólar. Aquí está su dinero."
                                                ],
                                                responses: [
                                                    ConversationNode(
                                                        id: "ja-exchange-end1",
                                                        speaker: .user,
                                                        text: "どうもありがとうございます。",
                                                        translations: [
                                                            .korean: "정말 감사합니다.",
                                                            .english: "Thank you very much.",
                                                            .japanese: "どうもありがとうございます。",
                                                            .chinese: "非常感谢。",
                                                            .spanish: "Muchas gracias."
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
            )
        ]
    ),
    Scenario(
        id: "ja-seat-change",
        learningLanguage: .japanese,
        category: .airport,
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
        startingPhrase: "すみません、席を変えてもいいですか？",
        startingPhraseTranslations: [
            .korean: "실례합니다, 좌석을 바꿔도 될까요?",
            .english: "Excuse me, can I change seats?",
            .japanese: "すみません、席を変えてもいいですか？",
            .chinese: "请问，可以换座位吗？",
            .spanish: "Disculpe, ¿puedo cambiar de asiento?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-seat-response1",
                speaker: .native,
                text: "座席に問題がありますか？",
                translations: [
                    .korean: "좌석에 문제가 있나요?",
                    .english: "Is there a problem with your seat?",
                    .japanese: "座席に問題がありますか？",
                    .chinese: "您的座位有问题吗？",
                    .spanish: "¿Hay algún problema con su asiento?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-seat-followup1",
                        speaker: .user,
                        text: "窓側に座りたいです。",
                        translations: [
                            .korean: "창문 쪽에 앉고 싶어요.",
                            .english: "I'd like to sit by the window.",
                            .japanese: "窓側に座りたいです。",
                            .chinese: "我想坐在靠窗的位置。",
                            .spanish: "Me gustaría sentarme junto a la ventana."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-seat-continue1",
                                speaker: .native,
                                text: "わかりました、12列に空席があります。",
                                translations: [
                                    .korean: "네, 12번 줄에 빈 자리가 있어요.",
                                    .english: "Okay, there's an empty seat in row 12.",
                                    .japanese: "わかりました、12列に空席があります。",
                                    .chinese: "好的，第12排有空位。",
                                    .spanish: "Bien, hay un asiento vacío en la fila 12."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-seat-followup2",
                                        speaker: .user,
                                        text: "今移動してもいいですか？",
                                        translations: [
                                            .korean: "지금 옮겨도 될까요?",
                                            .english: "Can I move now?",
                                            .japanese: "今移動してもいいですか？",
                                            .chinese: "我现在可以换吗？",
                                            .spanish: "¿Puedo moverme ahora?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-seat-end1",
                                                speaker: .native,
                                                text: "はいもちろん、シートベルトサインが消えた後に移動してください。",
                                                translations: [
                                                    .korean: "네 물론이죠, 안전벨트 사인이 꺼진 후에 옮기세요.",
                                                    .english: "Yes of course, please move after the seatbelt sign is off.",
                                                    .japanese: "はいもちろん、シートベルトサインが消えた後に移動してください。",
                                                    .chinese: "当然可以，请在安全带指示灯熄灭后移动。",
                                                    .spanish: "Sí claro, muévase después de que se apague la señal del cinturón."
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
    ),

    // MARK: - 숙박 카테고리
    Scenario(
        id: "ja-hotel-checkin",
        learningLanguage: .japanese,
        category: .hotel,
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
        startingPhrase: "キムという名前で部屋を予約しました。",
        startingPhraseTranslations: [
            .korean: "김 이름으로 방을 예약했어요.",
            .english: "I booked a room under the name Kim.",
            .japanese: "キムという名前で部屋を予約しました。",
            .chinese: "我用Kim的名字预订了房间。",
            .spanish: "Reservé una habitación a nombre de Kim."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-hotelcheckin-response1",
                speaker: .native,
                text: "はい、パスポートを見せていただけますか？",
                translations: [
                    .korean: "네, 여권을 좀 보여주시겠어요?",
                    .english: "Okay, may I see your passport?",
                    .japanese: "はい、パスポートを見せていただけますか？",
                    .chinese: "好的，可以看一下您的护照吗？",
                    .spanish: "Bien, ¿puedo ver su pasaporte?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-hotelcheckin-followup1",
                        speaker: .user,
                        text: "はい、どうぞ。",
                        translations: [
                            .korean: "네, 여기요.",
                            .english: "Yes, here it is.",
                            .japanese: "はい、どうぞ。",
                            .chinese: "好的，在这里。",
                            .spanish: "Sí, aquí está."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-hotelcheckin-continue1",
                                speaker: .native,
                                text: "ありがとうございます。305号室の鍵です。朝食は朝7時からです。",
                                translations: [
                                    .korean: "감사합니다. 여기 305호 키입니다. 조식은 아침 7시부터예요.",
                                    .english: "Thank you. Here's the key to room 305. Breakfast from 7 AM.",
                                    .japanese: "ありがとうございます。305号室の鍵です。朝食は朝7時からです。",
                                    .chinese: "谢谢。这是305号房间的钥匙。早餐从早上7点开始。",
                                    .spanish: "Gracias. Aquí está la llave de la habitación 305. Desayuno desde las 7 AM."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-hotelcheckin-followup2",
                                        speaker: .user,
                                        text: "ありがとうございます。朝食ルームはどこですか？",
                                        translations: [
                                            .korean: "감사합니다. 조식당이 어디에 있나요?",
                                            .english: "Thank you. Where is the breakfast room?",
                                            .japanese: "ありがとうございます。朝食ルームはどこですか？",
                                            .chinese: "谢谢。早餐室在哪里？",
                                            .spanish: "Gracias. ¿Dónde está el comedor del desayuno?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-hotelcheckin-end1",
                                                speaker: .native,
                                                text: "1階、ロビーの隣です。ごゆっくり。",
                                                translations: [
                                                    .korean: "1층 로비 옆에 있습니다. 편히 쉬세요.",
                                                    .english: "On the first floor, next to the lobby. Enjoy your stay.",
                                                    .japanese: "1階、ロビーの隣です。ごゆっくり。",
                                                    .chinese: "在一楼，大厅旁边。祝您住得愉快。",
                                                    .spanish: "En el primer piso, al lado del vestíbulo. Que disfrute su estancia."
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
    ),
    Scenario(
        id: "ja-guesthouse-checkin",
        learningLanguage: .japanese,
        category: .hotel,
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
        startingPhrase: "こんにちは、昨夜部屋を予約しました。",
        startingPhraseTranslations: [
            .korean: "안녕하세요, 어젯밤에 방 예약했어요.",
            .english: "Hi, I booked a room last night.",
            .japanese: "こんにちは、昨夜部屋を予約しました。",
            .chinese: "你好，我昨晚预订了房间。",
            .spanish: "Hola, reservé una habitación anoche."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-guestcheckin-response1",
                speaker: .native,
                text: "あ、そう？誰の名前で？",
                translations: [
                    .korean: "아, 그래요? 누구 이름으로요?",
                    .english: "Oh yeah? Under what name?",
                    .japanese: "あ、そう？誰の名前で？",
                    .chinese: "哦，是吗？用谁的名字？",
                    .spanish: "¿Ah sí? ¿A nombre de quién?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-guestcheckin-followup1",
                        speaker: .user,
                        text: "キムです。2人部屋です。",
                        translations: [
                            .korean: "김이요. 2인실이요.",
                            .english: "Kim. A room for two people.",
                            .japanese: "キムです。2人部屋です。",
                            .chinese: "Kim。双人间。",
                            .spanish: "Kim. Una habitación para dos personas."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-guestcheckin-continue1",
                                speaker: .native,
                                text: "オッケー、ありますよ。7号室、2階です。鍵です。",
                                translations: [
                                    .korean: "네, 있어요. 7호실, 2층이에요. 여기 키요.",
                                    .english: "Okay, got it. Room number 7, second floor. Here's the key.",
                                    .japanese: "オッケー、ありますよ。7号室、2階です。鍵です。",
                                    .chinese: "好的，有的。7号房间，二楼。这是钥匙。",
                                    .spanish: "Ok, aquí está. Habitación número 7, segundo piso. Aquí está la llave."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-guestcheckin-followup2",
                                        speaker: .user,
                                        text: "ありがとうございます。無料WiFiはありますか？",
                                        translations: [
                                            .korean: "감사합니다. 무료 와이파이 있나요?",
                                            .english: "Thank you. Is there free WiFi?",
                                            .japanese: "ありがとうございます。無料WiFiはありますか？",
                                            .chinese: "谢谢。有免费WiFi吗？",
                                            .spanish: "Gracias. ¿Hay WiFi gratis?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-guestcheckin-end1",
                                                speaker: .native,
                                                text: "はい、あります。パスワードは部屋にあります。ごゆっくり！",
                                                translations: [
                                                    .korean: "네 있어요. 비밀번호는 방에 있어요. 편히 쉬세요!",
                                                    .english: "Yes, there is. The password is in the room. Enjoy your stay!",
                                                    .japanese: "はい、あります。パスワードは部屋にあります。ごゆっくり！",
                                                    .chinese: "有的。密码在房间里。祝您住得愉快！",
                                                    .spanish: "Sí, hay. La contraseña está en la habitación. ¡Que descanses!"
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
    ),
    Scenario(
        id: "ja-room-service",
        learningLanguage: .japanese,
        category: .hotel,
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
        startingPhrase: "部屋に食事を注文したいです。",
        startingPhraseTranslations: [
            .korean: "객실로 음식을 주문하고 싶어요.",
            .english: "I'd like to order food to my room.",
            .japanese: "部屋に食事を注文したいです。",
            .chinese: "我想订餐到房间。",
            .spanish: "Me gustaría pedir comida a mi habitación."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-roomservice-response1",
                speaker: .native,
                text: "もちろんです、お部屋番号は？",
                translations: [
                    .korean: "물론이죠, 객실 번호가 어떻게 되시나요?",
                    .english: "Of course, what's your room number?",
                    .japanese: "もちろんです、お部屋番号は？",
                    .chinese: "当然，您的房间号是多少？",
                    .spanish: "Por supuesto, ¿cuál es su número de habitación?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-roomservice-followup1",
                        speaker: .user,
                        text: "305号です。チャーハンとオレンジジュースをお願いします。",
                        translations: [
                            .korean: "305호요. 볶음밥이랑 오렌지 주스 주세요.",
                            .english: "305. I'd like fried rice and orange juice.",
                            .japanese: "305号です。チャーハンとオレンジジュースをお願いします。",
                            .chinese: "305号。我要炒饭和橙汁。",
                            .spanish: "305. Quiero arroz frito y jugo de naranja."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-roomservice-continue1",
                                speaker: .native,
                                text: "わかりました、20分以内にお届けします。",
                                translations: [
                                    .korean: "네, 20분 안에 가져다 드리겠습니다.",
                                    .english: "Okay, it will be delivered in 20 minutes.",
                                    .japanese: "わかりました、20分以内にお届けします。",
                                    .chinese: "好的，20分钟内送到。",
                                    .spanish: "Bien, se entregará en 20 minutos."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-roomservice-followup2",
                                        speaker: .user,
                                        text: "ありがとうございます。合計はいくらですか？",
                                        translations: [
                                            .korean: "감사합니다. 총 얼마예요?",
                                            .english: "Thank you. What's the total?",
                                            .japanese: "ありがとうございます。合計はいくらですか？",
                                            .chinese: "谢谢。总共多少钱？",
                                            .spanish: "Gracias. ¿Cuál es el total?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-roomservice-end1",
                                                speaker: .native,
                                                text: "75,000ルピアです。チェックアウト時に支払えます。",
                                                translations: [
                                                    .korean: "75,000루피아입니다. 체크아웃 때 내셔도 돼요.",
                                                    .english: "75 thousand rupiah. You can pay later at check out.",
                                                    .japanese: "75,000ルピアです。チェックアウト時に支払えます。",
                                                    .chinese: "75,000印尼盾。可以在退房时支付。",
                                                    .spanish: "75 mil rupias. Puede pagar después al hacer el check out."
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
    ),
    Scenario(
        id: "ja-breakfast-time",
        learningLanguage: .japanese,
        category: .hotel,
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
        startingPhrase: "朝食は何時ですか？",
        startingPhraseTranslations: [
            .korean: "아침식사가 몇 시에요?",
            .english: "What time is breakfast?",
            .japanese: "朝食は何時ですか？",
            .chinese: "早餐几点？",
            .spanish: "¿A qué hora es el desayuno?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-breakfast-response1",
                speaker: .native,
                text: "朝6時から10時までです。",
                translations: [
                    .korean: "아침 6시부터 10시까지예요.",
                    .english: "From 6 AM to 10 AM.",
                    .japanese: "朝6時から10時までです。",
                    .chinese: "早上6点到10点。",
                    .spanish: "De 6 a 10 de la mañana."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-breakfast-followup1",
                        speaker: .user,
                        text: "どこですか？",
                        translations: [
                            .korean: "어디서 먹어요?",
                            .english: "Where is it?",
                            .japanese: "どこですか？",
                            .chinese: "在哪里？",
                            .spanish: "¿Dónde es?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-breakfast-continue1",
                                speaker: .native,
                                text: "1階です、ロビーの隣です。",
                                translations: [
                                    .korean: "1층이요, 로비 옆이에요.",
                                    .english: "On the first floor, next to the lobby.",
                                    .japanese: "1階です、ロビーの隣です。",
                                    .chinese: "在一楼，大厅旁边。",
                                    .spanish: "En el primer piso, al lado del lobby."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-breakfast-followup2",
                                        speaker: .user,
                                        text: "予約が必要ですか？",
                                        translations: [
                                            .korean: "예약이 필요한가요?",
                                            .english: "Do I need a reservation?",
                                            .japanese: "予約が必要ですか？",
                                            .chinese: "需要预约吗？",
                                            .spanish: "¿Necesito reservar?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-breakfast-end1",
                                                speaker: .native,
                                                text: "必要ありません、直接来てください。",
                                                translations: [
                                                    .korean: "필요없어요, 그냥 오시면 됩니다.",
                                                    .english: "No need, just come directly.",
                                                    .japanese: "必要ありません、直接来てください。",
                                                    .chinese: "不需要，直接来就可以。",
                                                    .spanish: "No es necesario, venga directamente."
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
    ),
    Scenario(
        id: "ja-hotel-checkout",
        learningLanguage: .japanese,
        category: .hotel,
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
        startingPhrase: "チェックアウトしたいです。",
        startingPhraseTranslations: [
            .korean: "체크아웃하고 싶어요.",
            .english: "I'd like to check out.",
            .japanese: "チェックアウトしたいです。",
            .chinese: "我想退房。",
            .spanish: "Quiero hacer el check-out."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-checkout-response1",
                speaker: .native,
                text: "はい、お部屋番号は？",
                translations: [
                    .korean: "네, 객실 번호가 어떻게 되시나요?",
                    .english: "Okay, what room number?",
                    .japanese: "はい、お部屋番号は？",
                    .chinese: "好的，房间号是多少？",
                    .spanish: "Bien, ¿qué número de habitación?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-checkout-followup1",
                        speaker: .user,
                        text: "305号です。追加料金はありますか？",
                        translations: [
                            .korean: "305호요. 추가 요금이 있나요?",
                            .english: "305. Are there any additional charges?",
                            .japanese: "305号です。追加料金はありますか？",
                            .chinese: "305号。有额外费用吗？",
                            .spanish: "305. ¿Hay cargos adicionales?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-checkout-continue1",
                                speaker: .native,
                                text: "ありません。予約通りです。",
                                translations: [
                                    .korean: "없어요. 예약한 금액과 동일합니다.",
                                    .english: "No. Total matches your reservation.",
                                    .japanese: "ありません。予約通りです。",
                                    .chinese: "没有。总额与预订一致。",
                                    .spanish: "No. El total coincide con su reserva."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-checkout-followup2",
                                        speaker: .user,
                                        text: "クレジットカードで支払えますか？",
                                        translations: [
                                            .korean: "신용카드로 결제할 수 있나요?",
                                            .english: "Can I pay with credit card?",
                                            .japanese: "クレジットカードで支払えますか？",
                                            .chinese: "可以用信用卡支付吗？",
                                            .spanish: "¿Puedo pagar con tarjeta de crédito?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-checkout-end1",
                                                speaker: .native,
                                                text: "はいもちろんできます。ご宿泊ありがとうございました。",
                                                translations: [
                                                    .korean: "네 물론 가능합니다. 투숙해주셔서 감사합니다.",
                                                    .english: "Yes, of course. Thank you for staying.",
                                                    .japanese: "はいもちろんできます。ご宿泊ありがとうございました。",
                                                    .chinese: "当然可以。感谢您的入住。",
                                                    .spanish: "Sí, claro que sí. Gracias por hospedarse."
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
    ),
    Scenario(
        id: "ja-luggage-storage",
        learningLanguage: .japanese,
        category: .hotel,
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
        startingPhrase: "ここにスーツケースを預けられますか？",
        startingPhraseTranslations: [
            .korean: "여기 캐리어 맡겨도 돼요?",
            .english: "Can I store my suitcase here?",
            .japanese: "ここにスーツケースを預けられますか？",
            .chinese: "可以把行李箱存在这里吗？",
            .spanish: "¿Puedo guardar mi maleta aquí?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-storage-response1",
                speaker: .native,
                text: "もちろんです。何時までですか？",
                translations: [
                    .korean: "물론이죠. 몇 시까지요?",
                    .english: "Sure. Until what time?",
                    .japanese: "もちろんです。何時までですか？",
                    .chinese: "当然可以。到几点？",
                    .spanish: "Claro. ¿Hasta qué hora?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-storage-followup1",
                        speaker: .user,
                        text: "午後5時です。いいですか？",
                        translations: [
                            .korean: "오후 5시요. 괜찮죠?",
                            .english: "5 PM. Is that okay?",
                            .japanese: "午後5時です。いいですか？",
                            .chinese: "下午5点。可以吗？",
                            .spanish: "5 de la tarde. ¿Está bien?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-storage-continue1",
                                speaker: .native,
                                text: "問題ありません。預かり証です。",
                                translations: [
                                    .korean: "문제없어요. 여기 보관증이에요.",
                                    .english: "No problem. Here's your claim ticket.",
                                    .japanese: "問題ありません。預かり証です。",
                                    .chinese: "没问题。这是您的寄存单。",
                                    .spanish: "Sin problema. Aquí está su comprobante."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-storage-followup2",
                                        speaker: .user,
                                        text: "保管料金はかかりますか？",
                                        translations: [
                                            .korean: "보관비가 있나요?",
                                            .english: "Is there a storage fee?",
                                            .japanese: "保管料金はかかりますか？",
                                            .chinese: "有寄存费吗？",
                                            .spanish: "¿Hay tarifa de almacenamiento?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-storage-end1",
                                                speaker: .native,
                                                text: "ホテルのお客様は無料です。この番号を大切に保管してください。",
                                                translations: [
                                                    .korean: "호텔 투숙객은 무료예요. 이 번호 잘 보관하세요.",
                                                    .english: "Free for hotel guests. Keep this number safe.",
                                                    .japanese: "ホテルのお客様は無料です。この番号を大切に保管してください。",
                                                    .chinese: "酒店客人免费。请妥善保管这个号码。",
                                                    .spanish: "Gratis para huéspedes del hotel. Guarde bien este número."
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
    ),
    Scenario(
        id: "ja-towel-request",
        learningLanguage: .japanese,
        category: .hotel,
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
        startingPhrase: "タオルを追加でもらえますか？",
        startingPhraseTranslations: [
            .korean: "타월 추가로 주실 수 있어요?",
            .english: "Can I get extra towels?",
            .japanese: "タオルを追加でもらえますか？",
            .chinese: "可以再要一些毛巾吗？",
            .spanish: "¿Puedo tener toallas extra?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-towel-response1",
                speaker: .native,
                text: "もちろん。何枚必要ですか？",
                translations: [
                    .korean: "물론이죠. 몇 개 필요하세요?",
                    .english: "Sure. How many do you need?",
                    .japanese: "もちろん。何枚必要ですか？",
                    .chinese: "当然。您需要几条？",
                    .spanish: "Claro. ¿Cuántas necesita?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-towel-followup1",
                        speaker: .user,
                        text: "2枚だけです。ありがとう。",
                        translations: [
                            .korean: "두 개만요. 감사합니다.",
                            .english: "Just two towels. Thank you.",
                            .japanese: "2枚だけです。ありがとう。",
                            .chinese: "只要两条。谢谢。",
                            .spanish: "Solo dos toallas. Gracias."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-towel-continue1",
                                speaker: .native,
                                text: "はい、すぐにお部屋にお持ちします。",
                                translations: [
                                    .korean: "네, 곧 객실로 가져다 드리겠습니다.",
                                    .english: "Okay, I'll bring them to your room shortly.",
                                    .japanese: "はい、すぐにお部屋にお持ちします。",
                                    .chinese: "好的，我马上送到您房间。",
                                    .spanish: "Bien, las llevaré a su habitación enseguida."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-towel-followup2",
                                        speaker: .user,
                                        text: "私の部屋番号は305です。どうもありがとうございます。",
                                        translations: [
                                            .korean: "제 방은 305호예요. 정말 감사합니다.",
                                            .english: "My room number is 305. Thank you very much.",
                                            .japanese: "私の部屋番号は305です。どうもありがとうございます。",
                                            .chinese: "我的房间号是305。非常感谢。",
                                            .spanish: "Mi habitación es la 305. Muchas gracias."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-towel-end1",
                                                speaker: .native,
                                                text: "どういたしまして。10分以内にお送りします。",
                                                translations: [
                                                    .korean: "천만에요. 10분 안에 보내드리겠습니다.",
                                                    .english: "You're welcome. I'll send them in 10 minutes.",
                                                    .japanese: "どういたしまして。10分以内にお送りします。",
                                                    .chinese: "不客气。我10分钟内送到。",
                                                    .spanish: "De nada. Las enviaré en 10 minutos."
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
    ),
    Scenario(
        id: "ja-wifi-password",
        learningLanguage: .japanese,
        category: .hotel,
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
        startingPhrase: "WiFiのパスワードは何ですか？",
        startingPhraseTranslations: [
            .korean: "와이파이 비밀번호가 뭐예요?",
            .english: "What's the WiFi password?",
            .japanese: "WiFiのパスワードは何ですか？",
            .chinese: "WiFi密码是什么？",
            .spanish: "¿Cuál es la contraseña del WiFi?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-wifi-response1",
                speaker: .native,
                text: "ちょっと待って、書きますね。これです。",
                translations: [
                    .korean: "잠깐만요, 써드릴게요. 여기요.",
                    .english: "One moment, I'll write it down. Here it is.",
                    .japanese: "ちょっと待って、書きますね。これです。",
                    .chinese: "稍等，我写下来。这是。",
                    .spanish: "Un momento, lo anoto. Aquí está."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-wifi-followup1",
                        speaker: .user,
                        text: "ありがとう！",
                        translations: [
                            .korean: "고마워요!",
                            .english: "Thanks!",
                            .japanese: "ありがとう！",
                            .chinese: "谢谢！",
                            .spanish: "¡Gracias!"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-wifi-continue1",
                                speaker: .native,
                                text: "どういたしまして。問題があれば言ってくださいね。",
                                translations: [
                                    .korean: "천만에요. 문제 있으면 말씀하세요.",
                                    .english: "You're welcome. If there's any problem, just let me know.",
                                    .japanese: "どういたしまして。問題があれば言ってくださいね。",
                                    .chinese: "不客气。有问题就说。",
                                    .spanish: "De nada. Si hay algún problema, avísame."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-wifi-followup2",
                                        speaker: .user,
                                        text: "WiFiは速いですか？",
                                        translations: [
                                            .korean: "와이파이 빠른가요?",
                                            .english: "Is the WiFi fast?",
                                            .japanese: "WiFiは速いですか？",
                                            .chinese: "WiFi快吗？",
                                            .spanish: "¿El WiFi es rápido?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-wifi-end1",
                                                speaker: .native,
                                                text: "はい、かなり速いです。ストリーミングもできます。",
                                                translations: [
                                                    .korean: "네, 꽤 빨라요. 스트리밍도 할 수 있어요.",
                                                    .english: "Yes, quite fast. You can stream too.",
                                                    .japanese: "はい、かなり速いです。ストリーミングもできます。",
                                                    .chinese: "是的，相当快。也可以流媒体。",
                                                    .spanish: "Sí, bastante rápido. También puedes ver streaming."
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
    ),

    // MARK: - 식당/카페 카테고리 (추가)
    Scenario(
        id: "ja-table-reservation",
        learningLanguage: .japanese,
        category: .restaurant,
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
        startingPhrase: "今夜のテーブルを予約したいです。",
        startingPhraseTranslations: [
            .korean: "오늘 저녁 테이블 예약하고 싶어요.",
            .english: "I'd like to book a table for tonight.",
            .japanese: "今夜のテーブルを予約したいです。",
            .chinese: "我想预订今晚的桌位。",
            .spanish: "Quiero reservar una mesa para esta noche."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-reservation-response1",
                speaker: .native,
                text: "何名様ですか？",
                translations: [
                    .korean: "몇 분이세요?",
                    .english: "For how many people?",
                    .japanese: "何名様ですか？",
                    .chinese: "几位？",
                    .spanish: "¿Para cuántas personas?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-reservation-followup1",
                        speaker: .user,
                        text: "4名です。午後7時です。",
                        translations: [
                            .korean: "4명이요. 저녁 7시요.",
                            .english: "Four people. 7 PM.",
                            .japanese: "4名です。午後7時です。",
                            .chinese: "四位。晚上7点。",
                            .spanish: "Cuatro personas. 7 PM."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-reservation-continue1",
                                speaker: .native,
                                text: "はい、お名前をお伺いできますか？",
                                translations: [
                                    .korean: "네, 성함이 어떻게 되세요?",
                                    .english: "Okay, may I have your name?",
                                    .japanese: "はい、お名前をお伺いできますか？",
                                    .chinese: "好的，请问您贵姓？",
                                    .spanish: "Bien, ¿puedo saber su nombre?"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-reservation-followup2",
                                        speaker: .user,
                                        text: "キムです。電話番号も必要ですか？",
                                        translations: [
                                            .korean: "김이요. 전화번호도 필요한가요?",
                                            .english: "Kim. Do you need a phone number too?",
                                            .japanese: "キムです。電話番号も必要ですか？",
                                            .chinese: "Kim。还需要电话号码吗？",
                                            .spanish: "Kim. ¿Necesita número de teléfono también?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-reservation-end1",
                                                speaker: .native,
                                                text: "はい、電話番号をお願いします。キム様で午後7時のご予約ですね。",
                                                translations: [
                                                    .korean: "네, 전화번호 알려주세요. 김님 이름으로 저녁 7시 예약이네요.",
                                                    .english: "Yes, please provide your phone number. Reservation under Kim at 7 PM.",
                                                    .japanese: "はい、電話番号をお願いします。キム様で午後7時のご予約ですね。",
                                                    .chinese: "是的，请提供您的电话号码。Kim的名字晚上7点预订。",
                                                    .spanish: "Sí, proporcione su número de teléfono. Reserva a nombre de Kim a las 7 PM."
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
    ),
    Scenario(
        id: "ja-menu-recommendation",
        learningLanguage: .japanese,
        category: .restaurant,
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
        startingPhrase: "おいしい料理のおすすめはありますか？",
        startingPhraseTranslations: [
            .korean: "맛있는 음식 추천해주실 수 있어요?",
            .english: "Any good food recommendations?",
            .japanese: "おいしい料理のおすすめはありますか？",
            .chinese: "有什么好吃的推荐吗？",
            .spanish: "¿Alguna recomendación de comida buena?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-recommend-response1",
                speaker: .native,
                text: "うちのレンダンは有名ですよ。試してみますか？",
                translations: [
                    .korean: "저희 렌당이 유명해요. 드셔보시겠어요?",
                    .english: "Our rendang is famous. Want to try?",
                    .japanese: "うちのレンダンは有名ですよ。試してみますか？",
                    .chinese: "我们的仁当很有名。要试试吗？",
                    .spanish: "Nuestro rendang es famoso. ¿Quiere probarlo?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-recommend-followup1",
                        speaker: .user,
                        text: "いいですね！辛いですか？",
                        translations: [
                            .korean: "좋아요! 그거 매워요?",
                            .english: "Sure! Is it spicy?",
                            .japanese: "いいですね！辛いですか？",
                            .chinese: "好啊！辣吗？",
                            .spanish: "¡Claro! ¿Es picante?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-recommend-continue1",
                                speaker: .native,
                                text: "少し辛いですが、とてもおいしいですよ！",
                                translations: [
                                    .korean: "조금 매운데, 정말 맛있어요!",
                                    .english: "A little spicy, but really delicious!",
                                    .japanese: "少し辛いですが、とてもおいしいですよ！",
                                    .chinese: "有点辣，但是很好吃！",
                                    .spanish: "Un poco picante, ¡pero muy rico!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-recommend-followup2",
                                        speaker: .user,
                                        text: "わかりました、レンダンを一つお願いします。白ご飯で。",
                                        translations: [
                                            .korean: "좋아요, 렌당 하나 주세요. 흰 쌀밥이요.",
                                            .english: "Okay, I'll order one rendang. With white rice.",
                                            .japanese: "わかりました、レンダンを一つお願いします。白ご飯で。",
                                            .chinese: "好的，我点一份仁当。配白饭。",
                                            .spanish: "Bien, pediré un rendang. Con arroz blanco."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-recommend-end1",
                                                speaker: .native,
                                                text: "承知しました！約15分お待ちください。",
                                                translations: [
                                                    .korean: "알겠습니다! 15분 정도 기다려주세요.",
                                                    .english: "Got it! Please wait, about 15 minutes.",
                                                    .japanese: "承知しました！約15分お待ちください。",
                                                    .chinese: "好的！请稍等，大约15分钟。",
                                                    .spanish: "¡Entendido! Espere, unos 15 minutos."
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
    ),
    Scenario(
        id: "ja-allergy-inquiry",
        learningLanguage: .japanese,
        category: .restaurant,
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
        startingPhrase: "これにピーナッツは入っていますか？",
        startingPhraseTranslations: [
            .korean: "이거 땅콩 들어가요?",
            .english: "Does this contain peanuts?",
            .japanese: "これにピーナッツは入っていますか？",
            .chinese: "这个含花生吗？",
            .spanish: "¿Esto contiene cacahuetes?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-allergy-response1",
                speaker: .native,
                text: "確認しますね。ピーナッツアレルギーですか？",
                translations: [
                    .korean: "확인해볼게요. 땅콩 알레르기가 있으세요?",
                    .english: "Let me check. Are you allergic to peanuts?",
                    .japanese: "確認しますね。ピーナッツアレルギーですか？",
                    .chinese: "我查一下。您对花生过敏吗？",
                    .spanish: "Déjame revisar. ¿Es alérgico a los cacahuetes?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-allergy-followup1",
                        speaker: .user,
                        text: "はい、重度のアレルギーです。",
                        translations: [
                            .korean: "네, 심한 알레르기예요.",
                            .english: "Yes, severe allergy.",
                            .japanese: "はい、重度のアレルギーです。",
                            .chinese: "是的，严重过敏。",
                            .spanish: "Sí, alergia severa."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-allergy-continue1",
                                speaker: .native,
                                text: "わかりました、安全なメニューを探しますね。",
                                translations: [
                                    .korean: "네, 안전한 메뉴를 찾아드릴게요.",
                                    .english: "Okay, I'll find a safe menu for you.",
                                    .japanese: "わかりました、安全なメニューを探しますね。",
                                    .chinese: "好的，我给您找安全的菜单。",
                                    .spanish: "Bien, le buscaré un menú seguro."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-allergy-followup2",
                                        speaker: .user,
                                        text: "どうもありがとうございます。とても助かります。",
                                        translations: [
                                            .korean: "정말 감사합니다. 큰 도움이 돼요.",
                                            .english: "Thank you very much. Very helpful.",
                                            .japanese: "どうもありがとうございます。とても助かります。",
                                            .chinese: "非常感谢。很有帮助。",
                                            .spanish: "Muchas gracias. Muy útil."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-allergy-end1",
                                                speaker: .native,
                                                text: "どういたしまして。ピーナッツ不使用のメニューがいくつかあります。こちらがリストです。",
                                                translations: [
                                                    .korean: "천만에요. 땅콩이 없는 메뉴가 몇 가지 있어요. 여기 목록이에요.",
                                                    .english: "You're welcome. We have several peanut-free menus. Here's the list.",
                                                    .japanese: "どういたしまして。ピーナッツ不使用のメニューがいくつかあります。こちらがリストです。",
                                                    .chinese: "不客气。我们有几道不含花生的菜。这是清单。",
                                                    .spanish: "De nada. Tenemos varios menús sin cacahuetes. Aquí está la lista."
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
    ),
    Scenario(
        id: "ja-ask-bill",
        learningLanguage: .japanese,
        category: .restaurant,
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
        startingPhrase: "お会計お願いします。",
        startingPhraseTranslations: [
            .korean: "계산서 주세요.",
            .english: "Can I have the bill please?",
            .japanese: "お会計お願いします。",
            .chinese: "请给我账单。",
            .spanish: "La cuenta por favor."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-bill-response1",
                speaker: .native,
                text: "はい、少々お待ちください。",
                translations: [
                    .korean: "네, 잠시만요.",
                    .english: "Okay, just a moment.",
                    .japanese: "はい、少々お待ちください。",
                    .chinese: "好的，稍等。",
                    .spanish: "Bien, un momento."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-bill-followup1",
                        speaker: .user,
                        text: "クレジットカードで払えますか？",
                        translations: [
                            .korean: "신용카드 돼요?",
                            .english: "Can I pay with credit card?",
                            .japanese: "クレジットカードで払えますか？",
                            .chinese: "可以用信用卡吗？",
                            .spanish: "¿Puedo pagar con tarjeta de crédito?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-bill-continue1",
                                speaker: .native,
                                text: "大丈夫です。こちらがカード決済機です。",
                                translations: [
                                    .korean: "물론이죠. 여기 카드 단말기요.",
                                    .english: "Yes. Here's the card machine.",
                                    .japanese: "大丈夫です。こちらがカード決済機です。",
                                    .chinese: "可以。这是刷卡机。",
                                    .spanish: "Sí. Aquí está el datáfono."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-bill-followup2",
                                        speaker: .user,
                                        text: "合計はいくらですか？",
                                        translations: [
                                            .korean: "총 얼마예요?",
                                            .english: "What's the total?",
                                            .japanese: "合計はいくらですか？",
                                            .chinese: "总共多少钱？",
                                            .spanish: "¿Cuál es el total?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-bill-end1",
                                                speaker: .native,
                                                text: "15万ルピアです。お食事ありがとうございました。",
                                                translations: [
                                                    .korean: "15만 루피아입니다. 와주셔서 감사합니다.",
                                                    .english: "150 thousand rupiah. Thank you for dining here.",
                                                    .japanese: "15万ルピアです。お食事ありがとうございました。",
                                                    .chinese: "15万印尼盾。感谢您的光临。",
                                                    .spanish: "150 mil rupias. Gracias por comer aquí."
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
    ),
    Scenario(
        id: "ja-takeout-order",
        learningLanguage: .japanese,
        category: .restaurant,
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
        startingPhrase: "持ち帰りできますか？",
        startingPhraseTranslations: [
            .korean: "포장 되나요?",
            .english: "Can I get it to go?",
            .japanese: "持ち帰りできますか？",
            .chinese: "可以打包吗？",
            .spanish: "¿Puedo pedir para llevar?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-takeout-response1",
                speaker: .native,
                text: "もちろんです。何を注文しますか？",
                translations: [
                    .korean: "물론이죠. 뭐 주문하시겠어요?",
                    .english: "Of course. What would you like to order?",
                    .japanese: "もちろんです。何を注文しますか？",
                    .chinese: "当然可以。您想点什么？",
                    .spanish: "Claro que sí. ¿Qué quiere pedir?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-takeout-followup1",
                        speaker: .user,
                        text: "チャーハン一つと甘いアイスティーです。",
                        translations: [
                            .korean: "볶음밥 하나랑 아이스티요.",
                            .english: "One fried rice and an iced sweet tea.",
                            .japanese: "チャーハン一つと甘いアイスティーです。",
                            .chinese: "一份炒饭和冰甜茶。",
                            .spanish: "Un arroz frito y un té helado dulce."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-takeout-continue1",
                                speaker: .native,
                                text: "了解！15分ほどお待ちください。",
                                translations: [
                                    .korean: "알겠습니다! 15분 정도 기다려주세요.",
                                    .english: "Got it! Wait about 15 minutes.",
                                    .japanese: "了解！15分ほどお待ちください。",
                                    .chinese: "好的！等大约15分钟。",
                                    .spanish: "¡Listo! Espere unos 15 minutos."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-takeout-followup2",
                                        speaker: .user,
                                        text: "わかりました、合計はいくらですか？",
                                        translations: [
                                            .korean: "알겠습니다, 총 얼마예요?",
                                            .english: "Okay, what's the total?",
                                            .japanese: "わかりました、合計はいくらですか？",
                                            .chinese: "好的，总共多少钱？",
                                            .spanish: "Vale, ¿cuál es el total?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-takeout-end1",
                                                speaker: .native,
                                                text: "4万ルピアです。ありがとうございます！",
                                                translations: [
                                                    .korean: "4만 루피아입니다. 감사합니다!",
                                                    .english: "40 thousand rupiah. Thank you!",
                                                    .japanese: "4万ルピアです。ありがとうございます！",
                                                    .chinese: "4万印尼盾。谢谢！",
                                                    .spanish: "40 mil rupias. ¡Gracias!"
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
    ),
    Scenario(
        id: "ja-coffee-order",
        learningLanguage: .japanese,
        category: .restaurant,
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
        startingPhrase: "ホットカフェラテ一つです。",
        startingPhraseTranslations: [
            .korean: "따뜻한 카페라떼 하나요.",
            .english: "One hot coffee with milk.",
            .japanese: "ホットカフェラテ一つです。",
            .chinese: "一杯热牛奶咖啡。",
            .spanish: "Un café con leche caliente."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-coffee-response1",
                speaker: .native,
                text: "サイズは？ミディアムかラージ？",
                translations: [
                    .korean: "사이즈 어떻게 하시겠어요? 미디엄? 라지?",
                    .english: "What size? Medium or large?",
                    .japanese: "サイズは？ミディアムかラージ？",
                    .chinese: "什么尺寸？中杯还是大杯？",
                    .spanish: "¿Qué tamaño? ¿Mediano o grande?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-coffee-followup1",
                        speaker: .user,
                        text: "ミディアムで。砂糖は少しだけ。",
                        translations: [
                            .korean: "미디엄이요. 설탕 조금만요.",
                            .english: "Medium. Just a little sugar.",
                            .japanese: "ミディアムで。砂糖は少しだけ。",
                            .chinese: "中杯就好。糖少一点。",
                            .spanish: "Mediano. Solo un poco de azúcar."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-coffee-continue1",
                                speaker: .native,
                                text: "わかりました、合計25,000ルピアです。",
                                translations: [
                                    .korean: "알겠습니다, 총 25,000루피아예요.",
                                    .english: "Okay, that's 25 thousand total.",
                                    .japanese: "わかりました、合計25,000ルピアです。",
                                    .chinese: "好的，总共2万5千。",
                                    .spanish: "Ok, son 25 mil en total."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-coffee-followup2",
                                        speaker: .user,
                                        text: "現金で払えますか？こちらがお金です。",
                                        translations: [
                                            .korean: "현금 돼요? 여기요.",
                                            .english: "Can I pay cash? Here's the money.",
                                            .japanese: "現金で払えますか？こちらがお金です。",
                                            .chinese: "可以付现金吗？这是钱。",
                                            .spanish: "¿Puedo pagar en efectivo? Aquí está el dinero."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-coffee-end1",
                                                speaker: .native,
                                                text: "はい、できます。ありがとうございます。コーヒーすぐ準備できます。",
                                                translations: [
                                                    .korean: "네 가능합니다. 감사합니다. 커피 곧 준비됩니다.",
                                                    .english: "Yes. Thank you. Your coffee will be ready soon.",
                                                    .japanese: "はい、できます。ありがとうございます。コーヒーすぐ準備できます。",
                                                    .chinese: "可以。谢谢。咖啡马上就好。",
                                                    .spanish: "Sí. Gracias. Su café estará listo pronto."
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
    ),
    Scenario(
        id: "ja-water-request",
        learningLanguage: .japanese,
        category: .restaurant,
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
        startingPhrase: "お水をいただけますか？",
        startingPhraseTranslations: [
            .korean: "물 좀 주시겠어요?",
            .english: "Can I have some water?",
            .japanese: "お水をいただけますか？",
            .chinese: "可以给我水吗？",
            .spanish: "¿Puedo tener agua?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-water-response1",
                speaker: .native,
                text: "もちろん、少々お待ちください。",
                translations: [
                    .korean: "물론이죠, 잠시만요.",
                    .english: "Sure, one moment.",
                    .japanese: "もちろん、少々お待ちください。",
                    .chinese: "当然，稍等。",
                    .spanish: "Claro, un momento."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-water-followup1",
                        speaker: .user,
                        text: "どうもありがとう！",
                        translations: [
                            .korean: "정말 감사합니다!",
                            .english: "Thank you so much!",
                            .japanese: "どうもありがとう！",
                            .chinese: "非常感谢！",
                            .spanish: "¡Muchas gracias!"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-water-continue1",
                                speaker: .native,
                                text: "どういたしまして。どうぞ。",
                                translations: [
                                    .korean: "천만에요. 여기요.",
                                    .english: "You're welcome. Here you go.",
                                    .japanese: "どういたしまして。どうぞ。",
                                    .chinese: "不客气。请。",
                                    .spanish: "De nada. Aquí tiene."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-water-followup2",
                                        speaker: .user,
                                        text: "氷はありますか？",
                                        translations: [
                                            .korean: "얼음 있나요?",
                                            .english: "Do you have ice?",
                                            .japanese: "氷はありますか？",
                                            .chinese: "有冰块吗？",
                                            .spanish: "¿Tiene hielo?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-water-end1",
                                                speaker: .native,
                                                text: "あります。お持ちしますね。",
                                                translations: [
                                                    .korean: "네 있어요. 가져다 드릴게요.",
                                                    .english: "Yes. I'll get it for you.",
                                                    .japanese: "あります。お持ちしますね。",
                                                    .chinese: "有的。我给您拿。",
                                                    .spanish: "Sí. Se lo traigo."
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
    ),
    Scenario(
        id: "ja-vegetarian-menu",
        learningLanguage: .japanese,
        category: .restaurant,
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
        startingPhrase: "ベジタリアンメニューはありますか？",
        startingPhraseTranslations: [
            .korean: "채식 메뉴 있나요?",
            .english: "Do you have vegetarian menu?",
            .japanese: "ベジタリアンメニューはありますか？",
            .chinese: "有素食菜单吗？",
            .spanish: "¿Tienen menú vegetariano?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-vegetarian-response1",
                speaker: .native,
                text: "あります。肉が全く入っていないものがいいですか？",
                translations: [
                    .korean: "있어요. 고기가 전혀 안 들어간 걸로 드릴까요?",
                    .english: "Yes. Would you like something with no meat at all?",
                    .japanese: "あります。肉が全く入っていないものがいいですか？",
                    .chinese: "有的。您要完全不含肉的吗？",
                    .spanish: "Sí. ¿Quiere algo sin nada de carne?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-vegetarian-followup1",
                        speaker: .user,
                        text: "はい、ベジタリアンです。",
                        translations: [
                            .korean: "네, 저 채식주의자예요.",
                            .english: "Yes, I'm vegetarian.",
                            .japanese: "はい、ベジタリアンです。",
                            .chinese: "是的，我吃素。",
                            .spanish: "Sí, soy vegetariano."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-vegetarian-continue1",
                                speaker: .native,
                                text: "わかりました、ガドガドかチャプチャイをおすすめします。",
                                translations: [
                                    .korean: "네, 가도가도나 잡채 추천드려요.",
                                    .english: "Okay, I recommend gado-gado or cap cay.",
                                    .japanese: "わかりました、ガドガドかチャプチャイをおすすめします。",
                                    .chinese: "好的，我推荐加多加多或炒杂菜。",
                                    .spanish: "Bien, recomiendo gado-gado o cap cay."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-vegetarian-followup2",
                                        speaker: .user,
                                        text: "ガドガドが美味しそうです。それを注文します。",
                                        translations: [
                                            .korean: "가도가도 맛있어 보여요. 그걸로 주세요.",
                                            .english: "Gado-gado sounds good. I'll order that.",
                                            .japanese: "ガドガドが美味しそうです。それを注文します。",
                                            .chinese: "加多加多听起来不错。我点那个。",
                                            .spanish: "Gado-gado suena bien. Pediré eso."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-vegetarian-end1",
                                                speaker: .native,
                                                text: "良い選択です！今作りますね。",
                                                translations: [
                                                    .korean: "좋은 선택이에요! 지금 만들어 드릴게요.",
                                                    .english: "Great choice! I'll make it now.",
                                                    .japanese: "良い選択です！今作りますね。",
                                                    .chinese: "很好的选择！我现在就做。",
                                                    .spanish: "¡Buena elección! Lo haré ahora."
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
    ),

    // MARK: - 교통 카테고리
    Scenario(
        id: "ja-taxi-call",
        learningLanguage: .japanese,
        category: .transportation,
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
        startingPhrase: "タクシーを呼んでいただけますか？",
        startingPhraseTranslations: [
            .korean: "택시 좀 불러주시겠어요?",
            .english: "Can you call a taxi for me?",
            .japanese: "タクシーを呼んでいただけますか？",
            .chinese: "可以帮我叫辆出租车吗？",
            .spanish: "¿Puede llamar un taxi?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-taxi-response1",
                speaker: .native,
                text: "もちろん。どちらまで？",
                translations: [
                    .korean: "물론이죠. 어디 가세요?",
                    .english: "Sure. Where to?",
                    .japanese: "もちろん。どちらまで？",
                    .chinese: "当然。去哪里？",
                    .spanish: "Claro. ¿A dónde?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-taxi-followup1",
                        speaker: .user,
                        text: "空港まで。",
                        translations: [
                            .korean: "공항이요.",
                            .english: "To the airport.",
                            .japanese: "空港まで。",
                            .chinese: "去机场。",
                            .spanish: "Al aeropuerto."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-taxi-continue1",
                                speaker: .native,
                                text: "わかりました、タクシーは5分で到着します。",
                                translations: [
                                    .korean: "네, 택시가 5분 안에 올 거예요.",
                                    .english: "Okay, the taxi will arrive in 5 minutes.",
                                    .japanese: "わかりました、タクシーは5分で到着します。",
                                    .chinese: "好的，出租车5分钟内到达。",
                                    .spanish: "Bien, el taxi llegará en 5 minutos."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-taxi-followup2",
                                        speaker: .user,
                                        text: "どうもありがとうございます！",
                                        translations: [
                                            .korean: "정말 감사합니다!",
                                            .english: "Thank you very much!",
                                            .japanese: "どうもありがとうございます！",
                                            .chinese: "非常感谢！",
                                            .spanish: "¡Muchas gracias!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-taxi-end1",
                                                speaker: .native,
                                                text: "どういたしまして。前で待ってください。",
                                                translations: [
                                                    .korean: "천만에요. 앞에서 기다리세요.",
                                                    .english: "You're welcome. Wait in front.",
                                                    .japanese: "どういたしまして。前で待ってください。",
                                                    .chinese: "不客气。在前面等着。",
                                                    .spanish: "De nada. Espere al frente."
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
    ),
    Scenario(
        id: "ja-tell-destination",
        learningLanguage: .japanese,
        category: .transportation,
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
        startingPhrase: "グランドインドネシアホテルまでお願いします。",
        startingPhraseTranslations: [
            .korean: "그랜드 인도네시아 호텔로 데려다 주세요.",
            .english: "Please take me to Grand Indonesia hotel.",
            .japanese: "グランドインドネシアホテルまでお願いします。",
            .chinese: "请送我到大印度尼西亚酒店。",
            .spanish: "Por favor lléveme al hotel Grand Indonesia."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-destination-response1",
                speaker: .native,
                text: "わかりました。高速道路か一般道路、どちらがいいですか？",
                translations: [
                    .korean: "네. 고속도로로 갈까요, 일반 도로로 갈까요?",
                    .english: "Okay. Via toll road or regular road?",
                    .japanese: "わかりました。高速道路か一般道路、どちらがいいですか？",
                    .chinese: "好的。走高速还是普通路？",
                    .spanish: "Bien. ¿Por autopista de peaje o carretera normal?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-destination-followup1",
                        speaker: .user,
                        text: "早い方でお願いします。",
                        translations: [
                            .korean: "더 빠른 걸로 가주세요.",
                            .english: "Whichever is faster.",
                            .japanese: "早い方でお願いします。",
                            .chinese: "走快一点的就好。",
                            .spanish: "El que sea más rápido."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-destination-continue1",
                                speaker: .native,
                                text: "了解、高速道路で行きます。",
                                translations: [
                                    .korean: "알겠습니다, 고속도로로 가겠습니다.",
                                    .english: "Got it, we'll take the toll road.",
                                    .japanese: "了解、高速道路で行きます。",
                                    .chinese: "明白了，走高速。",
                                    .spanish: "Entendido, tomaremos la autopista."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-destination-followup2",
                                        speaker: .user,
                                        text: "だいたいどのくらいかかりますか？",
                                        translations: [
                                            .korean: "대략 얼마나 걸려요?",
                                            .english: "About how long?",
                                            .japanese: "だいたいどのくらいかかりますか？",
                                            .chinese: "大概要多久？",
                                            .spanish: "¿Cuánto tiempo aproximadamente?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-destination-end1",
                                                speaker: .native,
                                                text: "スムーズなら30分で到着します。",
                                                translations: [
                                                    .korean: "막히지 않으면 30분이면 도착해요.",
                                                    .english: "If traffic is clear, 30 minutes to arrive.",
                                                    .japanese: "スムーズなら30分で到着します。",
                                                    .chinese: "如果顺利30分钟就到。",
                                                    .spanish: "Si no hay tráfico, 30 minutos para llegar."
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
    ),
    Scenario(
        id: "ja-ask-fare",
        learningLanguage: .japanese,
        category: .transportation,
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
        startingPhrase: "そこまでいくらですか？",
        startingPhraseTranslations: [
            .korean: "거기까지 얼마예요?",
            .english: "How much to get there?",
            .japanese: "そこまでいくらですか？",
            .chinese: "到那里多少钱？",
            .spanish: "¿Cuánto cuesta llegar allí?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-fare-response1",
                speaker: .native,
                text: "約8万ルピアですが、渋滞次第です。",
                translations: [
                    .korean: "대략 8만 루피아인데, 막히느냐에 따라 다릅니다.",
                    .english: "About 80 thousand, depends on traffic.",
                    .japanese: "約8万ルピアですが、渋滞次第です。",
                    .chinese: "大约8万，要看堵不堵车。",
                    .spanish: "Unos 80 mil, depende del tráfico."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-fare-followup1",
                        speaker: .user,
                        text: "わかりました、メーターでお願いします。",
                        translations: [
                            .korean: "네, 미터기 켜주세요.",
                            .english: "Okay, use the meter please?",
                            .japanese: "わかりました、メーターでお願いします。",
                            .chinese: "好的，用计价器吧？",
                            .spanish: "Ok, ¿usa el taxímetro?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-fare-continue1",
                                speaker: .native,
                                text: "はい、もう付けました。",
                                translations: [
                                    .korean: "네, 이미 켰어요.",
                                    .english: "Yes, I already turned it on.",
                                    .japanese: "はい、もう付けました。",
                                    .chinese: "是的，已经打开了。",
                                    .spanish: "Sí, ya lo encendí."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-fare-followup2",
                                        speaker: .user,
                                        text: "ありがとうございます。出発しましょう。",
                                        translations: [
                                            .korean: "감사합니다. 출발하죠.",
                                            .english: "Thank you. Let's go.",
                                            .japanese: "ありがとうございます。出発しましょう。",
                                            .chinese: "谢谢。我们走吧。",
                                            .spanish: "Gracias. Vamos."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-fare-end1",
                                                speaker: .native,
                                                text: "了解です、シートベルトをお忘れなく。",
                                                translations: [
                                                    .korean: "알겠습니다, 안전벨트 메세요.",
                                                    .english: "Sure, don't forget to wear your seatbelt.",
                                                    .japanese: "了解です、シートベルトをお忘れなく。",
                                                    .chinese: "好的，别忘了系安全带。",
                                                    .spanish: "Claro, no olvide ponerse el cinturón."
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
    ),
    Scenario(
        id: "ja-metro-route",
        learningLanguage: .japanese,
        category: .transportation,
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
        startingPhrase: "モナスまでどの電車に乗ればいいですか？",
        startingPhraseTranslations: [
            .korean: "모나스까지 어떤 전철 타야 해요?",
            .english: "Which train to take to Monas?",
            .japanese: "モナスまでどの電車に乗ればいいですか？",
            .chinese: "去莫纳斯坐哪趟地铁？",
            .spanish: "¿Qué tren tomar para Monas?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-metro-response1",
                speaker: .native,
                text: "赤いラインに乗って、ガンビル駅で降りてください。",
                translations: [
                    .korean: "빨간 노선 타고 감비르역에서 내리세요.",
                    .english: "Take the red line, get off at Gambir station.",
                    .japanese: "赤いラインに乗って、ガンビル駅で降りてください。",
                    .chinese: "坐红线，在甘比尔站下车。",
                    .spanish: "Toma la línea roja, baja en la estación Gambir."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-metro-followup1",
                        speaker: .user,
                        text: "駅から歩いて遠いですか？",
                        translations: [
                            .korean: "역에서 걸어서 멀어요?",
                            .english: "Is it far to walk from the station?",
                            .japanese: "駅から歩いて遠いですか？",
                            .chinese: "从车站走路远吗？",
                            .spanish: "¿Está lejos caminando desde la estación?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-metro-continue1",
                                speaker: .native,
                                text: "いいえ、歩いて10分だけです。",
                                translations: [
                                    .korean: "아니요, 걸어서 10분밖에 안 걸려요.",
                                    .english: "No, only a 10-minute walk.",
                                    .japanese: "いいえ、歩いて10分だけです。",
                                    .chinese: "不远，走路只要10分钟。",
                                    .spanish: "No, solo 10 minutos caminando."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-metro-followup2",
                                        speaker: .user,
                                        text: "わかりました、情報ありがとうございます！",
                                        translations: [
                                            .korean: "알겠어요, 정보 감사합니다!",
                                            .english: "Okay, thanks for the info!",
                                            .japanese: "わかりました、情報ありがとうございます！",
                                            .chinese: "好的，谢谢你的信息！",
                                            .spanish: "Vale, ¡gracias por la información!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-metro-end1",
                                                speaker: .native,
                                                text: "どういたしまして。良い旅を！",
                                                translations: [
                                                    .korean: "천만에요. 즐거운 여행 되세요!",
                                                    .english: "You're welcome. Have a nice trip!",
                                                    .japanese: "どういたしまして。良い旅を！",
                                                    .chinese: "不客气。祝您玩得开心！",
                                                    .spanish: "De nada. ¡Que tenga un buen viaje!"
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
    ),
    Scenario(
        id: "ja-bus-stop",
        learningLanguage: .japanese,
        category: .transportation,
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
        startingPhrase: "モールに行くバス停はどこですか？",
        startingPhraseTranslations: [
            .korean: "쇼핑몰 가는 버스 정류장이 어디예요?",
            .english: "Where's the bus stop to the mall?",
            .japanese: "モールに行くバス停はどこですか？",
            .chinese: "去商场的公交站在哪？",
            .spanish: "¿Dónde está la parada del autobús al centro comercial?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-bus-response1",
                speaker: .native,
                text: "道の向かい側です、12番バスに乗ってください。",
                translations: [
                    .korean: "길 건너편이요, 12번 버스 타세요.",
                    .english: "Across the street, take bus number 12.",
                    .japanese: "道の向かい側です、12番バスに乗ってください。",
                    .chinese: "在马路对面，坐12路公交。",
                    .spanish: "Al otro lado de la calle, toma el autobús número 12."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-bus-followup1",
                        speaker: .user,
                        text: "ありがとう！",
                        translations: [
                            .korean: "감사합니다!",
                            .english: "Thanks!",
                            .japanese: "ありがとう！",
                            .chinese: "谢谢！",
                            .spanish: "¡Gracias!"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-bus-continue1",
                                speaker: .native,
                                text: "どういたしまして、気をつけて！",
                                translations: [
                                    .korean: "천만에요, 조심하세요!",
                                    .english: "You're welcome, be careful!",
                                    .japanese: "どういたしまして、気をつけて！",
                                    .chinese: "不客气，小心点！",
                                    .spanish: "De nada, ¡ten cuidado!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-bus-followup2",
                                        speaker: .user,
                                        text: "だいたいどのくらいかかりますか？",
                                        translations: [
                                            .korean: "대략 얼마나 걸려요?",
                                            .english: "About how long is the journey?",
                                            .japanese: "だいたいどのくらいかかりますか？",
                                            .chinese: "路程大概要多久？",
                                            .spanish: "¿Cuánto tiempo dura el viaje aproximadamente?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-bus-end1",
                                                speaker: .native,
                                                text: "渋滞がなければ20分くらいです。",
                                                translations: [
                                                    .korean: "막히지 않으면 20분 정도요.",
                                                    .english: "About 20 minutes if there's no traffic.",
                                                    .japanese: "渋滞がなければ20分くらいです。",
                                                    .chinese: "如果不堵车大概20分钟。",
                                                    .spanish: "Unos 20 minutos si no hay tráfico."
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
    ),
    Scenario(
        id: "ja-buy-ticket",
        learningLanguage: .japanese,
        category: .transportation,
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
        startingPhrase: "バンドンまでのチケットを買いたいです。",
        startingPhraseTranslations: [
            .korean: "반둥까지 가는 표를 사고 싶어요.",
            .english: "I'd like to buy a ticket to Bandung.",
            .japanese: "バンドンまでのチケットを買いたいです。",
            .chinese: "我想买到万隆的票。",
            .spanish: "Quiero comprar un boleto a Bandung."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-ticket-response1",
                speaker: .native,
                text: "出発時刻は何時ですか？",
                translations: [
                    .korean: "몇 시 출발이세요?",
                    .english: "What time departure?",
                    .japanese: "出発時刻は何時ですか？",
                    .chinese: "几点出发？",
                    .spanish: "¿A qué hora sale?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-ticket-followup1",
                        speaker: .user,
                        text: "朝です、9時頃です。",
                        translations: [
                            .korean: "아침이요, 9시쯤이요.",
                            .english: "Morning, around 9 o'clock.",
                            .japanese: "朝です、9時頃です。",
                            .chinese: "早上的，9点左右。",
                            .spanish: "De mañana, alrededor de las 9."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-ticket-continue1",
                                speaker: .native,
                                text: "9時15分の列車があります。合計15万ルピアです。",
                                translations: [
                                    .korean: "9시 15분 기차 있어요. 총 15만 루피아예요.",
                                    .english: "There's a train at 9:15. Total 150 thousand.",
                                    .japanese: "9時15分の列車があります。合計15万ルピアです。",
                                    .chinese: "有9点15分的火车。总共15万。",
                                    .spanish: "Hay un tren a las 9:15. Total 150 mil."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-ticket-followup2",
                                        speaker: .user,
                                        text: "わかりました、それにします。現金で払えますか？",
                                        translations: [
                                            .korean: "알겠습니다, 그걸로 할게요. 현금 되나요?",
                                            .english: "Okay, I'll take that one. Can I pay cash?",
                                            .japanese: "わかりました、それにします。現金で払えますか？",
                                            .chinese: "好的，我要那个。可以付现金吗？",
                                            .spanish: "Bien, tomaré ese. ¿Puedo pagar en efectivo?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-ticket-end1",
                                                speaker: .native,
                                                text: "できます。こちらがチケットです、3番ホームから出発します。",
                                                translations: [
                                                    .korean: "됩니다. 여기 표예요, 3번 플랫폼에서 출발해요.",
                                                    .english: "Yes. Here's your ticket, departure from platform 3.",
                                                    .japanese: "できます。こちらがチケットです、3番ホームから出発します。",
                                                    .chinese: "可以。这是您的票，从3号站台发车。",
                                                    .spanish: "Sí. Aquí está su boleto, sale del andén 3."
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
    ),
    Scenario(
        id: "ja-ask-transfer",
        learningLanguage: .japanese,
        category: .transportation,
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
        startingPhrase: "乗り換えは必要ですか？",
        startingPhraseTranslations: [
            .korean: "환승해야 하나요?",
            .english: "Do I need to change trains?",
            .japanese: "乗り換えは必要ですか？",
            .chinese: "需要换车吗？",
            .spanish: "¿Necesito cambiar de tren?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-transfer-response1",
                speaker: .native,
                text: "はい、ドゥクアタス駅で乗り換えてください。",
                translations: [
                    .korean: "네, 두쿠 아타스역에서 환승하세요.",
                    .english: "Yes, transfer at Dukuh Atas station.",
                    .japanese: "はい、ドゥクアタス駅で乗り換えてください。",
                    .chinese: "是的，在杜库阿塔斯站换乘。",
                    .spanish: "Sí, transborda en la estación Dukuh Atas."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-transfer-followup1",
                        speaker: .user,
                        text: "見つけるのは難しいですか？",
                        translations: [
                            .korean: "찾기 어려워요?",
                            .english: "Is it hard to find?",
                            .japanese: "見つけるのは難しいですか？",
                            .chinese: "难找吗？",
                            .spanish: "¿Es difícil de encontrar?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-transfer-continue1",
                                speaker: .native,
                                text: "いいえ、標識に従うだけです。簡単ですよ。",
                                translations: [
                                    .korean: "아니요, 표지판만 따라가면 돼요. 쉬워요.",
                                    .english: "No, just follow the signs. It's easy.",
                                    .japanese: "いいえ、標識に従うだけです。簡単ですよ。",
                                    .chinese: "不难，跟着指示牌就行。很简单。",
                                    .spanish: "No, solo sigue las señales. Es fácil."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-transfer-followup2",
                                        speaker: .user,
                                        text: "わかりました、ありがとうございます！",
                                        translations: [
                                            .korean: "알겠습니다, 감사합니다!",
                                            .english: "Okay, thank you!",
                                            .japanese: "わかりました、ありがとうございます！",
                                            .chinese: "好的，谢谢！",
                                            .spanish: "Vale, ¡gracias!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-transfer-end1",
                                                speaker: .native,
                                                text: "どういたしまして。良い旅を！",
                                                translations: [
                                                    .korean: "천만에요. 무사히 도착하세요!",
                                                    .english: "You're welcome. Safe travels!",
                                                    .japanese: "どういたしまして。良い旅を！",
                                                    .chinese: "不客气。一路平安！",
                                                    .spanish: "De nada. ¡Buen viaje!"
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
    ),
    Scenario(
        id: "ja-ojek",
        learningLanguage: .japanese,
        category: .transportation,
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
        startingPhrase: "兄ちゃん、駅までいくら？",
        startingPhraseTranslations: [
            .korean: "형, 역까지 얼마예요?",
            .english: "Bro, how much to the station?",
            .japanese: "兄ちゃん、駅までいくら？",
            .chinese: "大哥，到车站多少钱？",
            .spanish: "Hermano, ¿cuánto a la estación?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-ojek-response1",
                speaker: .native,
                text: "1万5千だけ、近いですよ。",
                translations: [
                    .korean: "1만 5천만 주세요, 가까워요.",
                    .english: "Just 15 thousand, it's close.",
                    .japanese: "1万5千だけ、近いですよ。",
                    .chinese: "只要1万5千，很近的。",
                    .spanish: "Solo 15 mil, está cerca."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-ojek-followup1",
                        speaker: .user,
                        text: "オッケー、行こう！",
                        translations: [
                            .korean: "좋아요, 가요!",
                            .english: "Okay, let's go!",
                            .japanese: "オッケー、行こう！",
                            .chinese: "好的，走吧！",
                            .spanish: "¡Ok, vamos!"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-ojek-continue1",
                                speaker: .native,
                                text: "了解、楽に座ってください。",
                                translations: [
                                    .korean: "알겠습니다, 편하게 앉으세요.",
                                    .english: "Got it, sit comfortably.",
                                    .japanese: "了解、楽に座ってください。",
                                    .chinese: "好的，坐稳了。",
                                    .spanish: "Listo, siéntate cómodo."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-ojek-followup2",
                                        speaker: .user,
                                        text: "予備のヘルメットはありますか？",
                                        translations: [
                                            .korean: "여분 헬멧 있나요?",
                                            .english: "Do you have a spare helmet?",
                                            .japanese: "予備のヘルメットはありますか？",
                                            .chinese: "有备用头盔吗？",
                                            .spanish: "¿Tienes casco de repuesto?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-ojek-end1",
                                                speaker: .native,
                                                text: "ありますよ、これです。安全のためかぶってください。",
                                                translations: [
                                                    .korean: "있어요, 여기요. 안전을 위해 쓰세요.",
                                                    .english: "Yes, here. Wear it to be safe.",
                                                    .japanese: "ありますよ、これです。安全のためかぶってください。",
                                                    .chinese: "有的，这个。戴上更安全。",
                                                    .spanish: "Sí, aquí. Úsalo para estar seguro."
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
    ),

    // MARK: - 쇼핑 카테고리
    Scenario(
        id: "ja-ask-price",
        learningLanguage: .japanese,
        category: .shopping,
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
        startingPhrase: "これはいくらですか？",
        startingPhraseTranslations: [
            .korean: "이거 얼마예요?",
            .english: "How much is this?",
            .japanese: "これはいくらですか？",
            .chinese: "这个多少钱？",
            .spanish: "¿Cuánto cuesta esto?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-price-response1",
                speaker: .native,
                text: "25万ルピアです。買いますか？",
                translations: [
                    .korean: "25만 루피아예요. 사실 거예요?",
                    .english: "250 thousand. Want to buy?",
                    .japanese: "25万ルピアです。買いますか？",
                    .chinese: "25万。要买吗？",
                    .spanish: "250 mil. ¿Quiere comprar?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-price-followup1",
                        speaker: .user,
                        text: "値引きできますか？",
                        translations: [
                            .korean: "깎아주실 수 있어요?",
                            .english: "Can you give a discount?",
                            .japanese: "値引きできますか？",
                            .chinese: "可以便宜点吗？",
                            .spanish: "¿Puede hacer descuento?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-price-continue1",
                                speaker: .native,
                                text: "2つ買えば、合計45万ルピアにします。",
                                translations: [
                                    .korean: "2개 사시면 총 45만 루피아에 드릴게요.",
                                    .english: "Buy two, I'll give you 450 thousand total.",
                                    .japanese: "2つ買えば、合計45万ルピアにします。",
                                    .chinese: "买两个，我给你总共45万。",
                                    .spanish: "Compre dos, le doy 450 mil en total."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-price-followup2",
                                        speaker: .user,
                                        text: "オッケー、決まり！2つください。",
                                        translations: [
                                            .korean: "좋아요, 그럼요! 2개 살게요.",
                                            .english: "Okay, deal! I'll take two.",
                                            .japanese: "オッケー、決まり！2つください。",
                                            .chinese: "好的，成交！我要两个。",
                                            .spanish: "¡Vale, trato hecho! Tomo dos."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-price-end1",
                                                speaker: .native,
                                                text: "ありがとうございます。包装しますね。",
                                                translations: [
                                                    .korean: "감사합니다. 포장해드릴게요.",
                                                    .english: "Thank you. Let me wrap them for you.",
                                                    .japanese: "ありがとうございます。包装しますね。",
                                                    .chinese: "谢谢。我先给您包起来。",
                                                    .spanish: "Gracias. Déjeme empacarlos."
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
    ),
    Scenario(
        id: "ja-ask-discount",
        learningLanguage: .japanese,
        category: .shopping,
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
        startingPhrase: "割引はありますか？",
        startingPhraseTranslations: [
            .korean: "할인 있어요?",
            .english: "Is there a discount?",
            .japanese: "割引はありますか？",
            .chinese: "有折扣吗？",
            .spanish: "¿Hay descuento?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-discount-response1",
                speaker: .native,
                text: "今20%プロモーション中です。",
                translations: [
                    .korean: "지금 20% 프로모션 중이에요.",
                    .english: "There's a 20% promotion now.",
                    .japanese: "今20%プロモーション中です。",
                    .chinese: "现在有20%的促销。",
                    .spanish: "Ahora hay una promoción del 20%."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-discount-followup1",
                        speaker: .user,
                        text: "わあ、いいですね！買います。",
                        translations: [
                            .korean: "와, 좋아요! 살게요.",
                            .english: "Wow, great! I'll buy it.",
                            .japanese: "わあ、いいですね！買います。",
                            .chinese: "哇，太好了！我买了。",
                            .spanish: "¡Wow, genial! Lo compro."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-discount-continue1",
                                speaker: .native,
                                text: "ありがとうございます。現金かカードですか？",
                                translations: [
                                    .korean: "감사합니다. 현금으로 하시겠어요, 카드로 하시겠어요?",
                                    .english: "Thank you. Cash or card?",
                                    .japanese: "ありがとうございます。現金かカードですか？",
                                    .chinese: "谢谢。现金还是卡？",
                                    .spanish: "Gracias. ¿Efectivo o tarjeta?"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-discount-followup2",
                                        speaker: .user,
                                        text: "カードで。Visaは使えますか？",
                                        translations: [
                                            .korean: "카드로요. 비자 되나요?",
                                            .english: "By card. Do you accept Visa?",
                                            .japanese: "カードで。Visaは使えますか？",
                                            .chinese: "用卡。可以用Visa吗？",
                                            .spanish: "Con tarjeta. ¿Aceptan Visa?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-discount-end1",
                                                speaker: .native,
                                                text: "使えます。こちらが機械です、タップしてください。",
                                                translations: [
                                                    .korean: "됩니다. 여기 기계예요, 터치하세요.",
                                                    .english: "Yes. Here's the machine, please tap.",
                                                    .japanese: "使えます。こちらが機械です、タップしてください。",
                                                    .chinese: "可以。这是机器，请刷卡。",
                                                    .spanish: "Sí. Aquí está la máquina, toque por favor."
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
    ),
    Scenario(
        id: "ja-ask-size",
        learningLanguage: .japanese,
        category: .shopping,
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
        startingPhrase: "Mサイズはありますか？",
        startingPhraseTranslations: [
            .korean: "M 사이즈 있어요?",
            .english: "Do you have size M?",
            .japanese: "Mサイズはありますか？",
            .chinese: "有M码吗？",
            .spanish: "¿Tienen talla M?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-size-response1",
                speaker: .native,
                text: "あります。何色がいいですか？",
                translations: [
                    .korean: "있어요. 무슨 색으로 할래요?",
                    .english: "Yes. What color?",
                    .japanese: "あります。何色がいいですか？",
                    .chinese: "有的。要什么颜色？",
                    .spanish: "Sí. ¿Qué color?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-size-followup1",
                        speaker: .user,
                        text: "黒はありますか？",
                        translations: [
                            .korean: "검은색 있어요?",
                            .english: "Do you have black?",
                            .japanese: "黒はありますか？",
                            .chinese: "有黑色的吗？",
                            .spanish: "¿Tienen negro?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-size-continue1",
                                speaker: .native,
                                text: "あります、これです。",
                                translations: [
                                    .korean: "있어요, 여기요.",
                                    .english: "Yes, here you go.",
                                    .japanese: "あります、これです。",
                                    .chinese: "有，这是。",
                                    .spanish: "Sí, aquí está."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-size-followup2",
                                        speaker: .user,
                                        text: "試着してもいいですか？",
                                        translations: [
                                            .korean: "입어봐도 될까요?",
                                            .english: "Can I try it on first?",
                                            .japanese: "試着してもいいですか？",
                                            .chinese: "可以先试穿吗？",
                                            .spanish: "¿Puedo probármelo primero?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-size-end1",
                                                speaker: .native,
                                                text: "もちろん、試着室はあちらです。",
                                                translations: [
                                                    .korean: "물론이죠, 탈의실은 저쪽이에요.",
                                                    .english: "Of course, fitting room is over there.",
                                                    .japanese: "もちろん、試着室はあちらです。",
                                                    .chinese: "当然，试衣间在那边。",
                                                    .spanish: "Claro, el probador está por allá."
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
    ),
    Scenario(
        id: "ja-try-on",
        learningLanguage: .japanese,
        category: .shopping,
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
        startingPhrase: "試着してもいいですか？",
        startingPhraseTranslations: [
            .korean: "입어봐도 돼요?",
            .english: "Can I try it on?",
            .japanese: "試着してもいいですか？",
            .chinese: "可以试穿吗？",
            .spanish: "¿Puedo probármelo?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-tryon-response1",
                speaker: .native,
                text: "もちろんです、試着室はあちらです。",
                translations: [
                    .korean: "물론이죠, 탈의실은 저기예요.",
                    .english: "Of course, the fitting room is over there.",
                    .japanese: "もちろんです、試着室はあちらです。",
                    .chinese: "当然，试衣间在那边。",
                    .spanish: "Por supuesto, el probador está allí."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-tryon-followup1",
                        speaker: .user,
                        text: "ありがとうございます。",
                        translations: [
                            .korean: "감사합니다.",
                            .english: "Thank you.",
                            .japanese: "ありがとうございます。",
                            .chinese: "谢谢。",
                            .spanish: "Gracias."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-tryon-continue1",
                                speaker: .native,
                                text: "どういたしまして、助けが必要なら言ってくださいね.",
                                translations: [
                                    .korean: "천만에요, 도움 필요하시면 말씀하세요.",
                                    .english: "You're welcome, let me know if you need help.",
                                    .japanese: "どういたしまして、助けが必要なら言ってくださいね.",
                                    .chinese: "不客气，需要帮助就说。",
                                    .spanish: "De nada, avísame si necesitas ayuda."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-tryon-followup2",
                                        speaker: .user,
                                        text: "ぴったりです！これを買います。",
                                        translations: [
                                            .korean: "딱 맞아요! 이거 살게요.",
                                            .english: "Perfect fit! I'll buy this.",
                                            .japanese: "ぴったりです！これを買います。",
                                            .chinese: "正合适！我买这个。",
                                            .spanish: "¡Perfecto! Compro esto."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-tryon-end1",
                                                speaker: .native,
                                                text: "ありがとうございます。レジで準備しますね。",
                                                translations: [
                                                    .korean: "감사합니다. 계산대에 준비해둘게요.",
                                                    .english: "Thank you. I'll prepare it at the counter.",
                                                    .japanese: "ありがとうございます。レジで準備しますね。",
                                                    .chinese: "谢谢。我在收银台准备好。",
                                                    .spanish: "Gracias. Lo preparo en la caja."
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
    ),
    Scenario(
        id: "ja-ask-refund",
        learningLanguage: .japanese,
        category: .shopping,
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
        startingPhrase: "この商品を返品したいです。",
        startingPhraseTranslations: [
            .korean: "이거 반품하고 싶어요.",
            .english: "I'd like to return this item.",
            .japanese: "この商品を返品したいです。",
            .chinese: "我想退货。",
            .spanish: "Quiero devolver este artículo."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-refund-response1",
                speaker: .native,
                text: "返品理由をお聞きしてもよろしいですか？",
                translations: [
                    .korean: "왜 반품하시는지 여쭤봐도 될까요?",
                    .english: "May I know why you want to return it?",
                    .japanese: "返品理由をお聞きしてもよろしいですか？",
                    .chinese: "可以问一下为什么要退货吗？",
                    .spanish: "¿Puedo saber por qué quiere devolverlo?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-refund-followup1",
                        speaker: .user,
                        text: "サイズが小さすぎます。",
                        translations: [
                            .korean: "사이즈가 작아요.",
                            .english: "The size is too small.",
                            .japanese: "サイズが小さすぎます。",
                            .chinese: "尺码太小了。",
                            .spanish: "La talla es muy pequeña."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-refund-continue1",
                                speaker: .native,
                                text: "わかりました、レシートはありますか？大きいサイズに交換できます。",
                                translations: [
                                    .korean: "네, 영수증 있으세요? 더 큰 사이즈로 교환 가능해요.",
                                    .english: "Okay, do you have the receipt? We can exchange for a larger size.",
                                    .japanese: "わかりました、レシートはありますか？大きいサイズに交換できます。",
                                    .chinese: "好的，有收据吗？可以换大一号的。",
                                    .spanish: "Bien, ¿tiene el recibo? Podemos cambiar por una talla más grande."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-refund-followup2",
                                        speaker: .user,
                                        text: "これがレシートです。Lサイズはありますか？",
                                        translations: [
                                            .korean: "여기 영수증이요. L 사이즈 있나요?",
                                            .english: "Here's the receipt. Do you have size L?",
                                            .japanese: "これがレシートです。Lサイズはありますか？",
                                            .chinese: "这是收据。有L码吗？",
                                            .spanish: "Aquí está el recibo. ¿Tienen talla L?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-refund-end1",
                                                speaker: .native,
                                                text: "あります。Lサイズを取ってきますね。",
                                                translations: [
                                                    .korean: "있어요. L 사이즈 가져올게요.",
                                                    .english: "Yes. Let me get size L for you.",
                                                    .japanese: "あります。Lサイズを取ってきますね。",
                                                    .chinese: "有的。我给您拿L码的。",
                                                    .spanish: "Sí. Le traigo la talla L."
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
    ),
    Scenario(
        id: "ja-gift-wrap",
        learningLanguage: .japanese,
        category: .shopping,
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
        startingPhrase: "ギフトラッピングできますか？",
        startingPhraseTranslations: [
            .korean: "선물 포장 가능해요?",
            .english: "Can this be gift wrapped?",
            .japanese: "ギフトラッピングできますか？",
            .chinese: "可以包装成礼物吗？",
            .spanish: "¿Pueden envolverlo para regalo?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-giftwrap-response1",
                speaker: .native,
                text: "できます。どの包装紙にしますか？",
                translations: [
                    .korean: "가능해요. 어떤 포장지로 할까요?",
                    .english: "Yes. Which wrapping paper would you like?",
                    .japanese: "できます。どの包装紙にしますか？",
                    .chinese: "可以。您想选哪种包装纸？",
                    .spanish: "Sí. ¿Qué papel de regalo prefiere?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-giftwrap-followup1",
                        speaker: .user,
                        text: "あの青いのがいいですね。",
                        translations: [
                            .korean: "저 파란색 예쁘네요.",
                            .english: "That blue one is nice.",
                            .japanese: "あの青いのがいいですね。",
                            .chinese: "那个蓝色的不错。",
                            .spanish: "Ese azul está bonito."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-giftwrap-continue1",
                                speaker: .native,
                                text: "わかりました、少々お待ちください、包装しますね。",
                                translations: [
                                    .korean: "네, 잠시만요, 포장해드릴게요.",
                                    .english: "Okay, one moment, I'll wrap it for you.",
                                    .japanese: "わかりました、少々お待ちください、包装しますね。",
                                    .chinese: "好的，稍等，我帮您包装。",
                                    .spanish: "Bien, un momento, lo envuelvo."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-giftwrap-followup2",
                                        speaker: .user,
                                        text: "包装料金はいくらですか？",
                                        translations: [
                                            .korean: "포장 비용은 얼마예요?",
                                            .english: "How much is the wrapping fee?",
                                            .japanese: "包装料金はいくらですか？",
                                            .chinese: "包装费多少钱？",
                                            .spanish: "¿Cuánto cuesta envolver?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-giftwrap-end1",
                                                speaker: .native,
                                                text: "無料ですよ、含まれています。",
                                                translations: [
                                                    .korean: "무료예요, 포함되어 있어요.",
                                                    .english: "It's free, already included.",
                                                    .japanese: "無料ですよ、含まれています。",
                                                    .chinese: "免费的，已经包括了。",
                                                    .spanish: "Es gratis, ya está incluido."
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
    ),

    // MARK: - 관광지 카테고리
    Scenario(
        id: "ja-buy-entrance-ticket",
        learningLanguage: .japanese,
        category: .tourism,
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
        startingPhrase: "入場料はいくらですか？",
        startingPhraseTranslations: [
            .korean: "입장료 얼마예요?",
            .english: "How much is the entrance fee?",
            .japanese: "入場料はいくらですか？",
            .chinese: "门票多少钱？",
            .spanish: "¿Cuánto cuesta la entrada?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-entrance-response1",
                speaker: .native,
                text: "一人5万ルピアです。",
                translations: [
                    .korean: "1인당 5만 루피아예요.",
                    .english: "50 thousand per person.",
                    .japanese: "一人5万ルピアです。",
                    .chinese: "每人5万。",
                    .spanish: "50 mil por persona."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-entrance-followup1",
                        speaker: .user,
                        text: "2名です。",
                        translations: [
                            .korean: "2명이요.",
                            .english: "Two people.",
                            .japanese: "2名です。",
                            .chinese: "两个人。",
                            .spanish: "Dos personas."
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-entrance-continue1",
                                speaker: .native,
                                text: "合計10万ルピアです。チケットです。",
                                translations: [
                                    .korean: "총 10만 루피아예요. 여기 티켓이요.",
                                    .english: "Total 100 thousand. Here are your tickets.",
                                    .japanese: "合計10万ルピアです。チケットです。",
                                    .chinese: "总共10万。这是您的票。",
                                    .spanish: "Total 100 mil. Aquí están sus entradas."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-entrance-followup2",
                                        speaker: .user,
                                        text: "ありがとうございます。閉館は何時ですか？",
                                        translations: [
                                            .korean: "감사합니다. 몇 시에 닫아요?",
                                            .english: "Thank you. What time does it close?",
                                            .japanese: "ありがとうございます。閉館は何時ですか？",
                                            .chinese: "谢谢。几点关门？",
                                            .spanish: "Gracias. ¿A qué hora cierra?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-entrance-end1",
                                                speaker: .native,
                                                text: "午後6時です。お楽しみください！",
                                                translations: [
                                                    .korean: "오후 6시요. 즐기세요!",
                                                    .english: "6 PM. Enjoy!",
                                                    .japanese: "午後6時です。お楽しみください！",
                                                    .chinese: "下午6点。请享受！",
                                                    .spanish: "A las 6 PM. ¡Disfruten!"
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
    ),
    Scenario(
        id: "ja-ask-photo",
        learningLanguage: .japanese,
        category: .tourism,
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
        startingPhrase: "写真を撮ってください！",
        startingPhraseTranslations: [
            .korean: "사진 좀 찍어주세요!",
            .english: "Please take a photo for me!",
            .japanese: "写真を撮ってください！",
            .chinese: "请帮我拍照！",
            .spanish: "¡Por favor tómeme una foto!"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-photo-response1",
                speaker: .native,
                text: "オッケー、準備して。いち、に、さん！",
                translations: [
                    .korean: "네, 준비하세요. 하나, 둘, 셋!",
                    .english: "Okay, get ready. One, two, three!",
                    .japanese: "オッケー、準備して。いち、に、さん！",
                    .chinese: "好的，准备好。一、二、三！",
                    .spanish: "Ok, prepárense. ¡Uno, dos, tres!"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-photo-followup1",
                        speaker: .user,
                        text: "もう一枚いいですか？",
                        translations: [
                            .korean: "한 장 더 찍어도 될까요?",
                            .english: "Can we take one more?",
                            .japanese: "もう一枚いいですか？",
                            .chinese: "可以再拍一张吗？",
                            .spanish: "¿Podemos tomar una más?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-photo-continue1",
                                speaker: .native,
                                text: "もちろんです。さあ、笑って！",
                                translations: [
                                    .korean: "물론이죠. 자, 웃으세요!",
                                    .english: "Sure. Come on, smile!",
                                    .japanese: "もちろんです。さあ、笑って！",
                                    .chinese: "当然可以。来，笑一笑！",
                                    .spanish: "Claro. ¡Vamos, sonrían!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-photo-followup2",
                                        speaker: .user,
                                        text: "どうもありがとうございます！",
                                        translations: [
                                            .korean: "정말 감사합니다!",
                                            .english: "Thank you so much!",
                                            .japanese: "どうもありがとうございます！",
                                            .chinese: "非常感谢！",
                                            .spanish: "¡Muchas gracias!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-photo-end1",
                                                speaker: .native,
                                                text: "どういたしまして！写真いいですよ。",
                                                translations: [
                                                    .korean: "천만에요! 사진 잘 나왔어요.",
                                                    .english: "You're welcome! The photos came out nice.",
                                                    .japanese: "どういたしまして！写真いいですよ。",
                                                    .chinese: "不客气！照片很好看。",
                                                    .spanish: "¡De nada! Las fotos salieron bien."
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
    ),
    Scenario(
        id: "ja-ask-recommendation-place",
        learningLanguage: .japanese,
        category: .tourism,
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
        startingPhrase: "ここにいい観光地はありますか？",
        startingPhraseTranslations: [
            .korean: "여기 좋은 관광지 있어요?",
            .english: "Are there any good tourist spots here?",
            .japanese: "ここにいい観光地はありますか？",
            .chinese: "这里有什么好的旅游景点吗？",
            .spanish: "¿Hay buenos lugares turísticos aquí?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-placerec-response1",
                speaker: .native,
                text: "ボロブドゥール寺院は本当にいいですよ！絶対に行ってください。",
                translations: [
                    .korean: "보로부두르 사원 정말 좋아요! 꼭 가보세요.",
                    .english: "Borobudur Temple is really great! You must go there.",
                    .japanese: "ボロブドゥール寺院は本当にいいですよ！絶対に行ってください。",
                    .chinese: "婆罗浮屠非常好！一定要去。",
                    .spanish: "¡El Templo de Borobudur es genial! Debe ir allí."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-placerec-followup1",
                        speaker: .user,
                        text: "ここから遠いですか？",
                        translations: [
                            .korean: "여기서 멀어요?",
                            .english: "Is it far from here?",
                            .japanese: "ここから遠いですか？",
                            .chinese: "从这里远吗？",
                            .spanish: "¿Está lejos de aquí?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-placerec-continue1",
                                speaker: .native,
                                text: "車で1時間くらいです。本当に行く価値ありますよ！",
                                translations: [
                                    .korean: "차로 1시간 정도요. 정말 가볼 만해요!",
                                    .english: "About 1 hour by car. Totally worth it!",
                                    .japanese: "車で1時間くらいです。本当に行く価値ありますよ！",
                                    .chinese: "开车大约1小时。绝对值得！",
                                    .spanish: "Como 1 hora en auto. ¡Totalmente vale la pena!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-placerec-followup2",
                                        speaker: .user,
                                        text: "わかりました、明日行きます。ありがとうございます！",
                                        translations: [
                                            .korean: "알겠어요, 내일 가볼게요. 감사합니다!",
                                            .english: "Okay, I'll go there tomorrow. Thank you!",
                                            .japanese: "わかりました、明日行きます。ありがとうございます！",
                                            .chinese: "好的，我明天去那里。谢谢！",
                                            .spanish: "Bueno, iré mañana. ¡Gracias!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-placerec-end1",
                                                speaker: .native,
                                                text: "どういたしまして！良い旅を。",
                                                translations: [
                                                    .korean: "천만에요! 즐거운 여행 되세요.",
                                                    .english: "You're welcome! Enjoy your trip.",
                                                    .japanese: "どういたしまして！良い旅を。",
                                                    .chinese: "不客气！祝您旅途愉快。",
                                                    .spanish: "¡De nada! Que disfrute su viaje."
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
    ),
    Scenario(
        id: "ja-opening-hours",
        learningLanguage: .japanese,
        category: .tourism,
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
        startingPhrase: "何時まで開いていますか？",
        startingPhraseTranslations: [
            .korean: "몇 시까지 열어요?",
            .english: "What time is it open until?",
            .japanese: "何時まで開いていますか？",
            .chinese: "开到几点？",
            .spanish: "¿Hasta qué hora abre?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-hours-response1",
                speaker: .native,
                text: "毎日午後5時までです。",
                translations: [
                    .korean: "매일 오후 5시까지예요.",
                    .english: "Until 5 PM every day.",
                    .japanese: "毎日午後5時までです。",
                    .chinese: "每天到下午5点。",
                    .spanish: "Hasta las 5 PM todos los días."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-hours-followup1",
                        speaker: .user,
                        text: "日曜日も開いていますか？",
                        translations: [
                            .korean: "일요일에도 열어요?",
                            .english: "Open on Sundays too?",
                            .japanese: "日曜日も開いていますか？",
                            .chinese: "星期天也开吗？",
                            .spanish: "¿También abre los domingos?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-hours-continue1",
                                speaker: .native,
                                text: "はい、祝日以外は毎日開いています。",
                                translations: [
                                    .korean: "네, 국경일 빼고 매일 열어요.",
                                    .english: "Yes, open every day except national holidays.",
                                    .japanese: "はい、祝日以外は毎日開いています。",
                                    .chinese: "是的，除了国定假日每天都开。",
                                    .spanish: "Sí, abre todos los días excepto feriados nacionales."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-hours-followup2",
                                        speaker: .user,
                                        text: "良かった！情報ありがとうございます。",
                                        translations: [
                                            .korean: "좋아요! 정보 감사합니다.",
                                            .english: "Great! Thank you for the information.",
                                            .japanese: "良かった！情報ありがとうございます。",
                                            .chinese: "太好了！谢谢信息。",
                                            .spanish: "¡Genial! Gracias por la información."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-hours-end1",
                                                speaker: .native,
                                                text: "どういたしまして。良い見学を！",
                                                translations: [
                                                    .korean: "천만에요. 즐거운 관람 되세요!",
                                                    .english: "You're welcome. Enjoy your visit!",
                                                    .japanese: "どういたしまして。良い見学を！",
                                                    .chinese: "不客气。祝您参观愉快！",
                                                    .spanish: "De nada. ¡Que disfrute su visita!"
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
    ),
    Scenario(
        id: "ja-guided-tour",
        learningLanguage: .japanese,
        category: .tourism,
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
        startingPhrase: "英語を話すガイドはいますか？",
        startingPhraseTranslations: [
            .korean: "영어 가이드 있나요?",
            .english: "Is there an English-speaking tour guide?",
            .japanese: "英語を話すガイドはいますか？",
            .chinese: "有说英语的导游吗？",
            .spanish: "¿Hay guía turístico que hable inglés?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-guide-response1",
                speaker: .native,
                text: "います。ツアーは午前10時に始まります。",
                translations: [
                    .korean: "있어요. 투어는 오전 10시에 시작해요.",
                    .english: "Yes. Tours start at 10 AM.",
                    .japanese: "います。ツアーは午前10時に始まります。",
                    .chinese: "有的。导览从早上10点开始。",
                    .spanish: "Sí. Los tours comienzan a las 10 AM."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-guide-followup1",
                        speaker: .user,
                        text: "費用はいくらですか？",
                        translations: [
                            .korean: "비용이 얼마예요?",
                            .english: "How much does it cost?",
                            .japanese: "費用はいくらですか？",
                            .chinese: "费用是多少？",
                            .spanish: "¿Cuánto cuesta?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-guide-continue1",
                                speaker: .native,
                                text: "2時間ツアーで一人20万ルピアです。",
                                translations: [
                                    .korean: "2시간 투어에 1인당 20만 루피아예요.",
                                    .english: "200 thousand per person for a 2-hour tour.",
                                    .japanese: "2時間ツアーで一人20万ルピアです。",
                                    .chinese: "2小时导览每人20万。",
                                    .spanish: "200 mil por persona para un tour de 2 horas."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-guide-followup2",
                                        speaker: .user,
                                        text: "わかりました、10時のツアーに参加したいです。どこで申し込みますか？",
                                        translations: [
                                            .korean: "알겠어요, 10시 투어 참가하고 싶어요. 어디서 신청하나요?",
                                            .english: "Okay, I want to join the 10 o'clock tour. Where do I register?",
                                            .japanese: "わかりました、10時のツアーに参加したいです。どこで申し込みますか？",
                                            .chinese: "好的，我想参加10点的导览。在哪里报名？",
                                            .spanish: "Bueno, quiero unirme al tour de las 10. ¿Dónde me registro?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-guide-end1",
                                                speaker: .native,
                                                text: "案内カウンターで、入口の隣です。",
                                                translations: [
                                                    .korean: "안내 창구에서요, 입구 옆에 있어요.",
                                                    .english: "At the information counter, next to the entrance.",
                                                    .japanese: "案内カウンターで、入口の隣です。",
                                                    .chinese: "在咨询台，入口旁边。",
                                                    .spanish: "En el mostrador de información, al lado de la entrada."
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
    ),

    // MARK: - 긴급 상황 카테고리
    Scenario(
        id: "ja-find-pharmacy",
        learningLanguage: .japanese,
        category: .emergency,
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
        startingPhrase: "すみません、近くに薬局はありますか？",
        startingPhraseTranslations: [
            .korean: "실례합니다, 가까운 약국 있나요?",
            .english: "Excuse me, is there a nearby pharmacy?",
            .japanese: "すみません、近くに薬局はありますか？",
            .chinese: "请问，附近有药店吗？",
            .spanish: "Disculpe, ¿hay una farmacia cerca?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-pharmacy-response1",
                speaker: .native,
                text: "あります、まっすぐ100メートル、右側にあります。",
                translations: [
                    .korean: "있어요, 직진 100미터, 오른편에 있어요.",
                    .english: "Yes, go straight 100 meters, on the right side.",
                    .japanese: "あります、まっすぐ100メートル、右側にあります。",
                    .chinese: "有，直走100米，在右边。",
                    .spanish: "Sí, vaya recto 100 metros, al lado derecho."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-pharmacy-followup1",
                        speaker: .user,
                        text: "今開いていますか？",
                        translations: [
                            .korean: "지금 열었어요?",
                            .english: "Is it open now?",
                            .japanese: "今開いていますか？",
                            .chinese: "现在还开着吗？",
                            .spanish: "¿Está abierto ahora?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-pharmacy-continue1",
                                speaker: .native,
                                text: "はい、夜10時まで開いています。",
                                translations: [
                                    .korean: "네, 밤 10시까지 열어요.",
                                    .english: "Yes, open until 10 PM.",
                                    .japanese: "はい、夜10時まで開いています。",
                                    .chinese: "是的，开到晚上10点。",
                                    .spanish: "Sí, abre hasta las 10 PM."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-pharmacy-followup2",
                                        speaker: .user,
                                        text: "どうもありがとうございます！",
                                        translations: [
                                            .korean: "정말 감사합니다!",
                                            .english: "Thank you so much!",
                                            .japanese: "どうもありがとうございます！",
                                            .chinese: "非常感谢！",
                                            .spanish: "¡Muchas gracias!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-pharmacy-end1",
                                                speaker: .native,
                                                text: "どういたしまして。お大事に！",
                                                translations: [
                                                    .korean: "천만에요. 빨리 나으세요!",
                                                    .english: "You're welcome. Get well soon!",
                                                    .japanese: "どういたしまして。お大事に！",
                                                    .chinese: "不客气。早日康复！",
                                                    .spanish: "De nada. ¡Que se mejore pronto!"
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
    ),
    Scenario(
        id: "ja-lost-item",
        learningLanguage: .japanese,
        category: .emergency,
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
        startingPhrase: "財布をなくしました。",
        startingPhraseTranslations: [
            .korean: "지갑을 잃어버렸어요.",
            .english: "I lost my wallet.",
            .japanese: "財布をなくしました。",
            .chinese: "我丢了钱包。",
            .spanish: "Perdí mi billetera."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-lost-response1",
                speaker: .native,
                text: "ああ、大変！最後にどこで見ましたか？",
                translations: [
                    .korean: "오, 안됐네요! 마지막으로 어디서 봤어요?",
                    .english: "Oh no! Where did you last see it?",
                    .japanese: "ああ、大変！最後にどこで見ましたか？",
                    .chinese: "哦不！最后在哪里看到的？",
                    .spanish: "¡Oh no! ¿Dónde lo vio por última vez?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-lost-followup1",
                        speaker: .user,
                        text: "さっきのレストランです。電話していただけますか？",
                        translations: [
                            .korean: "아까 식당이요. 거기 전화 좀 해주시겠어요?",
                            .english: "At the restaurant earlier. Can you help call them?",
                            .japanese: "さっきのレストランです。電話していただけますか？",
                            .chinese: "刚才在餐厅。能帮我打电话给他们吗？",
                            .spanish: "En el restaurante hace rato. ¿Puede ayudarme a llamarlos?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-lost-continue1",
                                speaker: .native,
                                text: "もちろん、今電話します。",
                                translations: [
                                    .korean: "물론이죠, 지금 전화할게요.",
                                    .english: "Sure, I'll call them now.",
                                    .japanese: "もちろん、今電話します。",
                                    .chinese: "当然，我现在就打电话。",
                                    .spanish: "Claro, los llamo ahora."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-lost-followup2",
                                        speaker: .user,
                                        text: "助けていただきありがとうございます。",
                                        translations: [
                                            .korean: "도와주셔서 정말 감사합니다.",
                                            .english: "Thank you so much for your help.",
                                            .japanese: "助けていただきありがとうございます。",
                                            .chinese: "非常感谢您的帮助。",
                                            .spanish: "Muchas gracias por su ayuda."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-lost-end1",
                                                speaker: .native,
                                                text: "どういたしまして。良いニュースです、お財布はレストランにあります！",
                                                translations: [
                                                    .korean: "천만에요. 좋은 소식이에요, 지갑이 식당에 있대요!",
                                                    .english: "You're welcome. Good news, your wallet is at the restaurant!",
                                                    .japanese: "どういたしまして。良いニュースです、お財布はレストランにあります！",
                                                    .chinese: "不客气。好消息，您的钱包在餐厅！",
                                                    .spanish: "De nada. ¡Buenas noticias, su billetera está en el restaurante!"
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
    ),
    Scenario(
        id: "ja-ask-help",
        learningLanguage: .japanese,
        category: .emergency,
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
        startingPhrase: "助けて、助けが必要です！",
        startingPhraseTranslations: [
            .korean: "도와주세요, 도움이 필요해요!",
            .english: "Help, I need assistance!",
            .japanese: "助けて、助けが必要です！",
            .chinese: "救命，我需要帮助！",
            .spanish: "¡Ayuda, necesito asistencia!"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-help-response1",
                speaker: .native,
                text: "どうしたんですか？手伝いますよ。",
                translations: [
                    .korean: "무슨 일이에요? 도와드릴게요.",
                    .english: "What's wrong? I can help.",
                    .japanese: "どうしたんですか？手伝いますよ。",
                    .chinese: "怎么了？我可以帮忙。",
                    .spanish: "¿Qué pasa? Puedo ayudar."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-help-followup1",
                        speaker: .user,
                        text: "友達が病気です。病院はどこですか？",
                        translations: [
                            .korean: "제 친구가 아파요. 병원이 어디예요?",
                            .english: "My friend is sick. Where's the hospital?",
                            .japanese: "友達が病気です。病院はどこですか？",
                            .chinese: "我朋友病了。医院在哪里？",
                            .spanish: "Mi amigo está enfermo. ¿Dónde está el hospital?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-help-continue1",
                                speaker: .native,
                                text: "私の車で連れて行きます。一緒に行きましょう！",
                                translations: [
                                    .korean: "제 차로 데려다 드릴게요. 같이 가요!",
                                    .english: "I'll take you in my car. Let's go!",
                                    .japanese: "私の車で連れて行きます。一緒に行きましょう！",
                                    .chinese: "我用我的车送你们去。走吧！",
                                    .spanish: "Los llevo en mi auto. ¡Vamos!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-help-followup2",
                                        speaker: .user,
                                        text: "わあ、どうもありがとうございます！とても親切ですね。",
                                        translations: [
                                            .korean: "와, 정말 감사합니다! 너무 친절하시네요.",
                                            .english: "Wow, thank you so much! You're so kind.",
                                            .japanese: "わあ、どうもありがとうございます！とても親切ですね。",
                                            .chinese: "哇，非常感谢！您真善良。",
                                            .spanish: "¡Guau, muchas gracias! Es muy amable."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-help-end1",
                                                speaker: .native,
                                                text: "どういたしまして。急ぎましょう、車はここです。",
                                                translations: [
                                                    .korean: "천만에요. 빨리 가요, 차가 여기 있어요.",
                                                    .english: "You're welcome. Let's hurry, the car is here.",
                                                    .japanese: "どういたしまして。急ぎましょう、車はここです。",
                                                    .chinese: "不客气。快走吧，车在这里。",
                                                    .spanish: "De nada. Apurémonos, el auto está aquí."
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
    ),
    Scenario(
        id: "ja-find-hospital",
        learningLanguage: .japanese,
        category: .emergency,
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
        startingPhrase: "一番近い病院はどこですか？",
        startingPhraseTranslations: [
            .korean: "가장 가까운 병원이 어디예요?",
            .english: "Where's the nearest hospital?",
            .japanese: "一番近い病院はどこですか？",
            .chinese: "最近的医院在哪里？",
            .spanish: "¿Dónde está el hospital más cercano?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-hospital-response1",
                speaker: .native,
                text: "フサダ病院です、ここから5分ほどです。",
                translations: [
                    .korean: "후사다 병원이요, 여기서 5분 정도 걸려요.",
                    .english: "Husada Hospital, about 5 minutes from here.",
                    .japanese: "フサダ病院です、ここから5分ほどです。",
                    .chinese: "胡萨达医院，离这里大约5分钟。",
                    .spanish: "Hospital Husada, como 5 minutos de aquí."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-hospital-followup1",
                        speaker: .user,
                        text: "救急があります か？",
                        translations: [
                            .korean: "응급실 있어요?",
                            .english: "Does it have an ER?",
                            .japanese: "救急があります か？",
                            .chinese: "有急诊吗？",
                            .spanish: "¿Tiene emergencias?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-hospital-continue1",
                                speaker: .native,
                                text: "あります、24時間です。道を教えますね。",
                                translations: [
                                    .korean: "있어요, 24시간이에요. 제가 길 알려드릴게요.",
                                    .english: "Yes, 24 hours. Let me show you the way.",
                                    .japanese: "あります、24時間です。道を教えますね。",
                                    .chinese: "有，24小时。我给你指路。",
                                    .spanish: "Sí, 24 horas. Le muestro el camino."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-hospital-followup2",
                                        speaker: .user,
                                        text: "本当にありがとうございます！とても助かります。",
                                        translations: [
                                            .korean: "정말 감사합니다! 큰 도움이 됩니다.",
                                            .english: "Thank you so much! This really helps.",
                                            .japanese: "本当にありがとうございます！とても助かります。",
                                            .chinese: "非常感谢！真的帮了大忙。",
                                            .spanish: "¡Muchas gracias! Esto ayuda mucho."
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-hospital-end1",
                                                speaker: .native,
                                                text: "大丈夫です。前の信号で右に曲がってください。",
                                                translations: [
                                                    .korean: "괜찮아요. 앞 신호등에서 오른쪽으로 도세요.",
                                                    .english: "No problem. Turn right at the traffic light ahead.",
                                                    .japanese: "大丈夫です。前の信号で右に曲がってください。",
                                                    .chinese: "没关系。前面红绿灯右转。",
                                                    .spanish: "No hay problema. Gire a la derecha en el semáforo."
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
    ),

    // MARK: - 현지인과 교류 카테고리
    Scenario(
        id: "ja-weather-chat",
        learningLanguage: .japanese,
        category: .casual,
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
        startingPhrase: "今日は本当に暑いですね！",
        startingPhraseTranslations: [
            .korean: "오늘 날씨 정말 덥네요!",
            .english: "The weather is really hot today!",
            .japanese: "今日は本当に暑いですね！",
            .chinese: "今天天气真热啊！",
            .spanish: "¡El clima está muy caluroso hoy!"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-weather-response1",
                speaker: .native,
                text: "ええ、いつもこんな感じです。ここは普通ですよ。",
                translations: [
                    .korean: "네, 원래 이래요. 여기는 원래 그래요.",
                    .english: "Yeah, it's usually like this. Normal here.",
                    .japanese: "ええ、いつもこんな感じです。ここは普通ですよ。",
                    .chinese: "是啊，一般都这样。这里习以为常。",
                    .spanish: "Sí, usualmente es así. Normal aquí."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-weather-followup1",
                        speaker: .user,
                        text: "午後に雨が降りますかね？",
                        translations: [
                            .korean: "오후에 비 올까요?",
                            .english: "Will it rain this afternoon?",
                            .japanese: "午後に雨が降りますかね？",
                            .chinese: "下午会下雨吗？",
                            .spanish: "¿Lloverá esta tarde?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-weather-continue1",
                                speaker: .native,
                                text: "たぶんそうですね。念のため傘を持っていってください。",
                                translations: [
                                    .korean: "올 것 같아요. 혹시 몰라 우산 가져가세요.",
                                    .english: "Probably yes. Bring an umbrella just in case.",
                                    .japanese: "たぶんそうですね。念のため傘を持っていってください。",
                                    .chinese: "可能会。带把伞以防万一。",
                                    .spanish: "Probablemente sí. Traiga paraguas por si acaso."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-weather-followup2",
                                        speaker: .user,
                                        text: "わかりました、アドバイスありがとうございます！",
                                        translations: [
                                            .korean: "알겠어요, 조언 감사합니다!",
                                            .english: "Okay, thank you for the advice!",
                                            .japanese: "わかりました、アドバイスありがとうございます！",
                                            .chinese: "好的，谢谢建议！",
                                            .spanish: "Bien, ¡gracias por el consejo!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-weather-end1",
                                                speaker: .native,
                                                text: "どういたしまして。道中気をつけて！",
                                                translations: [
                                                    .korean: "천만에요. 조심히 가세요!",
                                                    .english: "You're welcome. Be careful on the road!",
                                                    .japanese: "どういたしまして。道中気をつけて！",
                                                    .chinese: "不客气。路上小心！",
                                                    .spanish: "De nada. ¡Ten cuidado en el camino!"
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
    ),
    Scenario(
        id: "ja-where-from",
        learningLanguage: .japanese,
        category: .casual,
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
        startingPhrase: "私は韓国から来ました。",
        startingPhraseTranslations: [
            .korean: "저는 한국에서 왔어요.",
            .english: "I'm from Korea.",
            .japanese: "私は韓国から来ました。",
            .chinese: "我来自韩国。",
            .spanish: "Soy de Corea."
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-from-response1",
                speaker: .native,
                text: "わあ、韓国！K-popは好きですか？",
                translations: [
                    .korean: "와, 한국이요! K-pop 좋아하세요?",
                    .english: "Wow, Korea! Do you like K-pop?",
                    .japanese: "わあ、韓国！K-popは好きですか？",
                    .chinese: "哇，韩国！喜欢K-pop吗？",
                    .spanish: "¡Wow, Corea! ¿Te gusta el K-pop?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-from-followup1",
                        speaker: .user,
                        text: "まあまあ好きです。韓国のアーティスト知ってますか？",
                        translations: [
                            .korean: "꽤 좋아해요. 한국 가수 알아요?",
                            .english: "I like it quite a bit. Do you know Korean artists?",
                            .japanese: "まあまあ好きです。韓国のアーティスト知ってますか？",
                            .chinese: "还挺喜欢的。你知道韩国艺人吗？",
                            .spanish: "Me gusta bastante. ¿Conoces artistas coreanos?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-from-continue1",
                                speaker: .native,
                                text: "BTSとBlackpink！すごいですよね！",
                                translations: [
                                    .korean: "BTS랑 블랙핑크요! 정말 멋져요!",
                                    .english: "BTS and Blackpink! They're so cool!",
                                    .japanese: "BTSとBlackpink！すごいですよね！",
                                    .chinese: "BTS和Blackpink！超酷的！",
                                    .spanish: "¡BTS y Blackpink! ¡Son geniales!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-from-followup2",
                                        speaker: .user,
                                        text: "わあ、あなたも好きなんですね！コンサート見ましたか？",
                                        translations: [
                                            .korean: "와, 너도 좋아해! 콘서트 봤어요?",
                                            .english: "Wow, you like them too! Have you seen their concert?",
                                            .japanese: "わあ、あなたも好きなんですね！コンサート見ましたか？",
                                            .chinese: "哇，你也喜欢！看过演唱会吗？",
                                            .spanish: "¡Guau, a ti también te gustan! ¿Has visto su concierto?"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-from-end1",
                                                speaker: .native,
                                                text: "まだですが、本当に見たいです！いつか見られるといいな。",
                                                translations: [
                                                    .korean: "아직이요, 하지만 정말 보고 싶어요! 언젠가 볼 수 있길 바래요.",
                                                    .english: "Not yet, but I really want to! Hopefully can watch someday.",
                                                    .japanese: "まだですが、本当に見たいです！いつか見られるといいな。",
                                                    .chinese: "还没有，但是很想看！希望有一天能看。",
                                                    .spanish: "Todavía no, ¡pero quiero mucho! Espero poder ver algún día."
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
    ),
    Scenario(
        id: "ja-recommend-food",
        learningLanguage: .japanese,
        category: .casual,
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
        startingPhrase: "この辺においしい食堂はありますか？",
        startingPhraseTranslations: [
            .korean: "이 근처에 맛있는 식당 있어요?",
            .english: "Are there any good eateries around here?",
            .japanese: "この辺においしい食堂はありますか？",
            .chinese: "这附近有好吃的餐馆吗？",
            .spanish: "¿Hay buenos restaurantes por aquí?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-foodrec-response1",
                speaker: .native,
                text: "あります！パックブディの食堂、チキンソトが最高です！",
                translations: [
                    .korean: "있어요! 빠 부디 식당, 소토 아얌이 최고예요!",
                    .english: "Yes! Pak Budi's eatery, their chicken soto is the best!",
                    .japanese: "あります！パックブディの食堂、チキンソトが最高です！",
                    .chinese: "有！布迪大叔的餐馆，鸡肉汤是最棒的！",
                    .spanish: "¡Sí! El puesto de Pak Budi, ¡su soto de pollo es el mejor!"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-foodrec-followup1",
                        speaker: .user,
                        text: "ここから遠いですか？",
                        translations: [
                            .korean: "여기서 멀어요?",
                            .english: "Is it far from here?",
                            .japanese: "ここから遠いですか？",
                            .chinese: "离这里远吗？",
                            .spanish: "¿Está lejos de aquí?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-foodrec-continue1",
                                speaker: .native,
                                text: "近いですよ、歩いて5分です。絶対に試してください！",
                                translations: [
                                    .korean: "가까워요, 걸어서 5분이에요. 꼭 먹어봐야 해요!",
                                    .english: "Close, 5-minute walk. You must try it!",
                                    .japanese: "近いですよ、歩いて5分です。絶対に試してください！",
                                    .chinese: "很近，走路5分钟。一定要试试！",
                                    .spanish: "Cerca, 5 minutos caminando. ¡Debes probarlo!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-foodrec-followup2",
                                        speaker: .user,
                                        text: "いいですね、後で試します。おすすめありがとうございます！",
                                        translations: [
                                            .korean: "좋아요, 나중에 가볼게요. 추천 감사합니다!",
                                            .english: "Great, I'll try it later. Thank you for the recommendation!",
                                            .japanese: "いいですね、後で試します。おすすめありがとうございます！",
                                            .chinese: "好的，我待会去试试。谢谢推荐！",
                                            .spanish: "Genial, lo probaré luego. ¡Gracias por la recomendación!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-foodrec-end1",
                                                speaker: .native,
                                                text: "どういたしまして！いただきます！",
                                                translations: [
                                                    .korean: "천만에요! 맛있게 드세요!",
                                                    .english: "You're welcome! Enjoy your meal!",
                                                    .japanese: "どういたしまして！いただきます！",
                                                    .chinese: "不客气！用餐愉快！",
                                                    .spanish: "¡De nada! ¡Que aproveche!"
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
    ),
    Scenario(
        id: "ja-ask-directions",
        learningLanguage: .japanese,
        category: .casual,
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
        startingPhrase: "すみません、駅までどう行きますか？",
        startingPhraseTranslations: [
            .korean: "죄송한데요, 역까지 어떻게 가요?",
            .english: "Excuse me, how do I get to the station?",
            .japanese: "すみません、駅までどう行きますか？",
            .chinese: "不好意思，怎么去车站？",
            .spanish: "Disculpe, ¿cómo llego a la estación?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-directions-response1",
                speaker: .native,
                text: "交差点までまっすぐ行って、左に曲がってください。",
                translations: [
                    .korean: "쭉 가다가 사거리에서 왼쪽으로 도세요.",
                    .english: "Just go straight to the intersection, then turn left.",
                    .japanese: "交差点までまっすぐ行って、左に曲がってください。",
                    .chinese: "一直走到十字路口，然后左转。",
                    .spanish: "Sigue recto hasta el cruce, luego gira a la izquierda."
                ],
                responses: [
                    ConversationNode(
                        id: "ja-directions-followup1",
                        speaker: .user,
                        text: "ありがとう！歩いて何分くらいですか？",
                        translations: [
                            .korean: "감사합니다! 걸어서 몇 분 정도요?",
                            .english: "Thank you! About how many minutes walking?",
                            .japanese: "ありがとう！歩いて何分くらいですか？",
                            .chinese: "谢谢！走路大概几分钟？",
                            .spanish: "¡Gracias! ¿Cuántos minutos caminando?"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-directions-continue1",
                                speaker: .native,
                                text: "10分くらいです。ゆっくりどうぞ。",
                                translations: [
                                    .korean: "10분 정도요. 천천히 가세요.",
                                    .english: "About 10 minutes. Take it easy.",
                                    .japanese: "10分くらいです。ゆっくりどうぞ。",
                                    .chinese: "大约10分钟。慢慢走。",
                                    .spanish: "Como 10 minutos. Tranquilo."
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-directions-followup2",
                                        speaker: .user,
                                        text: "わかりました。改めてありがとうございます！",
                                        translations: [
                                            .korean: "알겠습니다. 다시 한 번 감사합니다!",
                                            .english: "Okay got it. Thank you again!",
                                            .japanese: "わかりました。改めてありがとうございます！",
                                            .chinese: "好的明白了。再次感谢！",
                                            .spanish: "Bien entendido. ¡Gracias de nuevo!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-directions-end1",
                                                speaker: .native,
                                                text: "どういたしまして。気をつけて！",
                                                translations: [
                                                    .korean: "천만에요. 잘 가세요!",
                                                    .english: "You're welcome. Safe travels!",
                                                    .japanese: "どういたしまして。気をつけて！",
                                                    .chinese: "不客气。一路平安！",
                                                    .spanish: "De nada. ¡Buen viaje!"
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
    ),
    Scenario(
        id: "ja-greeting-chat",
        learningLanguage: .japanese,
        category: .casual,
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
        startingPhrase: "こんにちは！お元気ですか？",
        startingPhraseTranslations: [
            .korean: "안녕하세요! 어떻게 지내세요?",
            .english: "Hello! How are you?",
            .japanese: "こんにちは！お元気ですか？",
            .chinese: "你好！你好吗？",
            .spanish: "¡Hola! ¿Cómo estás?"
        ],
        conversationTree: [
            ConversationNode(
                id: "ja-greeting-response1",
                speaker: .native,
                text: "元気です！インドネシアに来たばかりですか？",
                translations: [
                    .korean: "잘 지내요! 인도네시아에 막 오셨어요?",
                    .english: "Good! Did you just arrive in Indonesia?",
                    .japanese: "元気です！インドネシアに来たばかりですか？",
                    .chinese: "很好！你刚到印度尼西亚吗？",
                    .spanish: "¡Bien! ¿Acabas de llegar a Indonesia?"
                ],
                responses: [
                    ConversationNode(
                        id: "ja-greeting-followup1",
                        speaker: .user,
                        text: "はい、昨日着いたばかりです。ここに来られて嬉しいです！",
                        translations: [
                            .korean: "네, 어제 막 도착했어요. 여기 와서 기뻐요!",
                            .english: "Yes, just arrived yesterday. Happy to be here!",
                            .japanese: "はい、昨日着いたばかりです。ここに来られて嬉しいです！",
                            .chinese: "是的，昨天刚到。很高兴来这里！",
                            .spanish: "Sí, llegué ayer. ¡Feliz de estar aquí!"
                        ],
                        responses: [
                            ConversationNode(
                                id: "ja-greeting-continue1",
                                speaker: .native,
                                text: "ようこそ！助けが必要なら言ってくださいね！",
                                translations: [
                                    .korean: "환영합니다! 도움 필요하면 말씀하세요!",
                                    .english: "Welcome! If you need help, just let me know!",
                                    .japanese: "ようこそ！助けが必要なら言ってくださいね！",
                                    .chinese: "欢迎！需要帮助就说！",
                                    .spanish: "¡Bienvenido! ¡Si necesitas ayuda, avísame!"
                                ],
                                responses: [
                                    ConversationNode(
                                        id: "ja-greeting-followup2",
                                        speaker: .user,
                                        text: "ありがとうございます！インドネシアの人々は親切ですね！",
                                        translations: [
                                            .korean: "감사합니다! 인도네시아 사람들 정말 친절하네요!",
                                            .english: "Thank you! Indonesian people are so friendly!",
                                            .japanese: "ありがとうございます！インドネシアの人々は親切ですね！",
                                            .chinese: "谢谢！印度尼西亚人真友好！",
                                            .spanish: "¡Gracias! ¡La gente indonesia es muy amable!"
                                        ],
                                        responses: [
                                            ConversationNode(
                                                id: "ja-greeting-end1",
                                                speaker: .native,
                                                text: "どういたしまして！インドネシアでの休暇を楽しんでください！",
                                                translations: [
                                                    .korean: "천만에요! 인도네시아에서 즐거운 휴가 보내세요!",
                                                    .english: "You're welcome! Enjoy your vacation in Indonesia!",
                                                    .japanese: "どういたしまして！インドネシアでの休暇を楽しんでください！",
                                                    .chinese: "不客气！祝您在印度尼西亚度假愉快！",
                                                    .spanish: "¡De nada! ¡Disfruta tus vacaciones en Indonesia!"
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
    )
]

}
