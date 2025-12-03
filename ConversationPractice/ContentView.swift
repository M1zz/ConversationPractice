import SwiftUI

struct ContentView: View {
    let nativeLanguage: Language
    let learningLanguage: Language

    @StateObject private var scenarioManager = CustomScenarioManager.shared
    @State private var showingScenarioCreation = false
    @State private var showSettings = false

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    private var customScenarios: [CustomScenario] {
        scenarioManager.scenarios(for: learningLanguage)
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

                // 사용자 지정 시나리오 섹션
                if !customScenarios.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(customScenariosLabel)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.horizontal)

                        ForEach(customScenarios) { customScenario in
                            NavigationLink(destination: ConversationView(
                                scenario: customScenario.toScenario(),
                                nativeLanguage: nativeLanguage,
                                learningLanguage: learningLanguage
                            )) {
                                CustomScenarioCard(
                                    scenario: customScenario,
                                    nativeLanguage: nativeLanguage
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    scenarioManager.deleteScenario(customScenario)
                                } label: {
                                    Label(deleteLabel, systemImage: "trash")
                                }
                            }
                        }
                    }
                }

                // 기본 시나리오 섹션
                VStack(alignment: .leading, spacing: 12) {
                    Text(builtInScenariosLabel)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.horizontal)

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
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showSettings = true
                }) {
                    Image(systemName: "gearshape")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingScenarioCreation = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
            }
        }
        .sheet(isPresented: $showingScenarioCreation) {
            ScenarioCreationView(nativeLanguage: nativeLanguage, learningLanguage: learningLanguage)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
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

    private var customScenariosLabel: String {
        switch nativeLanguage {
        case .korean: return "내 시나리오"
        case .english: return "My Scenarios"
        case .japanese: return "マイシナリオ"
        case .chinese: return "我的场景"
        case .spanish: return "Mis escenarios"
        case .indonesian: return "Skenario Saya"
        }
    }

    private var builtInScenariosLabel: String {
        switch nativeLanguage {
        case .korean: return "기본 시나리오"
        case .english: return "Built-in Scenarios"
        case .japanese: return "組み込みシナリオ"
        case .chinese: return "内置场景"
        case .spanish: return "Escenarios integrados"
        case .indonesian: return "Skenario Bawaan"
        }
    }

    private var deleteLabel: String {
        switch nativeLanguage {
        case .korean: return "삭제"
        case .english: return "Delete"
        case .japanese: return "削除"
        case .chinese: return "删除"
        case .spanish: return "Eliminar"
        case .indonesian: return "Hapus"
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

// MARK: - 사용자 시나리오 카드 뷰
struct CustomScenarioCard: View {
    let scenario: CustomScenario
    let nativeLanguage: Language

    var body: some View {
        HStack(spacing: 16) {
            // 아이콘
            Text(scenario.icon)
                .font(.system(size: 40))
                .frame(width: 60, height: 60)
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)

            // 텍스트 정보
            VStack(alignment: .leading, spacing: 4) {
                Text(scenario.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(scenario.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
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
