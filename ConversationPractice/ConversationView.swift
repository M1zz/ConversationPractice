import SwiftUI
import AVFoundation
import Speech

struct ConversationView: View {
    let scenario: Scenario
    let nativeLanguage: Language
    let learningLanguage: Language

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    @State private var conversationHistory: [ConversationNode] = []
    @State private var currentResponses: [ConversationNode]? = nil
    @State private var currentUserPhrase: ConversationNode? = nil
    @State private var isConversationStarted = false
    @State private var isConversationEnded = false
    @State private var showTranslation = true  // 기본적으로 번역 표시

    // 음성 관련
    @State private var isRecording = false
    @State private var recognizedText = ""
    @State private var recognitionStatus: RecognitionStatus = .idle
    @StateObject private var speechRecognizer = SpeechRecognizer()
    private let synthesizer = AVSpeechSynthesizer()

    @Environment(\.dismiss) private var dismiss

    enum RecognitionStatus {
        case idle
        case listening
        case success
        case failed
    }

    var body: some View {
        VStack(spacing: 0) {
            // 대화 내용
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        // 시나리오 설명 (모국어로 표시)
                        VStack(spacing: 8) {
                            Text(scenario.icon)
                                .font(.system(size: 50))
                            Text(scenario.getTitle(for: nativeLanguage))
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(scenario.getDescription(for: nativeLanguage))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 20)

                        // 대화 기록
                        ForEach(Array(conversationHistory.enumerated()), id: \.element.id) { index, node in
                            MessageBubble(
                                node: node,
                                showTranslation: showTranslation,
                                nativeLanguage: nativeLanguage,
                                localizedText: localizedText
                            )
                            .id(node.id)
                        }

                        // 대화 종료 메시지
                        if isConversationEnded {
                            VStack(spacing: 12) {
                                Text(completionMessage)
                                    .font(.headline)

                                Button(action: resetConversation) {
                                    Label(retryMessage, systemImage: "arrow.counterclockwise")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.top, 20)
                        }
                    }
                    .padding()
                }
                .onChange(of: conversationHistory.count) { _ in
                    if let lastNode = conversationHistory.last {
                        withAnimation {
                            proxy.scrollTo(lastNode.id, anchor: .bottom)
                        }
                    }
                }
            }

            Divider()

            // 하단 컨트롤
            VStack(spacing: 12) {
                // 번역 토글
                Toggle(isOn: $showTranslation) {
                    Label(showTranslationLabel, systemImage: "globe")
                        .font(.subheadline)
                }
                .padding(.horizontal)

                // 음성 입력 UI
                if !isConversationEnded {
                    VoiceInputSection(
                        isConversationStarted: isConversationStarted,
                        currentPhrase: currentUserPhrase?.text ?? scenario.startingPhrase,
                        currentTranslation: currentUserPhrase?.translation(for: nativeLanguage) ?? scenario.getStartingPhraseTranslation(for: nativeLanguage),
                        isRecording: isRecording,
                        recognizedText: recognizedText,
                        recognitionStatus: recognitionStatus,
                        showTranslation: showTranslation,
                        localizedText: localizedText,
                        onRecordTap: toggleRecording
                    )
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: resetConversation) {
                    Image(systemName: "arrow.counterclockwise")
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

    // MARK: - Localized Strings

    private var completionMessage: String {
        switch nativeLanguage {
        case .korean: return "🎉 대화 완료!"
        case .english: return "🎉 Conversation Complete!"
        case .japanese: return "🎉 会話完了!"
        case .chinese: return "🎉 对话完成!"
        case .spanish: return "🎉 ¡Conversación completada!"
        case .indonesian: return "🎉 Percakapan Selesai!"
        }
    }

    private var retryMessage: String {
        switch nativeLanguage {
        case .korean: return "다시 연습하기"
        case .english: return "Practice Again"
        case .japanese: return "もう一度練習"
        case .chinese: return "再练习一次"
        case .spanish: return "Practicar de nuevo"
        case .indonesian: return "Latihan Lagi"
        }
    }

    private var showTranslationLabel: String {
        switch nativeLanguage {
        case .korean: return "번역 보기"
        case .english: return "Show Translation"
        case .japanese: return "翻訳を表示"
        case .chinese: return "显示翻译"
        case .spanish: return "Mostrar traducción"
        case .indonesian: return "Tampilkan Terjemahan"
        }
    }

    // MARK: - Actions

    private func toggleRecording() {
        if isRecording {
            // 녹음 중지
            speechRecognizer.stopRecording()
            isRecording = false

            // 인식 결과 확인
            let targetPhrase = currentUserPhrase?.text ?? scenario.startingPhrase
            if isMatchingPhrase(recognized: recognizedText, target: targetPhrase) {
                recognitionStatus = .success
                // 성공 시 대화 진행
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    proceedConversation()
                }
            } else {
                recognitionStatus = .failed
                // 실패 시 다시 시도할 수 있도록
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    recognitionStatus = .idle
                    recognizedText = ""
                }
            }
        } else {
            // 녹음 시작
            recognizedText = ""
            recognitionStatus = .listening
            isRecording = true
            speechRecognizer.startRecording(language: learningLanguage.rawValue) { text in
                recognizedText = text
            }
        }
    }

