#!/usr/bin/env python3
"""
Scenario Expansion Helper Script
This script helps generate expansion templates for conversation scenarios
"""

# Common follow-up questions by scenario type
FOLLOW_UP_TEMPLATES = {
    "location": {
        "indonesian": "Kira-kira berapa lama sampai ke sana?",
        "korean": "거기까지 얼마나 걸리나요?",
        "english": "How long does it take to get there?",
        "japanese": "そこまでどのくらいかかりますか？",
        "chinese": "到那里要多久？",
        "spanish": "¿Cuánto tiempo se tarda en llegar?"
    },
    "confirmation": {
        "indonesian": "Baik, terima kasih banyak!",
        "korean": "알겠습니다, 정말 감사합니다!",
        "english": "Okay, thank you very much!",
        "japanese": "わかりました、どうもありがとうございます！",
        "chinese": "好的，非常感谢！",
        "spanish": "Bien, ¡muchas gracias!"
    },
    "price_question": {
        "indonesian": "Berapa harganya?",
        "korean": "얼마예요?",
        "english": "How much is it?",
        "japanese": "いくらですか？",
        "chinese": "多少钱？",
        "spanish": "¿Cuánto cuesta?"
    },
    "time_question": {
        "indonesian": "Jam berapa?",
        "korean": "몇 시예요?",
        "english": "What time?",
        "japanese": "何時ですか？",
        "chinese": "几点？",
        "spanish": "¿A qué hora?"
    },
    "availability": {
        "indonesian": "Apakah tersedia?",
        "korean": "있나요?",
        "english": "Is it available?",
        "japanese": "ありますか？",
        "chinese": "有吗？",
        "spanish": "¿Está disponible?"
    }
}

CLOSING_RESPONSES = {
    "polite_close": {
        "indonesian": "Sama-sama, selamat!",
        "korean": "천만에요!",
        "english": "You're welcome!",
        "japanese": "どういたしまして！",
        "chinese": "不客气！",
        "spanish": "¡De nada!"
    },
    "helpful_close": {
        "indonesian": "Sama-sama. Semoga membantu!",
        "korean": "천만에요. 도움이 되길 바랍니다!",
        "english": "You're welcome. Hope that helps!",
        "japanese": "どういたしまして。お役に立てれば幸いです！",
        "chinese": "不客气。希望有帮助！",
        "spanish": "De nada. ¡Espero que ayude!"
    }
}

def generate_expansion_template(scenario_id, scenario_type="general"):
    """Generate an expansion template for a given scenario"""

    template = f"""
// Expansion for {scenario_id}
// Add this to expand the conversation to 4 turns

ConversationNode(
    id: "{scenario_id}-continue",
    speaker: .native,
    text: "[Current last native response]",
    translations: [
        .korean: "[Korean]",
        .english: "[English]",
        .japanese: "[Japanese]",
        .chinese: "[Chinese]",
        .spanish: "[Spanish]"
    ],
    responses: [
        ConversationNode(
            id: "{scenario_id}-followup-new",
            speaker: .user,
            text: "[Contextual follow-up question in learning language]",
            translations: [
                .korean: "[Korean translation]",
                .english: "[English translation]",
                .japanese: "[Japanese translation]",
                .chinese: "[Chinese translation]",
                .spanish: "[Spanish translation]"
            ],
            responses: [
                ConversationNode(
                    id: "{scenario_id}-end-final",
                    speaker: .native,
                    text: "[Final helpful response]",
                    translations: [
                        .korean: "[Korean translation]",
                        .english: "[English translation]",
                        .japanese: "[Japanese translation]",
                        .chinese: "[Chinese translation]",
                        .spanish: "[Spanish translation]"
                    ],
                    responses: nil
                )
            ]
        )
    ]
)
"""
    return template

def print_expansion_guide():
    """Print a guide for expanding scenarios"""
    print("=" * 80)
    print("SCENARIO EXPANSION GUIDE")
    print("=" * 80)
    print("\nStep-by-step process:")
    print("1. Identify the current endpoint (responses: nil)")
    print("2. Change responses: nil to responses: [...]")
    print("3. Add a new ConversationNode with appropriate context")
    print("4. Add another response level to reach 4 turns total")
    print("5. Ensure all 5 languages are translated")
    print("\nCommon Follow-up Patterns:")
    print("- Ask for clarification (time, location, price)")
    print("- Request additional information")
    print("- Confirm understanding")
    print("- Thank and close conversation")
    print("\nTranslation Quality Checklist:")
    print("✓ Natural conversational flow")
    print("✓ Culturally appropriate")
    print("✓ Matches formality level")
    print("✓ Contextually relevant")
    print("=" * 80)

if __name__ == "__main__":
    print_expansion_guide()
    print("\nExample templates available in this script.")
    print("Modify and use these as starting points for expansions.")
