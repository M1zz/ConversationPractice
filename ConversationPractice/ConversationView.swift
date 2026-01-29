import SwiftUI
import AVFoundation
import Speech

// MARK: - Constants
private enum UIConstants {
    static let buttonSize: CGFloat = 70
    static let iconSize: CGFloat = 28
    static let maxBubbleWidth: CGFloat = 280
    static let profileIconSize: CGFloat = 36
    static let minimumSideSpacing: CGFloat = 60
    static let animationDuration: Double = 0.2
    static let speechDelay: Double = 0.5
    static let similarityThreshold: Double = 0.7
}

// 언어 표시 모드
enum LanguageDisplayMode: String {
    case native = "native"       // 모국어만
    case learning = "learning"   // 학습 언어만
    case both = "both"           // 둘 다
}

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
    @State private var displayMode: LanguageDisplayMode = .both  // 기본값: 둘 다 표시
    @State private var showingScriptViewer = false

    // 음성 관련
    @State private var isRecording = false
    @State private var recognizedText = ""
    @State private var recognitionStatus: RecognitionStatus = .idle
    @State private var isWaitingForConfirmation = false  // 사용자 확인 대기 상태
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @StateObject private var speechSynthesizer = SpeechSynthesizerWrapper()

    // 대화 기록 관리
    @StateObject private var historyManager = ConversationHistoryManager.shared

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
                    VStack(spacing: 0) {
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
                        .padding(.bottom, 8)

                        // 대화 기록
                        ForEach(Array(conversationHistory.enumerated()), id: \.element.id) { index, node in
                            MessageBubble(
                                node: node,
                                displayMode: displayMode,
                                nativeLanguage: nativeLanguage,
                                learningLanguage: learningLanguage,
                                localizedText: localizedText,
                                onTap: {
                                    speak(text: node.text)
                                }
                            )
                            .id(node.id)
                            .padding(.bottom, 12)
                        }

                        // 대화 종료 메시지
                        if isConversationEnded {
                            VStack(spacing: 12) {
                                Text(localizedText.conversationComplete)
                                    .font(.headline)

                                Button(action: resetConversation) {
                                    Label(localizedText.practiceAgain, systemImage: "arrow.counterclockwise")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.top, 20)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .background(Color(.systemGroupedBackground))
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
                // 음성 입력 UI
                if !isConversationEnded {
                    VoiceInputSection(
                        isConversationStarted: isConversationStarted,
                        currentPhrase: currentUserPhrase?.text ?? scenario.startingPhrase,
                        currentTranslation: currentUserPhrase?.translation(for: nativeLanguage) ?? scenario.getStartingPhraseTranslation(for: nativeLanguage),
                        isRecording: isRecording,
                        recognizedText: recognizedText,
                        recognitionStatus: recognitionStatus,
                        isWaitingForConfirmation: isWaitingForConfirmation,
                        isSpeaking: speechSynthesizer.isSpeaking,
                        displayMode: displayMode,
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
                HStack(spacing: 12) {
                    // Script viewer button
                    Button(action: { showingScriptViewer = true }) {
                        Image(systemName: "doc.text.magnifyingglass")
                    }

                    Button(action: cycleDisplayMode) {
                        HStack(spacing: 4) {
                            Image(systemName: displayModeIcon)
                            Text(getDisplayModeLabel())
                                .font(.caption)
                        }
                        .foregroundColor(.blue)
                    }

                    Button(action: resetConversation) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
            }
        }
        .onAppear {
            speechRecognizer.requestAuthorization()

            // 음성 재생 완료 후 자동으로 녹음 시작하도록 콜백 설정
            speechSynthesizer.onSpeechFinished = { [self] in
                // 아직 녹음 중이 아니고, 대화가 진행 중이며, 대화가 끝나지 않았을 때만 자동 시작
                if !isRecording && isConversationStarted && !isConversationEnded {
                    print("🎤 [AUTO-START] 음성 재생 완료 → 자동으로 녹음 시작")
                    toggleRecording()
                }
            }
        }
        .onChange(of: isConversationEnded) { _, newValue in
            if newValue && !conversationHistory.isEmpty {
                saveConversationHistory()
            }
        }
        .onDisappear {
            speechRecognizer.stopRecording()
            speechSynthesizer.stopSpeaking()
        }
        .sheet(isPresented: $showingScriptViewer) {
            ScriptViewerView(
                scenario: scenario,
                nativeLanguage: nativeLanguage,
                learningLanguage: learningLanguage
            )
        }
    }

    // MARK: - Localized Strings

    private var displayModeIcon: String {
        switch displayMode {
        case .native: return "textformat.abc"
        case .learning: return "character.book.closed"
        case .both: return "textformat.abc.dottedunderline"
        }
    }

    private func getDisplayModeLabel() -> String {
        switch displayMode {
        case .native: return localizedText.displayModeNative
        case .learning: return localizedText.displayModeLearning
        case .both: return localizedText.displayModeBoth
        }
    }

    // MARK: - Actions

    private func cycleDisplayMode() {
        switch displayMode {
        case .both:
            displayMode = .learning
        case .learning:
            displayMode = .native
        case .native:
            displayMode = .both
        }
    }

    private func toggleRecording() {
        print("🎤 [RECORDING] === toggleRecording 호출 ===")
        print("🎤 [RECORDING] isRecording: \(isRecording)")
        print("🎤 [RECORDING] isWaitingForConfirmation: \(isWaitingForConfirmation)")

        // 확인 대기 중이면 다음으로 진행
        if isWaitingForConfirmation {
            print("🎤 [RECORDING] 사용자 확인 → 다음으로 진행")
            isWaitingForConfirmation = false
            recognitionStatus = .idle
            recognizedText = ""
            proceedConversation()
            return
        }

        if isRecording {
            // 녹음 중지
            print("🎤 [RECORDING] 녹음 중지")
            speechRecognizer.stopRecording()
            isRecording = false

            // 인식 결과 확인
            let targetPhrase = currentUserPhrase?.text ?? scenario.startingPhrase
            print("🎤 [RECORDING] 목표 문장: \(targetPhrase)")
            print("🎤 [RECORDING] 인식된 문장: \(recognizedText)")

            // 일치 여부 확인하여 상태만 표시
            if isMatchingPhrase(recognized: recognizedText, target: targetPhrase) {
                print("✅ [RECORDING] 일치!")
                recognitionStatus = .success
            } else {
                print("⚠️ [RECORDING] 불일치")
                recognitionStatus = .failed
            }

            // 사용자 확인 대기 상태로 전환
            isWaitingForConfirmation = true
            print("🎤 [RECORDING] 사용자 확인 대기 중...")
        } else {
            // 녹음 시작
            print("🎤 [RECORDING] 녹음 시작")
            recognizedText = ""
            recognitionStatus = .listening
            isRecording = true
            let targetPhrase = currentUserPhrase?.text ?? scenario.startingPhrase
            print("🎤 [RECORDING] 목표 문장: \(targetPhrase)")
            print("🎤 [RECORDING] 학습 언어: \(learningLanguage.rawValue)")

            speechRecognizer.startRecording(language: learningLanguage.rawValue) { [self] text in
                print("🎤 [RECORDING] 실시간 인식: \(text)")
                recognizedText = text

                // 실시간으로 일치 여부 확인
                if isMatchingPhrase(recognized: text, target: targetPhrase) {
                    print("✅ [RECORDING] 실시간 일치 감지! 자동 중지")
                    // 일치하면 자동으로 녹음 중지 (하지만 자동 진행은 안 함)
                    DispatchQueue.main.async {
                        if isRecording {
                            toggleRecording()
                        }
                    }
                }
            }
        }
        print("🎤 [RECORDING] === toggleRecording 완료 ===\n")
    }

    // 구두점을 제거하고 텍스트를 정규화
    private func normalizePunctuation(_ text: String) -> String {
        return text.lowercased()
            .replacingOccurrences(of: ",", with: "")   // 쉼표
            .replacingOccurrences(of: ".", with: "")   // 온점
            .replacingOccurrences(of: "?", with: "")   // 물음표
            .replacingOccurrences(of: "!", with: "")   // 느낌표
            .replacingOccurrences(of: ";", with: "")   // 세미콜론
            .replacingOccurrences(of: ":", with: "")   // 콜론
            .replacingOccurrences(of: "…", with: "")   // 말줄임표
            .replacingOccurrences(of: "...", with: "") // 점 3개
            .replacingOccurrences(of: "—", with: "")   // em dash
            .replacingOccurrences(of: "–", with: "")   // en dash
            .replacingOccurrences(of: "-", with: "")   // 하이픈
            .replacingOccurrences(of: "'", with: "")   // 작은따옴표
            .replacingOccurrences(of: "\"", with: "")  // 큰따옴표
            .replacingOccurrences(of: "(", with: "")   // 괄호
            .replacingOccurrences(of: ")", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func isMatchingPhrase(recognized: String, target: String) -> Bool {
        // 간단한 유사도 검사 (정규화 후 비교)
        let normalizedRecognized = normalizePunctuation(recognized)
        let normalizedTarget = normalizePunctuation(target)

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
        print("📱 [CONVERSATION] === proceedConversation 시작 ===")
        print("📱 [CONVERSATION] isConversationStarted: \(isConversationStarted)")

        if !isConversationStarted {
            // 첫 대화 시작
            print("📱 [CONVERSATION] 첫 대화 시작")
            isConversationStarted = true

            let userStart = ConversationNode(
                id: "user-start",
                speaker: .user,
                text: scenario.startingPhrase,
                translations: scenario.startingPhraseTranslations,
                responses: nil
            )
            conversationHistory.append(userStart)
            print("📱 [CONVERSATION] 사용자 시작 문장 추가: \(userStart.text)")

            // AI 응답
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                print("📱 [CONVERSATION] AI 응답 준비 중...")
                if let randomResponse = scenario.conversationTree.randomElement() {
                    print("📱 [CONVERSATION] AI 응답 추가: \(randomResponse.text)")
                    conversationHistory.append(randomResponse)
                    print("📱 [CONVERSATION] speak() 함수 호출 시도")
                    speak(text: randomResponse.text)
                    currentResponses = randomResponse.responses

                    if let firstUserResponse = randomResponse.responses?.first {
                        currentUserPhrase = firstUserResponse
                        print("📱 [CONVERSATION] 다음 사용자 문장 설정: \(firstUserResponse.text)")
                    } else {
                        isConversationEnded = true
                        print("📱 [CONVERSATION] 대화 종료됨")
                    }
                }
                recognitionStatus = .idle
                recognizedText = ""
            }
        } else if let userPhrase = currentUserPhrase {
            // 사용자 응답 추가
            print("📱 [CONVERSATION] 사용자 응답 추가: \(userPhrase.text)")
            conversationHistory.append(userPhrase)

            // 다음 AI 응답
            if let nextResponses = userPhrase.responses, let nextNative = nextResponses.first {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    print("📱 [CONVERSATION] 다음 AI 응답 추가: \(nextNative.text)")
                    conversationHistory.append(nextNative)
                    print("📱 [CONVERSATION] speak() 함수 호출 시도")
                    speak(text: nextNative.text)
                    currentResponses = nextNative.responses

                    if let nextUserPhrase = nextNative.responses?.first {
                        currentUserPhrase = nextUserPhrase
                        print("📱 [CONVERSATION] 다음 사용자 문장 설정: \(nextUserPhrase.text)")
                    } else {
                        isConversationEnded = true
                        currentUserPhrase = nil
                        print("📱 [CONVERSATION] 대화 종료됨")
                    }
                    recognitionStatus = .idle
                    recognizedText = ""
                }
            } else {
                isConversationEnded = true
                currentUserPhrase = nil
                recognitionStatus = .idle
                recognizedText = ""
                print("📱 [CONVERSATION] 더 이상 응답 없음, 대화 종료")
            }
        }
        print("📱 [CONVERSATION] === proceedConversation 완료 ===\n")
    }

    private func saveConversationHistory() {
        let history = ConversationHistory(
            scenarioId: scenario.id,
            scenarioTitle: scenario.title,
            scenarioIcon: scenario.icon,
            learningLanguage: scenario.learningLanguage,
            conversationNodes: conversationHistory
        )
        historyManager.saveHistory(history)
        print("💾 [HISTORY] 대화 기록 저장 완료: \(scenario.getTitle(for: nativeLanguage))")
    }

    private func resetConversation() {
        conversationHistory = []
        currentResponses = nil
        currentUserPhrase = nil
        isConversationStarted = false
        isConversationEnded = false
        recognizedText = ""
        recognitionStatus = .idle
        isWaitingForConfirmation = false
    }

    private func speak(text: String) {
        print("🔊 [SPEAK] === 음성 재생 시작 ===")
        print("🔊 [SPEAK] 재생할 텍스트: \(text)")
        print("🔊 [SPEAK] 학습 언어: \(learningLanguage.displayName)")
        print("🔊 [SPEAK] 언어 코드: \(learningLanguage.rawValue)")

        // 사용 가능한 모든 음성 목록 출력
        let allVoices = AVSpeechSynthesisVoice.speechVoices()
        print("🔊 [SPEAK] 사용 가능한 전체 음성 개수: \(allVoices.count)")

        // 학습 언어에 해당하는 음성 찾기
        let availableVoicesForLanguage = allVoices.filter { $0.language.starts(with: learningLanguage.rawValue.prefix(2)) }
        print("🔊 [SPEAK] \(learningLanguage.displayName) 음성 개수: \(availableVoicesForLanguage.count)")

        if !availableVoicesForLanguage.isEmpty {
            print("🔊 [SPEAK] 사용 가능한 \(learningLanguage.displayName) 음성:")
            for voice in availableVoicesForLanguage {
                print("   - \(voice.name) (\(voice.language)) - Quality: \(voice.quality.rawValue)")
            }
        } else {
            print("⚠️ [SPEAK] 경고: \(learningLanguage.displayName) 음성을 찾을 수 없습니다!")
        }

        speechSynthesizer.speak(text: text, language: learningLanguage.rawValue)
        print("🔊 [SPEAK] === 음성 재생 요청 완료 ===\n")
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
    let isWaitingForConfirmation: Bool  // 확인 대기 상태
    let isSpeaking: Bool                // TTS 재생 중 상태
    let displayMode: LanguageDisplayMode
    let localizedText: LocalizedText
    let onRecordTap: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // 말해야 할 문장 표시
            VStack(spacing: 8) {
                Text(localizedText.sayThisPhrase)
                    .font(.caption)
                    .foregroundColor(.secondary)

                // 학습 언어 문장 (displayMode가 learning 또는 both일 때)
                if displayMode == .learning || displayMode == .both {
                    Text(currentPhrase)
                        .font(displayMode == .learning ? .title : .title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                }

                // 모국어 번역 (displayMode가 native 또는 both일 때)
                if (displayMode == .native || displayMode == .both), let translation = currentTranslation {
                    Text(translation)
                        .font(displayMode == .native ? .title : .subheadline)
                        .fontWeight(displayMode == .native ? .semibold : .regular)
                        .multilineTextAlignment(.center)
                        .foregroundColor(displayMode == .native ? .primary : .secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
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
                        .fill(buttonColor)
                        .frame(width: 70, height: 70)

                    Image(systemName: buttonIcon)
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
            }
            .disabled(isSpeaking)  // TTS 재생 중에는 비활성화
            .opacity(isSpeaking ? 0.5 : 1.0)
            .scaleEffect(isRecording ? 1.1 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isRecording)

            Text(statusMessage)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    private var buttonColor: Color {
        if isRecording {
            return .red
        } else if isWaitingForConfirmation {
            return .green
        } else {
            return .blue
        }
    }

    private var buttonIcon: String {
        if isRecording {
            return "stop.fill"
        } else if isWaitingForConfirmation {
            return "checkmark.circle.fill"
        } else {
            return "mic.fill"
        }
    }

    private var statusMessage: String {
        // TTS 재생 중일 때
        if isSpeaking {
            switch localizedText.nativeLanguage {
            case .korean: return "잘 듣고 답해주세요"
            case .english: return "Listen carefully and respond"
            case .japanese: return "よく聞いて答えてください"
            case .chinese: return "仔细听并回答"
            case .spanish: return "Escucha atentamente y responde"
            case .indonesian: return "Dengarkan baik-baik dan jawab"
            default: return "Listen carefully and respond"
            }
        }

        if isWaitingForConfirmation {
            switch localizedText.nativeLanguage {
            case .korean: return "탭하여 계속하기"
            case .english: return "Tap to continue"
            case .japanese: return "タップして続ける"
            case .chinese: return "点击继续"
            case .spanish: return "Toca para continuar"
            case .indonesian: return "Ketuk untuk melanjutkan"
            default: return "Tap to continue"
            }
        }

        switch recognitionStatus {
        case .idle:
            return localizedText.tapToSpeak
        case .listening:
            return localizedText.speaking
        case .success:
            return localizedText.greatJob
        case .failed:
            return localizedText.tryAgain
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
    let displayMode: LanguageDisplayMode
    let nativeLanguage: Language
    let learningLanguage: Language
    let localizedText: LocalizedText
    let onTap: () -> Void

    var isUser: Bool {
        node.speaker == .user
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if isUser {
                Spacer(minLength: 60)
            } else {
                // 상대방 아이콘
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    )
            }

            VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                // 스피커 라벨
                Text(isUser ? localizedText.me : localizedText.partner)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 4)

                // 메시지 내용
                VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                    // 학습 언어 텍스트 (displayMode가 learning 또는 both일 때)
                    if displayMode == .learning || displayMode == .both {
                        Text(node.text)
                            .font(.body)
                            .fontWeight(displayMode == .learning ? .medium : .regular)
                    }

                    // 모국어 번역 (displayMode가 native 또는 both일 때)
                    if (displayMode == .native || displayMode == .both), let translation = node.translation(for: nativeLanguage) {
                        Text(translation)
                            .font(displayMode == .native ? .body : .caption)
                            .fontWeight(displayMode == .native ? .medium : .regular)
                            .foregroundColor(isUser ? .white.opacity(0.85) : .secondary)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    Group {
                        if isUser {
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        } else {
                            Color(.systemGray5)
                        }
                    }
                )
                .foregroundColor(isUser ? .white : .primary)
                .cornerRadius(18)
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                .onTapGesture {
                    onTap()
                }
            }
            .frame(maxWidth: 280, alignment: isUser ? .trailing : .leading)

            if !isUser {
                Spacer(minLength: 60)
            } else {
                // 내 아이콘
                Circle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.green)
                    )
            }
        }
        .padding(.horizontal, 12)
    }
}

// MARK: - 음성 합성 래퍼
class SpeechSynthesizerWrapper: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    var onSpeechFinished: (() -> Void)?  // 음성 재생 완료 콜백
    @Published var isSpeaking: Bool = false  // 음성 재생 중 상태

    override init() {
        super.init()
        synthesizer.delegate = self
        print("🔊 [SYNTHESIZER] SpeechSynthesizerWrapper 초기화")
    }

    func speak(text: String, language: String) {
        print("🔊 [SYNTHESIZER] speak() 호출")
        print("🔊 [SYNTHESIZER] 텍스트: \(text)")
        print("🔊 [SYNTHESIZER] 언어: \(language)")

        // 오디오 세션 설정 (녹음과 재생을 모두 지원)
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // playAndRecord 카테고리로 녹음과 재생을 모두 지원
            // defaultToSpeaker: 스피커로 출력
            // duckOthers: 다른 오디오를 줄임
            try audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: [.defaultToSpeaker, .duckOthers])
            try audioSession.setActive(true, options: [.notifyOthersOnDeactivation])
            print("🔊 [SYNTHESIZER] 오디오 세션 설정 완료")
            print("🔊 [SYNTHESIZER] 카테고리: \(audioSession.category.rawValue)")
            print("🔊 [SYNTHESIZER] 모드: \(audioSession.mode.rawValue)")
            print("🔊 [SYNTHESIZER] 볼륨: \(audioSession.outputVolume)")
        } catch {
            print("❌ [SYNTHESIZER] 오디오 세션 설정 실패: \(error.localizedDescription)")
        }

        let utterance = AVSpeechUtterance(string: text)
        let voice = AVSpeechSynthesisVoice(language: language)

        if let voice = voice {
            print("🔊 [SYNTHESIZER] 선택된 음성: \(voice.name) (\(voice.language))")
            utterance.voice = voice
        } else {
            print("⚠️ [SYNTHESIZER] 음성을 찾을 수 없음, 기본 음성 사용")
        }

        utterance.rate = 0.4
        utterance.volume = 1.0
        print("🔊 [SYNTHESIZER] 재생 속도: \(utterance.rate)")
        print("🔊 [SYNTHESIZER] 볼륨: \(utterance.volume)")
        print("🔊 [SYNTHESIZER] synthesizer.isSpeaking: \(synthesizer.isSpeaking)")

        synthesizer.speak(utterance)
        print("🔊 [SYNTHESIZER] synthesizer.speak() 호출 완료")
    }

    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
        print("🔊 [SYNTHESIZER] 음성 중지")
    }

    // MARK: - AVSpeechSynthesizerDelegate

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("✅ [SYNTHESIZER] 음성 재생 시작!")
        print("✅ [SYNTHESIZER] 재생 중인 텍스트: \(utterance.speechString)")
        DispatchQueue.main.async { [weak self] in
            self?.isSpeaking = true
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("✅ [SYNTHESIZER] 음성 재생 완료!")
        DispatchQueue.main.async { [weak self] in
            self?.isSpeaking = false
        }

        // 음성 재생 완료 후 0.5초 대기 후 자동으로 녹음 시작
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.onSpeechFinished?()
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("⏸️ [SYNTHESIZER] 음성 일시 정지")
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        print("▶️ [SYNTHESIZER] 음성 재개")
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        print("🛑 [SYNTHESIZER] 음성 취소됨")
        DispatchQueue.main.async { [weak self] in
            self?.isSpeaking = false
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        // 너무 많이 출력되므로 주석 처리
        // print("🔊 [SYNTHESIZER] 재생 진행 중...")
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
