# Scenario Expansion Plan

## Current Status

### Completed Expansions (6/58 scenarios)
1. ✅ id-bathroom - Extended to 4 turns
2. ✅ id-ordering - Extended to 4 turns  
3. ✅ id-airport-checkin - Extended to 4 turns
4. ✅ id-find-gate - Extended to 4 turns
5. ✅ id-flight-drink - Extended to 4 turns
6. ✅ id-baggage-claim - Extended to 4 turns

### Remaining Scenarios (52)

#### Indonesian Scenarios (47 remaining)
- id-customs
- id-money-exchange
- id-seat-change
- id-hotel-checkin
- id-guesthouse-checkin
- id-room-service
- id-breakfast-time
- id-hotel-checkout
- id-luggage-storage
- id-towel-request
- id-wifi-password
- id-table-reservation
- id-menu-recommendation
- id-allergy-inquiry
- id-ask-bill
- id-takeout-order
- id-coffee-order
- id-water-request
- id-vegetarian-menu
- id-taxi-call
- id-tell-destination
- id-ask-fare
- id-metro-route
- id-bus-stop
- id-buy-ticket
- id-ask-transfer
- id-ojek
- id-ask-price
- id-ask-discount
- id-ask-size
- id-try-on
- id-ask-refund
- id-gift-wrap
- id-buy-entrance-ticket
- id-ask-photo
- id-ask-recommendation-place
- id-opening-hours
- id-guided-tour
- id-find-pharmacy
- id-lost-item
- id-ask-help
- id-find-hospital
- id-weather-chat
- id-where-from
- id-recommend-food
- id-ask-directions
- id-greeting-chat

#### Other Language Scenarios (5 remaining)
- ko-bathroom (Korean learning)
- en-bathroom (English learning)
- ja-bathroom (Japanese learning)
- zh-bathroom (Chinese learning)
- es-bathroom (Spanish learning)

## Expansion Pattern

Each scenario currently has 2-3 conversation turns and needs to be expanded to 4 turns.

### Structure
```
Starting Phrase (User) 
  → Native Response 1 
    → User Follow-up 1 
      → Native Response 2 
        → User Follow-up 2 (NEW)
          → Native Response 3 (NEW)
            → User Follow-up 3 (NEW - OPTIONAL)
              → Native Final Response (NEW)
```

### Example Expansion Template

```swift
ConversationNode(
    id: "continue-id",
    speaker: .native,
    text: "[Existing response]",
    translations: [
        .korean: "[Korean translation]",
        .english: "[English translation]",
        .japanese: "[Japanese translation]",
        .chinese: "[Chinese translation]",
        .spanish: "[Spanish translation]"
    ],
    responses: [
        ConversationNode(
            id: "followup-new-id",
            speaker: .user,
            text: "[New contextual question in learning language]",
            translations: [
                .korean: "[Korean translation]",
                .english: "[English translation]",
                .japanese: "[Japanese translation]",
                .chinese: "[Chinese translation]",
                .spanish: "[Spanish translation]"
            ],
            responses: [
                ConversationNode(
                    id: "end-id",
                    speaker: .native,
                    text: "[Final response in learning language]",
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
```

## Translation Languages Required
All conversations must be translated into:
1. Korean (.korean)
2. English (.english)
3. Japanese (.japanese)
4. Chinese (.chinese)
5. Spanish (.spanish)
6. Indonesian (for Indonesian scenarios - base text)

## Recommendations

Given the scale (52 scenarios × ~100 lines each = ~5,200 lines), this task requires:

1. **Time Estimate**: 20-30 hours for careful, contextually appropriate expansions
2. **Approach Options**:
   - Manual expansion (highest quality, most time-consuming)
   - Semi-automated with AI translation (faster, needs review)
   - Phased approach: expand critical scenarios first

3. **Priority Scenarios** (high usage):
   - Hotel/accommodation scenarios
   - Restaurant/food scenarios
   - Transportation scenarios
   - Emergency scenarios

## Next Steps

1. Continue manual expansion of high-priority scenarios
2. Consider using translation APIs for initial drafts
3. Review and refine all translations for natural conversation flow
4. Test scenarios in the app to ensure proper functioning
