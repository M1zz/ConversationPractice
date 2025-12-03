import SwiftUI

@main
struct ConversationPracticeApp: App {
    @StateObject private var languageSettings = LanguageSettings.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if languageSettings.isConfigured,
                   let nativeLanguage = languageSettings.nativeLanguage,
                   let learningLanguage = languageSettings.learningLanguage {
                    ContentView(
                        nativeLanguage: nativeLanguage,
                        learningLanguage: learningLanguage
                    )
                } else {
                    LanguageSelectionView()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
