import Foundation
import SwiftUI

class LanguageSettings: ObservableObject {
    static let shared = LanguageSettings()

    @Published var nativeLanguage: Language? {
        didSet {
            if let language = nativeLanguage {
                UserDefaults.standard.set(language.rawValue, forKey: "nativeLanguage")
            }
        }
    }

    @Published var learningLanguage: Language? {
        didSet {
            if let language = learningLanguage {
                UserDefaults.standard.set(language.rawValue, forKey: "learningLanguage")
            }
        }
    }

    var isConfigured: Bool {
        return nativeLanguage != nil && learningLanguage != nil
    }

    private init() {
        // UserDefaults에서 저장된 언어 불러오기
        if let nativeRawValue = UserDefaults.standard.string(forKey: "nativeLanguage"),
           let native = Language(rawValue: nativeRawValue) {
            self.nativeLanguage = native
        }

        if let learningRawValue = UserDefaults.standard.string(forKey: "learningLanguage"),
           let learning = Language(rawValue: learningRawValue) {
            self.learningLanguage = learning
        }
    }

    func reset() {
        UserDefaults.standard.removeObject(forKey: "nativeLanguage")
        UserDefaults.standard.removeObject(forKey: "learningLanguage")
        nativeLanguage = nil
        learningLanguage = nil
    }
}