    private func isMatchingPhrase(recognized: String, target: String) -> Bool {
        // 간단한 유사도 검사 (정규화 후 비교)
        let normalizedRecognized = recognized.lowercased()
            .replacingOccurrences(of: "?", with: "")
            .replacingOccurrences(of: "!", with: "")
            .replacingOccurrences(of: ".", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let normalizedTarget = target.lowercased()
            .replacingOccurrences(of: "?", with: "")
            .replacingOccurrences(of: "!", with: "")
            .replacingOccurrences(of: ".", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        // 완전 일치 또는 포함 관계 확인
        if normalizedRecognized == normalizedTarget {
            return true
        }

        // 70% 이상 일치하면 성공으로 처리
        let similarity = calculateSimilarity(normalizedRecognized, normalizedTarget)
        return similarity >= 0.7
    }

    private func calculateSimilarity(_ str1: String, _ str2: String) -> Double {
        let set1 = Set(str1.components(separatedBy: " "))
        let set2 = Set(str2.components(separatedBy: " "))

        let intersection = set1.intersection(set2).count
        let union = set1.union(set2).count

        return union > 0 ? Double(intersection) / Double(union) : 0
    }

    private func proceedConversation() {
        if !isConversationStarted {
            // 첫 대화 시작
            isConversationStarted = true

            let userStart = ConversationNode(
                id: "user-start",
                speaker: .user,
                text: scenario.startingPhrase,
                translations: scenario.startingPhraseTranslations,
                responses: nil
            )
            conversationHistory.append(userStart)

            // AI 응답
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let randomResponse = scenario.conversationTree.randomElement() {
                    conversationHistory.append(randomResponse)
                    speak(text: randomResponse.text)
                    currentResponses = randomResponse.responses

                    if let firstUserResponse = randomResponse.responses?.first {
                        currentUserPhrase = firstUserResponse
                    } else {
                        isConversationEnded = true
                    }
                }
                recognitionStatus = .idle
                recognizedText = ""
            }
        } else if let userPhrase = currentUserPhrase {
            // 사용자 응답 추가
            conversationHistory.append(userPhrase)

            // 다음 AI 응답
            if let nextResponses = userPhrase.responses, let nextNative = nextResponses.first {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    conversationHistory.append(nextNative)
                    speak(text: nextNative.text)
                    currentResponses = nextNative.responses

                    if let nextUserPhrase = nextNative.responses?.first {
                        currentUserPhrase = nextUserPhrase
                    } else {
                        isConversationEnded = true
                        currentUserPhrase = nil
                    }
                    recognitionStatus = .idle
                    recognizedText = ""
                }
            } else {
                isConversationEnded = true
                currentUserPhrase = nil
                recognitionStatus = .idle
                recognizedText = ""
            }
        }
    }

    private func resetConversation() {
        conversationHistory = []
        currentResponses = nil
        currentUserPhrase = nil
        isConversationStarted = false
        isConversationEnded = false
        recognizedText = ""
        recognitionStatus = .idle
    }

    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: learningLanguage.rawValue)
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
}

