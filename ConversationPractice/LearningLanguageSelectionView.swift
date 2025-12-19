import SwiftUI

struct LearningLanguageSelectionView: View {
    let nativeLanguage: Language
    @ObservedObject private var languageSettings = LanguageSettings.shared

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    // 모국어를 제외한 학습 가능한 언어 목록 (시나리오가 있는 언어만)
    private var availableLanguages: [Language] {
        let languagesWithScenarios: [Language] = [.indonesian, .korean, .english, .japanese, .chinese, .spanish]
        return languagesWithScenarios.filter { $0 != nativeLanguage }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 헤더
                VStack(spacing: 8) {
                    Text(localizedText.selectLearningLanguage)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(localizedText.whatDoYouWantToLearn)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)

                // 언어 목록 (모국어 제외)
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(availableLanguages) { language in
                        Button(action: {
                            // 언어 설정 저장
                            languageSettings.nativeLanguage = nativeLanguage
                            languageSettings.learningLanguage = language
                        }) {
                            LanguageCard(language: language)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        LearningLanguageSelectionView(nativeLanguage: .korean)
    }
}
