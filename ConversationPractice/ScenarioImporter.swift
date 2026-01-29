import Foundation

// MARK: - JSON 포맷 정의 (GPT가 생성할 형식)
struct ScenarioJSON: Codable {
    let title: String
    let description: String
    let icon: String
    let turns: [TurnJSON]

    struct TurnJSON: Codable {
        let speaker: String  // "user" or "ai"
        let options: [OptionJSON]

        struct OptionJSON: Codable {
            let native: String
            let learning: String
        }
    }
}

// MARK: - 시나리오 임포터
class ScenarioImporter {

    // JSON을 TurnData로 변환
    static func importFromJSON(
        _ jsonString: String,
        nativeLanguage: Language,
        learningLanguage: Language
    ) throws -> (title: String, description: String, icon: String, turns: [TurnData]) {

        // 마크다운 코드 블록 제거 및 JSON 정리
        let cleanedJSON = cleanJSONString(jsonString)

        guard let jsonData = cleanedJSON.data(using: .utf8) else {
            throw ImportError.invalidJSON
        }

        let decoder = JSONDecoder()
        let scenarioJSON = try decoder.decode(ScenarioJSON.self, from: jsonData)

        // Validation
        if scenarioJSON.title.isEmpty {
            throw ImportError.missingTitle
        }

        if scenarioJSON.turns.isEmpty {
            throw ImportError.noTurns
        }

        // TurnJSON -> TurnData 변환
        let turns = try scenarioJSON.turns.map { turnJSON -> TurnData in
            guard let speaker = parseSpeaker(turnJSON.speaker) else {
                throw ImportError.invalidSpeaker(turnJSON.speaker)
            }

            if turnJSON.options.isEmpty {
                throw ImportError.emptyOptions
            }

            let options = turnJSON.options.map { optionJSON in
                TurnOption(
                    nativeText: optionJSON.native,
                    learningText: optionJSON.learning
                )
            }

            return TurnData(
                speaker: speaker,
                options: options
            )
        }

        return (
            title: scenarioJSON.title,
            description: scenarioJSON.description,
            icon: scenarioJSON.icon.isEmpty ? "💬" : scenarioJSON.icon,
            turns: turns
        )
    }

    // GPT용 프롬프트 생성
    static func generatePrompt(
        situation: String,
        nativeLanguage: Language,
        learningLanguage: Language,
        numberOfTurns: Int = 6
    ) -> String {
        let nativeName = nativeLanguage.displayName
        let learningName = learningLanguage.displayName

        return """
        Create a conversation practice scenario for the following situation:
        Situation: \(situation)

        Generate a realistic conversation with \(numberOfTurns) turns (alternating between user and AI).
        Each turn should have 2-3 alternative options that a person might say in that situation.

        Native language: \(nativeName)
        Learning language: \(learningName)

        ⚠️ CRITICAL JSON FORMAT REQUIREMENTS ⚠️
        Your response MUST be VALID JSON that can be parsed by JSON.parse():

        1. ❌ NO markdown code blocks (```json```)
        2. ❌ NO comments (// or /* */)
        3. ❌ NO trailing commas
        4. ✅ ONLY double quotes " (NOT single quotes ')
        5. ✅ Properly escape special characters (", \\, newlines)
        6. ✅ Start with { and end with }
        7. ✅ All strings must be properly quoted
        8. ❌ NO text before or after the JSON

        Your FIRST character must be { and LAST character must be }

        JSON format:
        {
          "title": "scenario title in \(nativeName)",
          "description": "brief description in \(nativeName)",
          "icon": "appropriate emoji (single emoji)",
          "turns": [
            {
              "speaker": "user",
              "options": [
                {
                  "native": "text in \(nativeName)",
                  "learning": "text in \(learningName)"
                },
                {
                  "native": "alternative text in \(nativeName)",
                  "learning": "alternative text in \(learningName)"
                }
              ]
            },
            {
              "speaker": "ai",
              "options": [
                {
                  "native": "response in \(nativeName)",
                  "learning": "response in \(learningName)"
                }
              ]
            }
          ]
        }

        Requirements:
        - Start with "user" turn, then alternate between "user" and "ai"
        - Each turn must have at least 1 option, ideally 2-3 options
        - Make the conversation natural and realistic
        - Use appropriate casual/formal language based on the situation

        ⚠️ JSON VALIDATION CHECK ⚠️
        Before responding, verify your JSON:
        - Can it be parsed by JSON.parse()? ✅
        - Does it start with { and end with }? ✅
        - Are all strings in double quotes "? ✅
        - No trailing commas? ✅
        - No markdown or comments? ✅

        REMEMBER: Output ONLY valid, parseable JSON. Nothing else.
        Test your JSON before sending. It MUST be valid JSON format.
        Your first character must be { and your last character must be }
        """
    }

