import SwiftUI
import Speech
import AVFoundation

struct FreeConversationView: View {
    let nativeLanguage: Language
    let learningLanguage: Language

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    @State private var conversationHistory: [ChatMessage] = []
    @State private var isRecording = false
    @State private var recognizedText = ""
    @State private var isWaitingForResponse = false
    @State private var showTranslation = true

    @StateObject private var speechRecognizer = SpeechRecognizer()
    private let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack(spacing: 0) {
            // 대화 내용
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        // 안내 메시지
                        if conversationHistory.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "mic.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.blue.opacity(0.5))

                                Text(localizedText.startConversationGuide)
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                        }

                        // 대화 기록
                        ForEach(conversationHistory) { message in
                            ChatBubble(
                                message: message,
                                showTranslation: showTranslation,
                                localizedText: localizedText,
                                onTap: {
                                    speak(text: message.text)
                                }
                            )
                            .id(message.id)
                        }

                        // 현재 인식 중인 텍스트
                        if isRecording && !recognizedText.isEmpty {
                            HStack {
                                Spacer()
                                Text(recognizedText)
                                    .padding(12)
                                    .background(Color.blue.opacity(0.3))
                                    .foregroundColor(.primary)
                                    .cornerRadius(16)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                .onChange(of: conversationHistory.count) { _ in
                    if let lastMessage = conversationHistory.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }

            Divider()

            // 하단 녹음 버튼
            VStack(spacing: 12) {
                if isWaitingForResponse {
                    ProgressView()
                        .padding()
                } else {
                    RecordButton(isRecording: isRecording) {
                        toggleRecording()
                    }
                }

                Text(isRecording ? localizedText.speaking : localizedText.tapToSpeak)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemBackground))
        }
        .navigationTitle("\(learningLanguage.flag) \(localizedText.freeConversation)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showTranslation.toggle()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: showTranslation ? "eye.fill" : "eye.slash.fill")
                        Text(showTranslation ? translationOnLabel : translationOffLabel)
                            .font(.caption)
                    }
                    .foregroundColor(showTranslation ? .blue : .gray)
                }
            }
        }
        .onAppear {
            speechRecognizer.requestAuthorization()
        }
        .onDisappear {
            speechRecognizer.stopRecording()
            synthesizer.stopSpeaking(at: .immediate)
        }
    }

    private var translationOnLabel: String {
        switch nativeLanguage {
        case .korean: return "번역"
        case .english: return "Translation"
        case .japanese: return "翻訳"
        case .chinese: return "翻译"
        case .spanish: return "Traducción"
        case .indonesian: return "Terjemahan"
        }
    }

    private var translationOffLabel: String {
        switch nativeLanguage {
        case .korean: return "번역 끄기"
        case .english: return "Off"
        case .japanese: return "オフ"
        case .chinese: return "关闭"
        case .spanish: return "Apagado"
        case .indonesian: return "Matikan"
        }
    }

    private func toggleRecording() {
        if isRecording {
            // 녹음 중지
            speechRecognizer.stopRecording()
            isRecording = false

            // 인식된 텍스트가 있으면 대화에 추가
            if !recognizedText.isEmpty {
                let userMessage = ChatMessage(
                    speaker: .user,
                    text: recognizedText,
                    translation: nil  // 사용자 메시지는 번역 없음
                )
                conversationHistory.append(userMessage)

                // AI 응답 생성
                generateResponse(to: recognizedText)
            }
            recognizedText = ""
        } else {
            // 녹음 시작 - 학습 언어로 인식
            recognizedText = ""
            isRecording = true
            speechRecognizer.startRecording(language: learningLanguage.rawValue) { text in
                recognizedText = text
            }
        }
    }

    private func generateResponse(to userText: String) {
        isWaitingForResponse = true

        // 간단한 응답 생성 (추후 AI API 연동 가능)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let responses = getSimpleResponses(for: learningLanguage, nativeLanguage: nativeLanguage)
            let response = responses.randomElement() ?? ResponseWithTranslation(text: "...", translation: "...")

            let aiMessage = ChatMessage(
                speaker: .ai,
                text: response.text,
                translation: response.translation
            )
            conversationHistory.append(aiMessage)
            speak(text: response.text)
            isWaitingForResponse = false
        }
    }

    struct ResponseWithTranslation {
        let text: String
        let translation: String
    }

    private func getSimpleResponses(for language: Language, nativeLanguage: Language) -> [ResponseWithTranslation] {
        switch language {
        case .korean:
            return getKoreanResponses(nativeLanguage: nativeLanguage)
        case .english:
            return getEnglishResponses(nativeLanguage: nativeLanguage)
        case .japanese:
            return getJapaneseResponses(nativeLanguage: nativeLanguage)
        case .chinese:
            return getChineseResponses(nativeLanguage: nativeLanguage)
        case .spanish:
            return getSpanishResponses(nativeLanguage: nativeLanguage)
        case .indonesian:
            return getIndonesianResponses(nativeLanguage: nativeLanguage)
        }
    }

    private func getIndonesianResponses(nativeLanguage: Language) -> [ResponseWithTranslation] {
        let translations: [String] = {
            switch nativeLanguage {
            case .korean: return ["알겠습니다.", "정말 흥미롭네요!", "계속 말씀해주세요.", "좋아요.", "더 설명해주실 수 있나요?"]
            case .english: return ["I understand.", "Very interesting!", "Please continue.", "Good.", "Can you explain more?"]
            case .japanese: return ["わかりました。", "とても面白いですね！", "続けてください。", "いいですね。", "もっと説明していただけますか？"]
            case .chinese: return ["我明白了。", "非常有趣！", "请继续。", "好的。", "能多解释一下吗？"]
            case .spanish: return ["Entiendo.", "¡Muy interesante!", "Por favor continúa.", "Bien.", "¿Puedes explicar más?"]
            case .indonesian: return ["Saya mengerti.", "Menarik sekali!", "Silakan lanjutkan.", "Baik.", "Bisa jelaskan lebih lanjut?"]
            }
        }()

        return [
            ResponseWithTranslation(text: "Saya mengerti.", translation: translations[0]),
            ResponseWithTranslation(text: "Menarik sekali!", translation: translations[1]),
            ResponseWithTranslation(text: "Silakan lanjutkan.", translation: translations[2]),
            ResponseWithTranslation(text: "Baik.", translation: translations[3]),
            ResponseWithTranslation(text: "Bisa jelaskan lebih lanjut?", translation: translations[4])
        ]
    }

    private func getKoreanResponses(nativeLanguage: Language) -> [ResponseWithTranslation] {
        return [
            ResponseWithTranslation(text: "네, 알겠습니다.", translation: "Yes, I understand."),
            ResponseWithTranslation(text: "그렇군요! 더 말씀해 주세요.", translation: "I see! Please tell me more."),
            ResponseWithTranslation(text: "흥미롭네요.", translation: "That's interesting."),
            ResponseWithTranslation(text: "좋은 생각이에요.", translation: "That's a good idea."),
            ResponseWithTranslation(text: "조금 더 설명해 주실 수 있나요?", translation: "Could you explain a bit more?")
        ]
    }

    private func getEnglishResponses(nativeLanguage: Language) -> [ResponseWithTranslation] {
        return [
            ResponseWithTranslation(text: "I see, that's interesting.", translation: "알겠어요, 흥미롭네요."),
            ResponseWithTranslation(text: "Could you tell me more?", translation: "더 말씀해주실 수 있나요?"),
            ResponseWithTranslation(text: "That sounds great!", translation: "좋아 들리네요!"),
            ResponseWithTranslation(text: "I understand.", translation: "이해했어요."),
            ResponseWithTranslation(text: "Please continue.", translation: "계속해주세요.")
        ]
    }

    private func getJapaneseResponses(nativeLanguage: Language) -> [ResponseWithTranslation] {
        return [
            ResponseWithTranslation(text: "なるほど、面白いですね。", translation: "I see, that's interesting."),
            ResponseWithTranslation(text: "もう少し教えてください。", translation: "Please tell me a bit more."),
            ResponseWithTranslation(text: "いいですね！", translation: "That's good!"),
            ResponseWithTranslation(text: "わかりました。", translation: "I understand."),
            ResponseWithTranslation(text: "続けてください。", translation: "Please continue.")
        ]
    }

    private func getChineseResponses(nativeLanguage: Language) -> [ResponseWithTranslation] {
        return [
            ResponseWithTranslation(text: "我明白了。", translation: "I understand."),
            ResponseWithTranslation(text: "请继续说。", translation: "Please continue."),
            ResponseWithTranslation(text: "很有趣！", translation: "Very interesting!"),
            ResponseWithTranslation(text: "好的。", translation: "Okay."),
            ResponseWithTranslation(text: "能再解释一下吗？", translation: "Can you explain again?")
        ]
    }

    private func getSpanishResponses(nativeLanguage: Language) -> [ResponseWithTranslation] {
        return [
            ResponseWithTranslation(text: "Entiendo.", translation: "I understand."),
            ResponseWithTranslation(text: "¡Qué interesante!", translation: "How interesting!"),
            ResponseWithTranslation(text: "Por favor, continúa.", translation: "Please continue."),
            ResponseWithTranslation(text: "Muy bien.", translation: "Very good."),
            ResponseWithTranslation(text: "¿Puedes explicar más?", translation: "Can you explain more?")
        ]
    }

    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: learningLanguage.rawValue)
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
}

