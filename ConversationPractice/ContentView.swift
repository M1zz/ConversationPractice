import SwiftUI

struct ContentView: View {
    let nativeLanguage: Language
    let learningLanguage: Language

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 헤더
                VStack(spacing: 8) {
                    Text(headerTitle)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(headerSubtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)

                // 시나리오 카드들 (학습 언어에 맞는 시나리오만 표시)
                ForEach(ScenarioData.scenarios(for: learningLanguage)) { scenario in
                    NavigationLink(destination: ConversationView(
                        scenario: scenario,
                        nativeLanguage: nativeLanguage,
                        learningLanguage: learningLanguage
                    )) {
                        ScenarioCard(scenario: scenario, nativeLanguage: nativeLanguage)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerTitle: String {
        switch nativeLanguage {
        case .korean: return "대화 연습"
        case .english: return "Conversation Practice"
        case .japanese: return "会話練習"
        case .chinese: return "对话练习"
        case .spanish: return "Práctica de conversación"
        case .indonesian: return "Latihan Percakapan"
        }
    }

    private var headerSubtitle: String {
        switch nativeLanguage {
        case .korean: return "실제 상황에서의 다양한 답변에 대응하는 연습"
        case .english: return "Practice responding to various answers in real situations"
        case .japanese: return "実際の状況でさまざまな回答に対応する練習"
        case .chinese: return "练习在真实情况下应对各种回答"
        case .spanish: return "Practica respondiendo a varias respuestas en situaciones reales"
        case .indonesian: return "Berlatih merespons berbagai jawaban dalam situasi nyata"
        }
    }
}

// MARK: - 시나리오 카드 뷰
struct ScenarioCard: View {
    let scenario: Scenario
    let nativeLanguage: Language

    var body: some View {
        HStack(spacing: 16) {
            // 아이콘
            Text(scenario.icon)
                .font(.system(size: 40))
                .frame(width: 60, height: 60)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)

            // 텍스트 정보 (모국어로 표시)
            VStack(alignment: .leading, spacing: 4) {
                Text(scenario.getTitle(for: nativeLanguage))
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(scenario.getDescription(for: nativeLanguage))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationView {
        ContentView(nativeLanguage: .korean, learningLanguage: .indonesian)
    }
}
