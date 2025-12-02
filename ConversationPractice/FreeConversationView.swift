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
                            ChatBubble(message: message, localizedText: localizedText)
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
        .onAppear {
            speechRecognizer.requestAuthorization()
        }
        .onDisappear {
            speechRecognizer.stopRecording()
            synthesizer.stopSpeaking(at: .immediate)
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
                    text: recognizedText
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
            let responses = getSimpleResponses(for: learningLanguage)
            let response = responses.randomElement() ?? "..."

            let aiMessage = ChatMessage(
                speaker: .ai,
                text: response
            )
            conversationHistory.append(aiMessage)
            speak(text: response)
            isWaitingForResponse = false
        }
    }

    private func getSimpleResponses(for language: Language) -> [String] {
        switch language {
        case .korean:
            return [
                "네, 알겠습니다.",
                "그렇군요! 더 말씀해 주세요.",
                "흥미롭네요.",
                "좋은 생각이에요.",
                "조금 더 설명해 주실 수 있나요?"
            ]
        case .english:
            return [
                "I see, that's interesting.",
                "Could you tell me more?",
                "That sounds great!",
                "I understand.",
                "Please continue."
            ]
        case .japanese:
            return [
                "なるほど、面白いですね。",
                "もう少し教えてください。",
                "いいですね！",
                "わかりました。",
                "続けてください。"
            ]
        case .chinese:
            return [
                "我明白了。",
                "请继续说。",
                "很有趣！",
                "好的。",
                "能再解释一下吗？"
            ]
        case .spanish:
            return [
                "Entiendo.",
                "¡Qué interesante!",
                "Por favor, continúa.",
                "Muy bien.",
                "¿Puedes explicar más?"
            ]
        case .indonesian:
            return [
                "Saya mengerti.",
                "Menarik sekali!",
                "Silakan lanjutkan.",
                "Baik.",
                "Bisa jelaskan lebih lanjut?"
            ]
        }
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

    enum ChatSpeaker {
        case user
        case ai
    }
}

// MARK: - 채팅 버블
struct ChatBubble: View {
    let message: ChatMessage
    let localizedText: LocalizedText

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

                Text(message.text)
                    .padding(12)
                    .background(isUser ? Color.blue : Color(.systemGray5))
                    .foregroundColor(isUser ? .white : .primary)
                    .cornerRadius(16)
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
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
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