// MARK: - 채팅 메시지 모델
struct ChatMessage: Identifiable {
    let id = UUID()
    let speaker: ChatSpeaker
    let text: String
    let translation: String?

    enum ChatSpeaker {
        case user
        case ai
    }
}

// MARK: - 채팅 버블
struct ChatBubble: View {
    let message: ChatMessage
    let showTranslation: Bool
    let localizedText: LocalizedText
    let onTap: () -> Void

    var isUser: Bool {
        message.speaker == .user
    }

    var body: some View {
        HStack {
            if isUser { Spacer() }

            VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                Text(isUser ? localizedText.me : "AI")
                    .font(.caption2)
                    .foregroundColor(.secondary)

                VStack(alignment: .leading, spacing: 4) {
                    Text(message.text)
                        .font(.body)

                    // 번역 표시
                    if showTranslation, let translation = message.translation {
                        Text(translation)
                            .font(.caption)
                            .foregroundColor(isUser ? .white.opacity(0.8) : .secondary)
                    }
                }
                .padding(12)
                .background(isUser ? Color.blue : Color(.systemGray5))
                .foregroundColor(isUser ? .white : .primary)
                .cornerRadius(16)
                .onTapGesture {
                    onTap()
                }
            }

            if !isUser { Spacer() }
        }
    }
}