// MARK: - 음성 입력 섹션
struct VoiceInputSection: View {
    let isConversationStarted: Bool
    let currentPhrase: String           // 학습 언어 문장 (말해야 할 것)
    let currentTranslation: String?     // 모국어 번역
    let isRecording: Bool
    let recognizedText: String
    let recognitionStatus: ConversationView.RecognitionStatus
    let showTranslation: Bool
    let localizedText: LocalizedText
    let onRecordTap: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // 말해야 할 문장 표시
            VStack(spacing: 8) {
                Text(sayThisLabel)
                    .font(.caption)
                    .foregroundColor(.secondary)

                // 학습 언어 문장 (크게 표시) - 이것을 말해야 함
                Text(currentPhrase)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)

                // 모국어 번역 (항상 표시) - 이해를 돕기 위해
                if let translation = currentTranslation {
                    Text(translation)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(12)

            // 인식된 텍스트 표시
            if !recognizedText.isEmpty {
                HStack {
                    statusIcon
                    Text(recognizedText)
                        .font(.subheadline)
                        .foregroundColor(statusColor)
                }
                .padding(.horizontal)
            }

            // 녹음 버튼
            Button(action: onRecordTap) {
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

            Text(statusMessage)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    private var sayThisLabel: String {
        switch localizedText.nativeLanguage {
        case .korean: return "이 문장을 말하세요:"
        case .english: return "Say this phrase:"
        case .japanese: return "このフレーズを言ってください:"
        case .chinese: return "请说这句话:"
        case .spanish: return "Di esta frase:"
        case .indonesian: return "Ucapkan kalimat ini:"
        }
    }

    private var statusMessage: String {
        switch recognitionStatus {
        case .idle:
            return localizedText.tapToSpeak
        case .listening:
            return localizedText.speaking
        case .success:
            switch localizedText.nativeLanguage {
            case .korean: return "잘했습니다! ✓"
            case .english: return "Great job! ✓"
            case .japanese: return "よくできました! ✓"
            case .chinese: return "做得好! ✓"
            case .spanish: return "¡Bien hecho! ✓"
            case .indonesian: return "Bagus sekali! ✓"
            }
        case .failed:
            switch localizedText.nativeLanguage {
            case .korean: return "다시 시도해보세요"
            case .english: return "Try again"
            case .japanese: return "もう一度試してください"
            case .chinese: return "请再试一次"
            case .spanish: return "Inténtalo de nuevo"
            case .indonesian: return "Coba lagi"
            }
        }
    }

    private var statusColor: Color {
        switch recognitionStatus {
        case .idle, .listening: return .primary
        case .success: return .green
        case .failed: return .red
        }
    }

    @ViewBuilder
    private var statusIcon: some View {
        switch recognitionStatus {
        case .success:
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
        case .failed:
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red)
        default:
            EmptyView()
        }
    }
}

// MARK: - 메시지 버블
struct MessageBubble: View {
    let node: ConversationNode
    let showTranslation: Bool
    let nativeLanguage: Language
    let localizedText: LocalizedText

    var isUser: Bool {
        node.speaker == .user
    }

    var body: some View {
        HStack {
            if isUser { Spacer() }

            VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                // 스피커 라벨
                Text(isUser ? localizedText.me : partnerLabel)
                    .font(.caption2)
                    .foregroundColor(.secondary)

                // 메시지 내용
                VStack(alignment: .leading, spacing: 4) {
                    // 학습 언어 텍스트
                    Text(node.text)
                        .font(.body)

                    // 모국어 번역
                    if showTranslation, let translation = node.translation(for: nativeLanguage) {
                        Text(translation)
                            .font(.caption)
                            .foregroundColor(isUser ? .white.opacity(0.8) : .secondary)
                    }
                }
                .padding(12)
                .background(isUser ? Color.blue : Color(.systemGray5))
                .foregroundColor(isUser ? .white : .primary)
                .cornerRadius(16)
            }

            if !isUser { Spacer() }
        }
    }

    private var partnerLabel: String {
        switch localizedText.nativeLanguage {
        case .korean: return "상대방"
        case .english: return "Partner"
        case .japanese: return "相手"
        case .chinese: return "对方"
        case .spanish: return "Compañero"
        case .indonesian: return "Lawan bicara"
        }
    }
}

#Preview {
    NavigationView {
        ConversationView(
            scenario: ScenarioData.scenarios(for: .indonesian)[0],
            nativeLanguage: .korean,
            learningLanguage: .indonesian
        )
    }
}
