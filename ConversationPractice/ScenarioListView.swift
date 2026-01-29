import SwiftUI

// MARK: - Scenario List View
struct ScenarioListView: View {
    let category: ScenarioCategory
    let scenarios: [Scenario]
    let nativeLanguage: Language
    let learningLanguage: Language

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(scenarios) { scenario in
                        NavigationLink(destination: ConversationView(
                            scenario: scenario,
                            nativeLanguage: nativeLanguage,
                            learningLanguage: learningLanguage
                        )) {
                            ScenarioCardWithPreview(
                                scenario: scenario,
                                nativeLanguage: nativeLanguage
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .navigationTitle(category.getName(for: nativeLanguage))
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Scenario Card with Preview
struct ScenarioCardWithPreview: View {
    let scenario: Scenario
    let nativeLanguage: Language

    @State private var showingFullScript = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Main Card
            HStack(spacing: 16) {
                // Icon
                ZStack(alignment: .bottomTrailing) {
                    Text(scenario.icon)
                        .font(.system(size: 40))
                        .frame(width: 60, height: 60)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)

                    // Learning language flag badge
                    Text(scenario.learningLanguage.flag)
                        .font(.system(size: 16))
                        .padding(4)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                        .offset(x: 4, y: 4)
                }

                // Text info
                VStack(alignment: .leading, spacing: 4) {
                    Text(scenario.getTitle(for: nativeLanguage))
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(scenario.getDescription(for: nativeLanguage))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()

            // View Full Script Button
            VStack(alignment: .leading, spacing: 12) {
                Divider()

                Button(action: {
                    showingFullScript = true
                }) {
                    HStack {
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(.blue)
                        Text(viewFullScriptLabel)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
            .padding(.bottom)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .sheet(isPresented: $showingFullScript) {
            NavigationStack {
                MessengerScriptView(
                    scenario: scenario,
                    nativeLanguage: nativeLanguage,
                    learningLanguage: scenario.learningLanguage
                )
            }
        }
    }

    private var viewFullScriptLabel: String {
        switch nativeLanguage {
        case .korean: return "전체 스크립트 보기"
        case .english: return "View Full Script"
        case .japanese: return "全スクリプトを表示"
        case .chinese: return "查看完整脚本"
        case .spanish: return "Ver guión completo"
        case .indonesian: return "Lihat Skrip Lengkap"
        default: return "View Full Script"
        }
    }
}

#Preview {
    NavigationStack {
        ScenarioListView(
            category: .restaurant,
            scenarios: ScenarioData.scenarios(for: .indonesian).filter { $0.category == .restaurant },
            nativeLanguage: .korean,
            learningLanguage: .indonesian
        )
    }
}
