import SwiftUI

struct ContentView: View {
    let nativeLanguage: Language
    let learningLanguage: Language

    @StateObject private var scenarioManager = CustomScenarioManager.shared
    @State private var showingScenarioCreation = false
    @State private var showingScenarioImport = false
    @State private var showSettings = false
    @State private var showingHistory = false

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    private var customScenarios: [CustomScenario] {
        scenarioManager.scenarios(for: learningLanguage)
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // 헤더
                    VStack(spacing: 8) {
                        Text(localizedText.appName)
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text(localizedText.appSubtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                // 사용자 지정 시나리오 섹션
                if !customScenarios.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(localizedText.myScenarios)
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
                    Text(localizedText.builtInScenarios)
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
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack(spacing: 16) {
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape")
                    }

                    Button(action: {
                        showingHistory = true
                    }) {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button(action: {
                        showingScenarioImport = true
                    }) {
                        Image(systemName: "square.and.arrow.down")
                            .font(.title3)
                    }

                    Button(action: {
                        showingScenarioCreation = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
        }
        .sheet(isPresented: $showingScenarioCreation) {
            ScenarioCreationView(nativeLanguage: nativeLanguage, learningLanguage: learningLanguage)
        }
        .sheet(isPresented: $showingScenarioImport) {
            ScenarioImportView(nativeLanguage: nativeLanguage, learningLanguage: learningLanguage)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showingHistory) {
            ConversationHistoryView(nativeLanguage: nativeLanguage)
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
        default: return "Delete"
        }
    }
}

// MARK: - 시나리오 카드 뷰
struct ScenarioCard: View {
    let scenario: Scenario
    let nativeLanguage: Language
    @State private var showingScriptViewer = false

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

            // Script viewer button
            Button(action: { showingScriptViewer = true }) {
                Image(systemName: "doc.text.magnifyingglass")
                    .foregroundColor(.blue)
                    .font(.title3)
            }
            .buttonStyle(PlainButtonStyle())

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .sheet(isPresented: $showingScriptViewer) {
            ScriptViewerView(
                scenario: scenario,
                nativeLanguage: nativeLanguage,
                learningLanguage: scenario.learningLanguage
            )
        }
    }
}

// MARK: - 사용자 시나리오 카드 뷰
struct CustomScenarioCard: View {
    let scenario: CustomScenario
    let nativeLanguage: Language
    @State private var showingScriptViewer = false

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

            // Script viewer button
            Button(action: { showingScriptViewer = true }) {
                Image(systemName: "doc.text.magnifyingglass")
                    .foregroundColor(.green)
                    .font(.title3)
            }
            .buttonStyle(PlainButtonStyle())

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .sheet(isPresented: $showingScriptViewer) {
            ScriptViewerView(
                scenario: scenario.toScenario(),
                nativeLanguage: nativeLanguage,
                learningLanguage: scenario.learningLanguage
            )
        }
    }
}

#Preview {
    NavigationView {
        ContentView(nativeLanguage: .korean, learningLanguage: .indonesian)
    }
}
