import SwiftUI

struct SettingsView: View {
    @ObservedObject private var languageSettings = LanguageSettings.shared
    @Environment(\.dismiss) private var dismiss

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: languageSettings.nativeLanguage ?? .english)
    }

    var body: some View {
        NavigationView {
            Form {
                // 모국어 선택
                Section(header: Text(nativeLanguageHeader)) {
                    ForEach(Language.allCases) { language in
                        Button(action: {
                            languageSettings.nativeLanguage = language
                        }) {
                            HStack {
                                Text(language.flag)
                                Text(language.displayName)
                                    .foregroundColor(.primary)
                                Spacer()
                                if languageSettings.nativeLanguage == language {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }

                // 학습 언어 선택
                Section(header: Text(learningLanguageHeader)) {
                    ForEach(Language.allCases.filter { $0 != languageSettings.nativeLanguage }) { language in
                        Button(action: {
                            languageSettings.learningLanguage = language
                        }) {
                            HStack {
                                Text(language.flag)
                                Text(language.displayName)
                                    .foregroundColor(.primary)
                                Spacer()
                                if languageSettings.learningLanguage == language {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }

                // 리셋 버튼
                Section {
                    Button(action: {
                        languageSettings.reset()
                    }) {
                        HStack {
                            Spacer()
                            Text(resetSettingsLabel)
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle(settingsTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(doneLabel) {
                        dismiss()
                    }
                }
            }
        }
    }

    private var settingsTitle: String {
        switch languageSettings.nativeLanguage {
        case .korean: return "설정"
        case .english: return "Settings"
        case .japanese: return "設定"
        case .chinese: return "设置"
        case .spanish: return "Configuración"
        case .indonesian: return "Pengaturan"
        case .none: return "Settings"
        }
    }

    private var nativeLanguageHeader: String {
        switch languageSettings.nativeLanguage {
        case .korean: return "모국어"
        case .english: return "Native Language"
        case .japanese: return "母国語"
        case .chinese: return "母语"
        case .spanish: return "Idioma nativo"
        case .indonesian: return "Bahasa Ibu"
        case .none: return "Native Language"
        }
    }

    private var learningLanguageHeader: String {
        switch languageSettings.nativeLanguage {
        case .korean: return "학습 언어"
        case .english: return "Learning Language"
        case .japanese: return "学習言語"
        case .chinese: return "学习语言"
        case .spanish: return "Idioma de aprendizaje"
        case .indonesian: return "Bahasa Belajar"
        case .none: return "Learning Language"
        }
    }

    private var resetSettingsLabel: String {
        switch languageSettings.nativeLanguage {
        case .korean: return "설정 초기화"
        case .english: return "Reset Settings"
        case .japanese: return "設定をリセット"
        case .chinese: return "重置设置"
        case .spanish: return "Restablecer configuración"
        case .indonesian: return "Reset Pengaturan"
        case .none: return "Reset Settings"
        }
    }

    private var doneLabel: String {
        switch languageSettings.nativeLanguage {
        case .korean: return "완료"
        case .english: return "Done"
        case .japanese: return "完了"
        case .chinese: return "完成"
        case .spanish: return "Listo"
        case .indonesian: return "Selesai"
        case .none: return "Done"
        }
    }
}

#Preview {
    SettingsView()
}
