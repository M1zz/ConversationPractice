import SwiftUI

@main
struct ConversationPracticeApp: App {
    @StateObject private var languageSettings = LanguageSettings.shared

    var body: some Scene {
        WindowGroup {
            if languageSettings.isConfigured,
               let nativeLanguage = languageSettings.nativeLanguage,
               let learningLanguage = languageSettings.learningLanguage {
                CategoryListView(
                    nativeLanguage: nativeLanguage,
                    learningLanguage: learningLanguage
                )
            } else {
                NavigationView {
                    LanguageSelectionView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}