    // JSON 문자열에서 마크다운 코드 블록 및 불필요한 텍스트 제거 + 포맷 수정
    private static func cleanJSONString(_ input: String) -> String {
        var cleaned = input.trimmingCharacters(in: .whitespacesAndNewlines)

        // 0. 스마트 따옴표를 일반 따옴표로 변환 (노션, 메모 앱 등에서 복사한 경우)
        // " " → " (curly double quotes to straight quotes)
        cleaned = cleaned.replacingOccurrences(of: "\u{201C}", with: "\"")  // "
        cleaned = cleaned.replacingOccurrences(of: "\u{201D}", with: "\"")  // "
        // ' ' → ' (curly single quotes to straight quotes)
        cleaned = cleaned.replacingOccurrences(of: "\u{2018}", with: "'")   // '
        cleaned = cleaned.replacingOccurrences(of: "\u{2019}", with: "'")

        // 1. 마크다운 코드 블록 제거 (```json ... ``` 또는 ``` ... ```)
        if cleaned.hasPrefix("```") {
            // 첫 번째 줄 제거
            if let firstNewline = cleaned.firstIndex(of: "\n") {
                cleaned = String(cleaned[cleaned.index(after: firstNewline)...])
            }
            // 마지막 ``` 제거
            if cleaned.hasSuffix("```") {
                cleaned = String(cleaned.dropLast(3))
            }
            cleaned = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        // 2. JSON이 아닌 텍스트가 앞에 있으면 제거 (첫 { 찾기)
        if let firstBrace = cleaned.firstIndex(of: "{") {
            cleaned = String(cleaned[firstBrace...])
        }

        // 3. JSON이 아닌 텍스트가 뒤에 있으면 제거 (마지막 } 찾기)
        if let lastBrace = cleaned.lastIndex(of: "}") {
            cleaned = String(cleaned[...lastBrace])
        }

        // 4. 단일 따옴표를 이중 따옴표로 변경 (주의: 문자열 내부 따옴표는 제외)
        // JSON 표준은 이중 따옴표만 허용
        cleaned = cleaned.replacingOccurrences(of: "': '", with: "\": \"")
        cleaned = cleaned.replacingOccurrences(of: "':'", with: "\":\"")
        cleaned = cleaned.replacingOccurrences(of: "',", with: "\",")
        cleaned = cleaned.replacingOccurrences(of: "'}", with: "\"}")
        cleaned = cleaned.replacingOccurrences(of: "{'", with: "{\"")
        cleaned = cleaned.replacingOccurrences(of: "['", with: "[\"")
        cleaned = cleaned.replacingOccurrences(of: "']", with: "\"]")

        // 5. 불필요한 trailing comma 제거 (JSON 표준 위반)
        // 배열이나 객체 끝의 쉼표 제거: ,] 또는 ,}
        cleaned = cleaned.replacingOccurrences(of: ",]", with: "]")
        cleaned = cleaned.replacingOccurrences(of: ",}", with: "}")
        cleaned = cleaned.replacingOccurrences(of: ", ]", with: "]")
        cleaned = cleaned.replacingOccurrences(of: ", }", with: "}")

        // 6. 줄바꿈 문자 정리 (JSON 문자열 내부의 실제 줄바꿈)
        // 문자열 안의 줄바꿈은 \n으로 이스케이프되어야 함
        // 단, 이미 이스케이프된 \n은 그대로 유지
        cleaned = fixNewlinesInJSON(cleaned)

        // 7. 이중 쉼표 제거 (,, → ,)
        while cleaned.contains(",,") {
            cleaned = cleaned.replacingOccurrences(of: ",,", with: ",")
        }

        // 8. JSON 주석 제거 (// ... 또는 /* ... */)
        cleaned = removeJSONComments(cleaned)

        // 9. 불필요한 공백 정리
        cleaned = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)

        return cleaned
    }

