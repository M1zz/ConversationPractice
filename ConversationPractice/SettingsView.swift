import SwiftUI

struct SettingsView: View {
    @ObservedObject private var languageSettings = LanguageSettings.shared
    @ObservedObject private var scenarioManager = CustomScenarioManager.shared
    @Environment(\.dismiss) private var dismiss

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: languageSettings.nativeLanguage ?? .english)
    }

    // 각 언어별 시나리오 개수를 계산
    private func scenarioCount(for language: Language) -> Int {
        return scenarioManager.scenarios(for: language).count
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 언어 선택 섹션 (병렬 배치)
                    HStack(alignment: .top, spacing: 16) {
                        // 학습 언어 선택 (왼쪽)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(learningLanguageHeader)
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 16)
                                .padding(.top, 8)

                            VStack(spacing: 0) {
                                ForEach(Language.allCases.filter { $0 != languageSettings.nativeLanguage }) { language in
                                    Button(action: {
                                        languageSettings.learningLanguage = language
                                    }) {
                                        HStack {
                                            Text(language.flag)
                                            Text("\(language.displayName) (\(scenarioCount(for: language)))")
                                                .foregroundColor(.primary)
                                            Spacer()
                                            if languageSettings.learningLanguage == language {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                    }
                                    if language != Language.allCases.filter { $0 != languageSettings.nativeLanguage }.last {
                                        Divider()
                                            .padding(.leading, 16)
                                    }
                                }
                            }
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(10)
                        }

                        // 모국어 선택 (오른쪽 - 깃발만 표시)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(nativeLanguageHeader)
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 16)
                                .padding(.top, 8)

                            VStack(spacing: 0) {
                                ForEach(Language.allCases) { language in
                                    Button(action: {
                                        languageSettings.nativeLanguage = language
                                    }) {
                                        HStack {
                                            Text(language.flag)
                                                .font(.largeTitle)
                                            Spacer()
                                            if languageSettings.nativeLanguage == language {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                    }
                                    if language != Language.allCases.last {
                                        Divider()
                                            .padding(.leading, 16)
                                    }
                                }
                            }
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: 100)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    // 리셋 버튼
                    Button(action: {
                        languageSettings.reset()
                    }) {
                        HStack {
                            Spacer()
                            Text(resetSettingsLabel)
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .padding(.vertical, 12)
                    }
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle(localizedText.settings)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(localizedText.done) {
                        dismiss()
                    }
                }
            }
        }
    }

    private var nativeLanguageHeader: String {
        localizedText.nativeLanguageLabel
    }

    private var learningLanguageHeader: String {
        localizedText.learningLanguageLabel
    }

    private var resetSettingsLabel: String {
        localizedText.resetSettings
    }
}

#Preview {
    SettingsView()
}
