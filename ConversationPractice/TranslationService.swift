import Foundation
import Translation

@MainActor
@Observable
class TranslationService {
    static let shared = TranslationService()

    // TranslationSession 저장 (언어 쌍별로) - iOS 18.0+
    private var sessionsStorage: Any?

    // 언어 가용성 캐시
    private var languageAvailabilityCache: [String: Bool] = [:]

    private init() {
        if #available(iOS 18.0, *) {
            prepareSupportedLanguages()
        }
    }

    @available(iOS 18.0, *)
    private var sessions: [String: TranslationSession] {
        get {
            if let storage = sessionsStorage as? [String: TranslationSession] {
                return storage
            }
            return [:]
        }
        set {
            sessionsStorage = newValue
        }
    }

    // 지원되는 언어 목록 미리 준비
    @available(iOS 18.0, *)
    private func prepareSupportedLanguages() {
        Task { @MainActor in
            let availability = LanguageAvailability()
            let supportedLanguages = await availability.supportedLanguages

            print("📚 [TRANSLATION] 지원되는 언어 개수: \(supportedLanguages.count)")
            for lang in supportedLanguages {
                print("  - \(lang.maximalIdentifier)")
            }
        }
    }

    // 언어 코드 변환
    func languageCode(for language: Language) -> String {
        switch language {
        case .korean: return "ko"
        case .english: return "en"
        case .japanese: return "ja"
        case .chinese: return "zh-Hans"
        case .spanish: return "es"
        case .indonesian: return "id"
        case .arabic: return "ar"
        case .dutch: return "nl"
        case .french: return "fr"
        case .german: return "de"
        case .hindi: return "hi"
        case .italian: return "it"
        case .polish: return "pl"
        case .portuguese: return "pt"
        case .russian: return "ru"
        case .thai: return "th"
        case .turkish: return "tr"
        case .ukrainian: return "uk"
        case .vietnamese: return "vi"
        case .swedish: return "sv"
        case .danish: return "da"
        case .norwegian: return "nb"
        case .finnish: return "fi"
        case .czech: return "cs"
        case .hebrew: return "he"
        case .romanian: return "ro"
        }
    }

    // Locale.Language로 변환
    private func localeLanguage(for language: Language) -> Locale.Language {
        return Locale.Language(identifier: languageCode(for: language))
    }

    // Session 키 생성
    private func sessionKey(from: Language, to: Language) -> String {
        return "\(from.rawValue)->\(to.rawValue)"
    }

    // 언어 쌍의 Apple Translation 지원 여부 확인
    @available(iOS 18.0, *)
    func checkLanguageSupport(from sourceLanguage: Language, to targetLanguage: Language) async -> Bool {
        let key = sessionKey(from: sourceLanguage, to: targetLanguage)

        // 캐시된 결과가 있으면 반환
        if let cached = languageAvailabilityCache[key] {
            return cached
        }

        let availability = LanguageAvailability()
        let status = await availability.status(
            from: localeLanguage(for: sourceLanguage),
            to: localeLanguage(for: targetLanguage)
        )

        let isSupported: Bool
        switch status {
        case .installed, .supported:
            isSupported = true
            print("✅ [TRANSLATION] \(sourceLanguage.displayName) → \(targetLanguage.displayName): 지원됨")
        case .unsupported:
            isSupported = false
            print("❌ [TRANSLATION] \(sourceLanguage.displayName) → \(targetLanguage.displayName): 미지원")
        @unknown default:
            isSupported = false
            print("⚠️ [TRANSLATION] \(sourceLanguage.displayName) → \(targetLanguage.displayName): 알 수 없음")
        }

        // 캐시에 저장
        languageAvailabilityCache[key] = isSupported
        return isSupported
    }

    // TranslationSession 생성 및 저장
    @available(iOS 18.0, *)
    func createSession(from sourceLanguage: Language, to targetLanguage: Language) -> TranslationSession.Configuration {
        return TranslationSession.Configuration(
            source: localeLanguage(for: sourceLanguage),
            target: localeLanguage(for: targetLanguage)
        )
    }

    // TranslationSession 설정 (View의 translationTask에서 호출)
    @available(iOS 18.0, *)
    func setSession(_ session: TranslationSession, from: Language, to: Language) {
        let key = sessionKey(from: from, to: to)
        sessions[key] = session
        print("📝 [TRANSLATION] Session 저장: \(key)")
    }

    // 단일 텍스트 번역
    func translate(text: String, from sourceLanguage: Language, to targetLanguage: Language) async throws -> String {
        guard !text.isEmpty else { return "" }

        // iOS 18.0+ Apple Translation 시도
        if #available(iOS 18.0, *) {
            // 언어 지원 여부 확인
            let isSupported = await checkLanguageSupport(from: sourceLanguage, to: targetLanguage)

            if isSupported {
                let key = sessionKey(from: sourceLanguage, to: targetLanguage)
                if let session = sessions[key] {
                    do {
                        print("🍎 [TRANSLATION] Apple Translation 사용: \(text)")
                        let response = try await session.translate(text)
                        print("✅ [TRANSLATION] Apple Translation 성공: \(response.targetText)")
                        return response.targetText
                    } catch {
                        print("⚠️ [TRANSLATION] Apple Translation 실패, MyMemory로 fallback: \(error)")
                    }
                } else {
                    print("⚠️ [TRANSLATION] Session 없음, MyMemory로 fallback")
                }
            }
        }

        // MyMemory API fallback
        return try await translateWithMyMemory(text: text, from: sourceLanguage, to: targetLanguage)
    }

    // 배치 번역 (여러 텍스트를 한 번에)
    @available(iOS 18.0, *)
    func translateBatch(texts: [String], from sourceLanguage: Language, to targetLanguage: Language) async throws -> [String] {
        guard !texts.isEmpty else { return [] }

        let key = sessionKey(from: sourceLanguage, to: targetLanguage)
        guard let session = sessions[key] else {
            print("⚠️ [TRANSLATION] Session 없음, 개별 번역으로 fallback")
            // Session이 없으면 개별 번역
            var results: [String] = []
            for text in texts {
                let translated = try await translate(text: text, from: sourceLanguage, to: targetLanguage)
                results.append(translated)
            }
            return results
        }

        // 배치 요청 생성
        let requests: [TranslationSession.Request] = texts.enumerated().map { (index, text) in
                .init(sourceText: text, clientIdentifier: "\(index)")
        }

        do {
            print("🍎 [TRANSLATION] Apple 배치 번역 시작: \(texts.count)개")
            let responses = try await session.translations(from: requests)
            let results = responses.map { $0.targetText }
            print("✅ [TRANSLATION] Apple 배치 번역 성공")
            return results
        } catch {
            print("⚠️ [TRANSLATION] Apple 배치 번역 실패: \(error)")
            throw error
        }
    }

    // 배치 번역 (순차적으로, 실시간 업데이트 가능)
    @available(iOS 18.0, *)
    func translateBatchSequence(
        texts: [String],
        from sourceLanguage: Language,
        to targetLanguage: Language,
        onProgress: @escaping (Int, String) -> Void
    ) async throws {
        guard !texts.isEmpty else { return }

        let key = sessionKey(from: sourceLanguage, to: targetLanguage)
        guard let session = sessions[key] else {
            print("⚠️ [TRANSLATION] Session 없음")
            throw TranslationError.sessionNotFound
        }

        // 배치 요청 생성
        let requests: [TranslationSession.Request] = texts.enumerated().map { (index, text) in
                .init(sourceText: text, clientIdentifier: "\(index)")
        }

        do {
            print("🍎 [TRANSLATION] Apple 순차 배치 번역 시작: \(texts.count)개")
            for try await response in session.translate(batch: requests) {
                guard let index = Int(response.clientIdentifier ?? "") else { continue }
                onProgress(index, response.targetText)
            }
            print("✅ [TRANSLATION] Apple 순차 배치 번역 완료")
        } catch {
            print("⚠️ [TRANSLATION] Apple 순차 배치 번역 실패: \(error)")
            throw error
        }
    }

    // 언어 다운로드 준비 (오프라인 번역용)
    @available(iOS 18.0, *)
    func prepareTranslation(from sourceLanguage: Language, to targetLanguage: Language) async throws {
        let key = sessionKey(from: sourceLanguage, to: targetLanguage)
        guard let session = sessions[key] else {
            print("⚠️ [TRANSLATION] Session 없음, 준비 불가")
            throw TranslationError.sessionNotFound
        }

        do {
            print("📥 [TRANSLATION] 언어 다운로드 시작: \(sourceLanguage.displayName) → \(targetLanguage.displayName)")
            try await session.prepareTranslation()
            print("✅ [TRANSLATION] 언어 다운로드 완료")
        } catch {
            print("⚠️ [TRANSLATION] 언어 다운로드 실패: \(error)")
            throw error
        }
    }

    // MARK: - MyMemory API Fallback

    private func translateWithMyMemory(text: String, from sourceLanguage: Language, to targetLanguage: Language) async throws -> String {
        let sourceLang = languageCode(for: sourceLanguage)
        let targetLang = languageCode(for: targetLanguage)

        // URL 인코딩
        guard let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw TranslationError.encodingFailed
        }

        // MyMemory Translation API 사용 (무료, API 키 불필요)
        let urlString = "https://api.mymemory.translated.net/get?q=\(encodedText)&langpair=\(sourceLang)|\(targetLang)"

        guard let url = URL(string: urlString) else {
            throw TranslationError.invalidURL
        }

        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")

        print("🌐 [TRANSLATION] MyMemory API 호출: \(text)")
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw TranslationError.networkError
        }

        // JSON 파싱 (UTF-8 디코딩)
        guard let jsonString = String(data: data, encoding: .utf8),
              let jsonData = jsonString.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let responseData = json["responseData"] as? [String: Any],
              var translatedText = responseData["translatedText"] as? String else {
            throw TranslationError.parsingFailed
        }

        // HTML 엔티티 디코딩
        translatedText = decodeHTMLEntities(translatedText)

        print("✅ [TRANSLATION] MyMemory API 성공: \(translatedText)")
        return translatedText
    }

    // HTML 엔티티 디코딩 함수
    private func decodeHTMLEntities(_ text: String) -> String {
        var result = text

        // 일반적인 HTML 엔티티 치환
        let entities = [
            "&quot;": "\"",
            "&apos;": "'",
            "&#39;": "'",
            "&lt;": "<",
            "&gt;": ">",
            "&amp;": "&",
            "&#34;": "\"",
            "&#60;": "<",
            "&#62;": ">"
        ]

        for (entity, character) in entities {
            result = result.replacingOccurrences(of: entity, with: character)
        }

        // 숫자형 엔티티 디코딩 (&#xxxx; 형태)
        let pattern = "&#(\\d+);"
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let nsString = result as NSString
            let matches = regex.matches(in: result, range: NSRange(location: 0, length: nsString.length))

            for match in matches.reversed() {
                if let range = Range(match.range, in: result),
                   let numberRange = Range(match.range(at: 1), in: result),
                   let code = Int(result[numberRange]),
                   let scalar = UnicodeScalar(code) {
                    result.replaceSubrange(range, with: String(Character(scalar)))
                }
            }
        }

        return result
    }

    enum TranslationError: LocalizedError {
        case encodingFailed
        case invalidURL
        case networkError
        case parsingFailed
        case sessionNotFound
        case languageNotSupported

        var errorDescription: String? {
            switch self {
            case .encodingFailed:
                return "텍스트 인코딩에 실패했습니다."
            case .invalidURL:
                return "잘못된 URL입니다."
            case .networkError:
                return "네트워크 오류가 발생했습니다."
            case .parsingFailed:
                return "번역 결과를 처리하는데 실패했습니다."
            case .sessionNotFound:
                return "번역 세션을 찾을 수 없습니다."
            case .languageNotSupported:
                return "지원하지 않는 언어 쌍입니다."
            }
        }
    }
}
