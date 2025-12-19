import SwiftUI
import AVFoundation
import Speech

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
                                displayMode: displayMode,
                                nativeLanguage: nativeLanguage,
                                learningLanguage: learningLanguage,
                                localizedText: localizedText,
                                onTap: {
                                    speak(text: node.text)
                                }
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
                // 음성 입력 UI
                if !isConversationEnded {
                    VoiceInputSection(
                        isConversationStarted: isConversationStarted,
                        currentPhrase: currentUserPhrase?.text ?? scenario.startingPhrase,
                        currentTranslation: currentUserPhrase?.translation(for: nativeLanguage) ?? scenario.getStartingPhraseTranslation(for: nativeLanguage),
                        isRecording: isRecording,
                        recognizedText: recognizedText,
                        recognitionStatus: recognitionStatus,
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
                            Text(displayModeLabel)
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

    private var completionMessage: String {
        switch nativeLanguage {
        case .korean: return "🎉 대화 완료!"
        case .english: return "🎉 Conversation Complete!"
        case .japanese: return "🎉 会話完了!"
        case .chinese: return "🎉 对话完成!"
        case .spanish: return "🎉 ¡Conversación completada!"
        case .indonesian: return "🎉 Percakapan Selesai!"
        default: return "🎉 Conversation Complete!"
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
        default: return "Practice Again"
        }
    }

    private var displayModeIcon: String {
        switch displayMode {
        case .native: return "textformat.abc"
        case .learning: return "character.book.closed"
        case .both: return "textformat.abc.dottedunderline"
        }
    }

    private var displayModeLabel: String {
        switch displayMode {
        case .native:
            switch nativeLanguage {
            case .korean: return "모국어"
            case .english: return "Native"
            case .japanese: return "母国語"
            case .chinese: return "母语"
            case .spanish: return "Nativo"
            case .indonesian: return "Bahasa Ibu"
            default: return "Native"
            }
        case .learning:
            switch nativeLanguage {
            case .korean: return "외국어"
            case .english: return "Learning"
            case .japanese: return "学習言語"
            case .chinese: return "学习语言"
            case .spanish: return "Aprendizaje"
            case .indonesian: return "Bahasa Belajar"
            default: return "Learning"
            }
        case .both:
            switch nativeLanguage {
            case .korean: return "모두"
            case .english: return "Both"
            case .japanese: return "両方"
            case .chinese: return "两者"
            case .spanish: return "Ambos"
            case .indonesian: return "Keduanya"
            default: return "Both"
            }
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
                print("⚠️ [RECORDING] 불일치하지만 계속 진행")
                recognitionStatus = .failed
            }

            // 일치 여부와 관계없이 항상 다음으로 진행
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                proceedConversation()
            }
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
                    // 일치하면 자동으로 녹음 중지
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
    let displayMode: LanguageDisplayMode
    let localizedText: LocalizedText
    let onRecordTap: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // 말해야 할 문장 표시
            VStack(spacing: 8) {
                Text(sayThisLabel)
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
        default: return "Say this phrase:"
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
            default: return "Great job! ✓"
            }
        case .failed:
            switch localizedText.nativeLanguage {
            case .korean: return "다시 시도해보세요"
            case .english: return "Try again"
            case .japanese: return "もう一度試してください"
            case .chinese: return "请再试一次"
            case .spanish: return "Inténtalo de nuevo"
            case .indonesian: return "Coba lagi"
            default: return "Try again"
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
    let displayMode: LanguageDisplayMode
    let nativeLanguage: Language
    let learningLanguage: Language
    let localizedText: LocalizedText
    let onTap: () -> Void

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

    private var partnerLabel: String {
        switch localizedText.nativeLanguage {
        case .korean: return "상대방"
        case .english: return "Partner"
        case .japanese: return "相手"
        case .chinese: return "对方"
        case .spanish: return "Compañero"
        case .indonesian: return "Lawan bicara"
        default: return "Partner"
        }
    }
}

// MARK: - 음성 합성 래퍼
class SpeechSynthesizerWrapper: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    var onSpeechFinished: (() -> Void)?  // 음성 재생 완료 콜백

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
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("✅ [SYNTHESIZER] 음성 재생 완료!")

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
