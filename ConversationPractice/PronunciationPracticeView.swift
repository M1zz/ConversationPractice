import SwiftUI
import Speech
import AVFoundation

struct PronunciationPracticeView: View {
    let nativeLanguage: Language
    let learningLanguage: Language

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    @State private var currentPhraseIndex = 0
    @State private var isRecording = false
    @State private var recognizedSegments: [RecognizedSegment] = []
    @State private var overallScore: Double = 0.0
    @State private var showResult = false
    @State private var showTranslation = true

    @StateObject private var pronunciationRecognizer = PronunciationRecognizer()

    var currentPhrase: PracticePhrase {
        practicePhrases[currentPhraseIndex]
    }

    var practicePhrases: [PracticePhrase] {
        getPracticePhrases(for: learningLanguage, nativeLanguage: nativeLanguage)
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    // 진행 상황
                    HStack {
                        Text("\(currentPhraseIndex + 1) / \(practicePhrases.count)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)

                    // 연습할 문장
                    VStack(spacing: 12) {
                        Text(practiceLabel)
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text(currentPhrase.text)
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        if showTranslation {
                            Text(currentPhrase.translation)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // 발음 결과
                    if showResult && !recognizedSegments.isEmpty {
                        VStack(spacing: 16) {
                            // 전체 점수
                            VStack(spacing: 8) {
                                Text(scoreLabel)
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 8) {
                                    Text(String(format: "%.0f", overallScore * 100))
                                        .font(.system(size: 48, weight: .bold))
                                        .foregroundColor(getScoreColor(overallScore))

                                    Text("%")
                                        .font(.title)
                                        .foregroundColor(.secondary)
                                }

                                Text(getScoreDescription(overallScore))
                                    .font(.subheadline)
                                    .foregroundColor(getScoreColor(overallScore))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 5)

                            // 단어별 피드백
                            VStack(alignment: .leading, spacing: 12) {
                                Text(wordByWordLabel)
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                FlowLayout(spacing: 8) {
                                    ForEach(recognizedSegments) { segment in
                                        WordConfidenceView(segment: segment)
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 5)
                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                }
            }

            Divider()

            // 하단 컨트롤
            VStack(spacing: 16) {
                if showResult {
                    HStack(spacing: 12) {
                        Button(action: retry) {
                            Label(retryLabel, systemImage: "arrow.counterclockwise")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }

                        if currentPhraseIndex < practicePhrases.count - 1 {
                            Button(action: nextPhrase) {
                                Label(nextLabel, systemImage: "arrow.right")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                } else {
                    Button(action: toggleRecording) {
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

                    Text(isRecording ? recordingLabel : tapToRecordLabel)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
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
            pronunciationRecognizer.requestAuthorization()
        }
    }

    // MARK: - Actions

    private func toggleRecording() {
        if isRecording {
            pronunciationRecognizer.stopRecording()
            isRecording = false
        } else {
            recognizedSegments = []
            showResult = false
            isRecording = true

            pronunciationRecognizer.startRecording(language: learningLanguage.rawValue) { segments, score in
                DispatchQueue.main.async {
                    self.recognizedSegments = segments
                    self.overallScore = score
                    self.showResult = true
                }
            }
        }
    }

    private func retry() {
        showResult = false
        recognizedSegments = []
        overallScore = 0.0
    }

    private func nextPhrase() {
        if currentPhraseIndex < practicePhrases.count - 1 {
            currentPhraseIndex += 1
            retry()
        }
    }

    private func getScoreColor(_ score: Double) -> Color {
        switch score {
        case 0.9...1.0: return .green
        case 0.7..<0.9: return .blue
        case 0.5..<0.7: return .orange
        default: return .red
        }
    }

    private func getScoreDescription(_ score: Double) -> String {
        switch nativeLanguage {
        case .korean:
            switch score {
            case 0.9...1.0: return "훌륭해요! 🎉"
            case 0.7..<0.9: return "잘했어요! 👍"
            case 0.5..<0.7: return "괜찮아요"
            default: return "다시 연습해보세요"
            }
        case .english:
            switch score {
            case 0.9...1.0: return "Excellent! 🎉"
            case 0.7..<0.9: return "Great! 👍"
            case 0.5..<0.7: return "Good"
            default: return "Keep practicing"
            }
        default:
            switch score {
            case 0.9...1.0: return "Excellent! 🎉"
            case 0.7..<0.9: return "Great! 👍"
            case 0.5..<0.7: return "Good"
            default: return "Keep practicing"
            }
        }
    }

    // MARK: - Localized Strings

    private var practiceLabel: String {
        switch nativeLanguage {
        case .korean: return "이 문장을 따라 말해보세요:"
        case .english: return "Try to say this phrase:"
        case .japanese: return "このフレーズを言ってみてください:"
        case .chinese: return "请跟着说这句话:"
        case .spanish: return "Intenta decir esta frase:"
        case .indonesian: return "Coba ucapkan kalimat ini:"
        }
    }

    private var scoreLabel: String {
        switch nativeLanguage {
        case .korean: return "발음 점수"
        case .english: return "Pronunciation Score"
        case .japanese: return "発音スコア"
        case .chinese: return "发音分数"
        case .spanish: return "Puntuación de pronunciación"
        case .indonesian: return "Skor Pengucapan"
        }
    }

    private var wordByWordLabel: String {
        switch nativeLanguage {
        case .korean: return "단어별 분석"
        case .english: return "Word-by-Word Analysis"
        case .japanese: return "単語ごとの分析"
        case .chinese: return "逐词分析"
        case .spanish: return "Análisis palabra por palabra"
        case .indonesian: return "Analisis Per Kata"
        }
    }

    private var retryLabel: String {
        switch nativeLanguage {
        case .korean: return "다시 하기"
        case .english: return "Try Again"
        case .japanese: return "再試行"
        case .chinese: return "重试"
        case .spanish: return "Reintentar"
        case .indonesian: return "Coba Lagi"
        }
    }

    private var nextLabel: String {
        switch nativeLanguage {
        case .korean: return "다음"
        case .english: return "Next"
        case .japanese: return "次へ"
        case .chinese: return "下一个"
        case .spanish: return "Siguiente"
        case .indonesian: return "Berikutnya"
        }
    }

    private var recordingLabel: String {
        switch nativeLanguage {
        case .korean: return "녹음 중..."
        case .english: return "Recording..."
        case .japanese: return "録音中..."
        case .chinese: return "录音中..."
        case .spanish: return "Grabando..."
        case .indonesian: return "Merekam..."
        }
    }

    private var tapToRecordLabel: String {
        switch nativeLanguage {
        case .korean: return "탭하여 발음하기"
        case .english: return "Tap to record"
        case .japanese: return "タップして録音"
        case .chinese: return "点击录音"
        case .spanish: return "Toca para grabar"
        case .indonesian: return "Ketuk untuk merekam"
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
}

// MARK: - Models

struct PracticePhrase {
    let text: String
    let translation: String
}

struct RecognizedSegment: Identifiable {
    let id = UUID()
    let text: String
    let confidence: Double
}

// MARK: - Word Confidence View

struct WordConfidenceView: View {
    let segment: RecognizedSegment

    var body: some View {
        VStack(spacing: 4) {
            Text(segment.text)
                .font(.body)
                .fontWeight(.medium)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(8)

            Text(String(format: "%.0f%%", segment.confidence * 100))
                .font(.caption2)
                .foregroundColor(backgroundColor)
        }
    }

    private var backgroundColor: Color {
        switch segment.confidence {
        case 0.9...1.0: return .green
        case 0.7..<0.9: return .blue
        case 0.5..<0.7: return .orange
        default: return .red
        }
    }
}

// MARK: - Flow Layout

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX,
                                     y: bounds.minY + result.frames[index].minY),
                         proposal: ProposedViewSize(result.frames[index].size))
        }
    }

    struct FlowResult {
        var size: CGSize = .zero
        var frames: [CGRect] = []

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)

                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }

                frames.append(CGRect(origin: CGPoint(x: currentX, y: currentY), size: size))
                currentX += size.width + spacing
                lineHeight = max(lineHeight, size.height)
            }

            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

// MARK: - Pronunciation Recognizer

class PronunciationRecognizer: ObservableObject {
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

    func startRecording(language: String, onResult: @escaping ([RecognizedSegment], Double) -> Void) {
        stopRecording()

        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: language))

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: [.defaultToSpeaker, .duckOthers])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("오디오 세션 설정 실패: \(error)")
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { return }

        recognitionRequest.shouldReportPartialResults = false  // 최종 결과만 받음

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
                if result.isFinal {
                    // 최종 결과에서 segments 추출
                    let segments = result.bestTranscription.segments.map { segment in
                        RecognizedSegment(
                            text: segment.substring,
                            confidence: Double(segment.confidence)
                        )
                    }

                    // 전체 평균 confidence 계산
                    let averageConfidence = segments.isEmpty ? 0.0 :
                        segments.map { $0.confidence }.reduce(0, +) / Double(segments.count)

                    onResult(segments, averageConfidence)
                    self.stopRecording()
                }
            }

            if error != nil {
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

// MARK: - Practice Phrases Data

func getPracticePhrases(for language: Language, nativeLanguage: Language) -> [PracticePhrase] {
    switch language {
    case .indonesian:
        return getIndonesianPhrases(nativeLanguage: nativeLanguage)
    case .korean:
        return getKoreanPhrases(nativeLanguage: nativeLanguage)
    case .english:
        return getEnglishPhrases(nativeLanguage: nativeLanguage)
    case .japanese:
        return getJapanesePhrases(nativeLanguage: nativeLanguage)
    case .chinese:
        return getChinesePhrases(nativeLanguage: nativeLanguage)
    case .spanish:
        return getSpanishPhrases(nativeLanguage: nativeLanguage)
    }
}

func getIndonesianPhrases(nativeLanguage: Language) -> [PracticePhrase] {
    let translations: [String] = {
        switch nativeLanguage {
        case .korean: return ["안녕하세요", "화장실이 어디에요?", "감사합니다", "얼마에요?", "도와주세요"]
        default: return ["Hello", "Where is the bathroom?", "Thank you", "How much?", "Please help me"]
        }
    }()

    return [
        PracticePhrase(text: "Halo", translation: translations[0]),
        PracticePhrase(text: "Di mana toilet?", translation: translations[1]),
        PracticePhrase(text: "Terima kasih", translation: translations[2]),
        PracticePhrase(text: "Berapa harganya?", translation: translations[3]),
        PracticePhrase(text: "Tolong bantu saya", translation: translations[4])
    ]
}

func getKoreanPhrases(nativeLanguage: Language) -> [PracticePhrase] {
    return [
        PracticePhrase(text: "안녕하세요", translation: "Hello"),
        PracticePhrase(text: "화장실이 어디에요?", translation: "Where is the bathroom?"),
        PracticePhrase(text: "감사합니다", translation: "Thank you"),
        PracticePhrase(text: "얼마예요?", translation: "How much?"),
        PracticePhrase(text: "도와주세요", translation: "Please help me")
    ]
}

func getEnglishPhrases(nativeLanguage: Language) -> [PracticePhrase] {
    let translations: [String] = {
        switch nativeLanguage {
        case .korean: return ["안녕하세요", "화장실이 어디에요?", "감사합니다", "얼마에요?", "도와주세요"]
        default: return ["Hello", "Where is the bathroom?", "Thank you", "How much?", "Please help me"]
        }
    }()

    return [
        PracticePhrase(text: "Hello", translation: translations[0]),
        PracticePhrase(text: "Where is the bathroom?", translation: translations[1]),
        PracticePhrase(text: "Thank you", translation: translations[2]),
        PracticePhrase(text: "How much is it?", translation: translations[3]),
        PracticePhrase(text: "Please help me", translation: translations[4])
    ]
}

func getJapanesePhrases(nativeLanguage: Language) -> [PracticePhrase] {
    let translations: [String] = {
        switch nativeLanguage {
        case .korean: return ["안녕하세요", "화장실이 어디에요?", "감사합니다", "얼마에요?", "도와주세요"]
        default: return ["Hello", "Where is the bathroom?", "Thank you", "How much?", "Please help me"]
        }
    }()

    return [
        PracticePhrase(text: "こんにちは", translation: translations[0]),
        PracticePhrase(text: "トイレはどこですか？", translation: translations[1]),
        PracticePhrase(text: "ありがとうございます", translation: translations[2]),
        PracticePhrase(text: "いくらですか？", translation: translations[3]),
        PracticePhrase(text: "助けてください", translation: translations[4])
    ]
}

func getChinesePhrases(nativeLanguage: Language) -> [PracticePhrase] {
    let translations: [String] = {
        switch nativeLanguage {
        case .korean: return ["안녕하세요", "화장실이 어디에요?", "감사합니다", "얼마에요?", "도와주세요"]
        default: return ["Hello", "Where is the bathroom?", "Thank you", "How much?", "Please help me"]
        }
    }()

    return [
        PracticePhrase(text: "你好", translation: translations[0]),
        PracticePhrase(text: "洗手间在哪里？", translation: translations[1]),
        PracticePhrase(text: "谢谢", translation: translations[2]),
        PracticePhrase(text: "多少钱？", translation: translations[3]),
        PracticePhrase(text: "请帮帮我", translation: translations[4])
    ]
}

func getSpanishPhrases(nativeLanguage: Language) -> [PracticePhrase] {
    let translations: [String] = {
        switch nativeLanguage {
        case .korean: return ["안녕하세요", "화장실이 어디에요?", "감사합니다", "얼마에요?", "도와주세요"]
        default: return ["Hello", "Where is the bathroom?", "Thank you", "How much?", "Please help me"]
        }
    }()

    return [
        PracticePhrase(text: "Hola", translation: translations[0]),
        PracticePhrase(text: "¿Dónde está el baño?", translation: translations[1]),
        PracticePhrase(text: "Gracias", translation: translations[2]),
        PracticePhrase(text: "¿Cuánto cuesta?", translation: translations[3]),
        PracticePhrase(text: "Por favor ayúdame", translation: translations[4])
    ]
}

#Preview {
    NavigationView {
        PronunciationPracticeView(
            nativeLanguage: .korean,
            learningLanguage: .indonesian
        )
    }
}