// MARK: - 녹음 버튼
struct RecordButton: View {
    let isRecording: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(isRecording ? Color.red : Color.blue)
                    .frame(width: 70, height: 70)

                Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
            }
        }
        .scaleEffect(isRecording ? 1.1 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isRecording)
    }
}

// MARK: - 음성 인식 클래스
class SpeechRecognizer: ObservableObject {
    private var audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var speechRecognizer: SFSpeechRecognizer?

    @Published var isAuthorized = false

    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                self.isAuthorized = (status == .authorized)
            }
        }
    }

    func startRecording(language: String, onResult: @escaping (String) -> Void) {
        // 이전 작업 정리
        stopRecording()

        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: language))

        let audioSession = AVAudioSession.sharedInstance()
        do {
            // playAndRecord 카테고리로 녹음과 재생을 모두 지원
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: [.defaultToSpeaker, .duckOthers])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("오디오 세션 설정 실패: \(error)")
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { return }

        recognitionRequest.shouldReportPartialResults = true

        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
        } catch {
            print("오디오 엔진 시작 실패: \(error)")
            return
        }

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    onResult(result.bestTranscription.formattedString)
                }
            }

            if error != nil || (result?.isFinal ?? false) {
                self.stopRecording()
            }
        }
    }

    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
    }
}

#Preview {
    NavigationView {
        FreeConversationView(nativeLanguage: .korean, learningLanguage: .english)
    }
}
