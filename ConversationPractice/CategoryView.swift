import SwiftUI

// MARK: - Category List View
struct CategoryListView: View {
    let nativeLanguage: Language
    let learningLanguage: Language

    @StateObject private var scenarioManager = CustomScenarioManager.shared
    @State private var showSettings = false
    @State private var showingHistory = false
    @State private var showingScenarioCreation = false
    @State private var showingScenarioImport = false

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    // Get built-in scenarios grouped by category
    private var categorizedScenarios: [(category: ScenarioCategory, scenarios: [Scenario])] {
        let allScenarios = ScenarioData.scenarios(for: learningLanguage)
        let grouped = Dictionary(grouping: allScenarios) { $0.category }

        return ScenarioCategory.allCases.compactMap { category in
            guard let scenarios = grouped[category], !scenarios.isEmpty else { return nil }
            return (category: category, scenarios: scenarios)
        }
    }

    // Custom scenarios
    private var customScenarios: [CustomScenario] {
        scenarioManager.scenarios(for: learningLanguage)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Header
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

                    // Custom Scenarios Section
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
                            }
                        }
                    }

                    // Category Cards
                    VStack(alignment: .leading, spacing: 12) {
                        Text(localizedText.builtInScenarios)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.horizontal)

                        ForEach(categorizedScenarios, id: \.category) { item in
                            NavigationLink(destination: ScenarioListView(
                                category: item.category,
                                scenarios: item.scenarios,
                                nativeLanguage: nativeLanguage,
                                learningLanguage: learningLanguage
                            )) {
                                CategoryCard(
                                    category: item.category,
                                    scenarioCount: item.scenarios.count,
                                    nativeLanguage: nativeLanguage
                                )
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
    }
}

// MARK: - Category Card
struct CategoryCard: View {
    let category: ScenarioCategory
    let scenarioCount: Int
    let nativeLanguage: Language

    var body: some View {
        HStack(spacing: 16) {
            // Category Icon
            Text(category.icon)
                .font(.system(size: 50))
                .frame(width: 70, height: 70)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)

            // Category Info
            VStack(alignment: .leading, spacing: 4) {
                Text(category.getName(for: nativeLanguage))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Text("\(scenarioCount) \(scenariosLabel)")
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
        .padding(.horizontal)
    }

    private var scenariosLabel: String {
        switch nativeLanguage {
        case .korean: return "개 시나리오"
        case .english: return "scenarios"
        case .japanese: return "シナリオ"
        case .chinese: return "个场景"
        case .spanish: return "escenarios"
        case .indonesian: return "skenario"
        default: return "scenarios"
        }
    }
}

#Preview {
    CategoryListView(nativeLanguage: .korean, learningLanguage: .indonesian)
}