    // JSON 문자열 내부의 줄바꿈을 올바르게 이스케이프
    private static func fixNewlinesInJSON(_ json: String) -> String {
        var result = ""
        var inString = false
        var previousChar: Character? = nil
        var escaping = false

        for char in json {
            if escaping {
                // 이미 이스케이프 중이면 그대로 추가
                result.append(char)
                escaping = false
                previousChar = char
                continue
            }

            if char == "\\" {
                escaping = true
                result.append(char)
                previousChar = char
                continue
            }

            if char == "\"" && previousChar != "\\" {
                inString.toggle()
                result.append(char)
                previousChar = char
                continue
            }

            // 문자열 안에서 실제 줄바꿈을 만나면 \n으로 변경
            if inString && (char == "\n" || char == "\r") {
                result.append("\\n")
            } else {
                result.append(char)
            }

            previousChar = char
        }

        return result
    }

    // JSON 주석 제거
    private static func removeJSONComments(_ json: String) -> String {
        var result = ""
        var inString = false
        var previousChar: Character? = nil
        var i = json.startIndex

        while i < json.endIndex {
            let char = json[i]

            // 문자열 안인지 확인
            if char == "\"" && previousChar != "\\" {
                inString.toggle()
                result.append(char)
                previousChar = char
                i = json.index(after: i)
                continue
            }

            // 문자열 밖에서 주석 처리
            if !inString {
                // 한 줄 주석 (//)
                if char == "/" && i < json.index(before: json.endIndex) {
                    let nextIndex = json.index(after: i)
                    if json[nextIndex] == "/" {
                        // 줄 끝까지 건너뛰기
                        while i < json.endIndex && json[i] != "\n" {
                            i = json.index(after: i)
                        }
                        continue
                    }
                    // 블록 주석 (/* */)
                    if json[nextIndex] == "*" {
                        // */ 찾을 때까지 건너뛰기
                        i = json.index(after: nextIndex)
                        while i < json.index(before: json.endIndex) {
                            if json[i] == "*" && json[json.index(after: i)] == "/" {
                                i = json.index(after: json.index(after: i))
                                break
                            }
                            i = json.index(after: i)
                        }
                        continue
                    }
                }
            }

            result.append(char)
            previousChar = char
            i = json.index(after: i)
        }

        return result
    }

    private static func parseSpeaker(_ speaker: String) -> ConversationTurn.TurnSpeaker? {
        switch speaker.lowercased() {
        case "user":
            return .user
        case "ai", "assistant", "native":
            return .ai
        default:
            return nil
        }
    }

    enum ImportError: LocalizedError {
        case invalidJSON
        case missingTitle
        case noTurns
        case emptyOptions
        case invalidSpeaker(String)

        var errorDescription: String? {
            switch self {
            case .invalidJSON:
                return "Invalid JSON format"
            case .missingTitle:
                return "Title is required"
            case .noTurns:
                return "At least one conversation turn is required"
            case .emptyOptions:
                return "Each turn must have at least one option"
            case .invalidSpeaker(let speaker):
                return "Invalid speaker type: \(speaker). Must be 'user' or 'ai'"
            }
        }
    }
}
