import SwiftUI
import Translation

struct ScenarioCreationView: View {
    let nativeLanguage: Language
    let learningLanguage: Language

    @Environment(\.dismiss) var dismiss
    @StateObject private var scenarioManager = CustomScenarioManager.shared

    @State private var title = ""
    @State private var description = ""
    @State private var selectedIcon = "💬"
    @State private var conversationTurns: [TurnData] = []
    @State private var showingIconPicker = false
    @State private var showingMetadata = false
    @State private var showingDiscardAlert = false

    // 자동 저장 관련
    @State private var autoSaveTimer: Timer?
    @State private var isDiscarding = false  // 버리기 중인지 추적
    private let draftKey = "scenarioDraft"

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    private var canSave: Bool {
        !title.isEmpty &&
        !description.isEmpty &&
        conversationTurns.count >= 2 &&
        conversationTurns.allSatisfy { turn in
            turn.options.allSatisfy { option in
                !option.nativeText.isEmpty && !option.learningText.isEmpty
            }
        }
    }

    private var hasUnsavedChanges: Bool {
        !title.isEmpty || !description.isEmpty || !conversationTurns.isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                // 대화 내용 섹션 (메인 포커스)
                Section(header: Text(conversationLabel)) {
                    if conversationTurns.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "bubble.left.and.bubble.right")
                                .font(.system(size: 40))
                                .foregroundColor(.secondary)
                            Text(addConversationGuide)
                                .foregroundColor(.secondary)
                                .font(.caption)
                                .multilineTextAlignment(.center)

                            Button(action: addTurn) {
                                Label(addFirstTurnLabel, systemImage: "plus.circle.fill")
                                    .font(.headline)
                            }
                            .buttonStyle(.bordered)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                    } else {
                        ForEach(Array(conversationTurns.enumerated()), id: \.element.id) { index, turn in
                            VStack(spacing: 0) {
                                TurnRow(
                                    turn: turn,
                                    index: index,
                                    nativeLanguage: nativeLanguage,
                                    learningLanguage: learningLanguage,
                                    onUpdate: { updated in
                                        if let idx = conversationTurns.firstIndex(where: { $0.id == updated.id }) {
                                            conversationTurns[idx] = updated
                                            saveDraft()
                                        }
                                    },
                                    onDelete: {
                                        conversationTurns.removeAll(where: { $0.id == turn.id })
                                        saveDraft()
                                    }
                                )

                                // 각 턴 아래에 추가 버튼
                                Button(action: {
                                    insertTurnAfter(index: index)
                                }) {
                                    HStack {
                                        Image(systemName: "plus.circle")
                                        Text(addTurnLabel)
                                            .font(.caption)
                                    }
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }

                // 기본 정보 섹션 (접을 수 있음)
                Section(header: HStack {
                    Text(basicInfoLabel)
                    Spacer()
                    Button(action: { showingMetadata.toggle() }) {
                        Image(systemName: showingMetadata ? "chevron.up" : "chevron.down")
                            .foregroundColor(.secondary)
                    }
                }) {
                    if showingMetadata {
                        // 아이콘 선택
                        Button(action: { showingIconPicker = true }) {
                            HStack {
                                Text(iconLabel)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(selectedIcon)
                                    .font(.largeTitle)
                            }
                        }

                        // 제목
                        VStack(alignment: .leading, spacing: 4) {
                            Text(titleLabel)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            TextField(titlePlaceholder, text: $title)
                                .onChange(of: title) { _ in
                                    saveDraft()
                                }
                        }

                        // 설명
                        VStack(alignment: .leading, spacing: 4) {
                            Text(descriptionLabel)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            TextEditor(text: $description)
                                .frame(minHeight: 60)
                                .onChange(of: description) { _ in
                                    saveDraft()
                                }
                        }
                    } else {
                        Button(action: { showingMetadata = true }) {
                            HStack {
                                Text(addMetadataLabel)
                                    .foregroundColor(.secondary)
                                Spacer()
                                if !title.isEmpty || !description.isEmpty {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(createScenarioLabel)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(cancelLabel) {
                        if hasUnsavedChanges {
                            showingDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(saveLabel) {
                        saveScenario()
                    }
                    .disabled(!canSave)
                }
            }
            .sheet(isPresented: $showingIconPicker) {
                IconPickerView(selectedIcon: $selectedIcon)
            }
            .alert(discardAlertTitle, isPresented: $showingDiscardAlert) {
                Button(discardLabel, role: .destructive) {
                    isDiscarding = true
                    clearDraft()
                    clearState()
                    dismiss()
                }
                Button(keepEditingLabel, role: .cancel) { }
            } message: {
                Text(discardAlertMessage)
            }
            .onAppear {
                loadDraft()
            }
            .onDisappear {
                if hasUnsavedChanges && !isDiscarding {
                    saveDraft()
                }
            }
            .modifier(TranslationModifier(nativeLanguage: nativeLanguage, learningLanguage: learningLanguage))
        }
    }

    private func addTurn() {
        let speaker: ConversationTurn.TurnSpeaker = conversationTurns.isEmpty ? .user :
            (conversationTurns.last?.speaker == .user ? .ai : .user)

        conversationTurns.append(TurnData(
            speaker: speaker,
            options: [TurnOption()]
        ))
        saveDraft()
    }

    private func insertTurnAfter(index: Int) {
        let currentSpeaker = conversationTurns[index].speaker
        let nextSpeaker: ConversationTurn.TurnSpeaker = currentSpeaker == .user ? .ai : .user

        let newTurn = TurnData(
            speaker: nextSpeaker,
            options: [TurnOption()]
        )

        conversationTurns.insert(newTurn, at: index + 1)
        saveDraft()
    }

    // MARK: - Draft Management

    private func saveDraft() {
        guard hasUnsavedChanges && !isDiscarding else { return }

        let draft = ScenarioDraft(
            title: title,
            description: description,
            icon: selectedIcon,
            turns: conversationTurns
        )

        if let encoded = try? JSONEncoder().encode(draft) {
            UserDefaults.standard.set(encoded, forKey: draftKey)
            print("💾 [DRAFT] 자동 저장됨")
        }
    }

    private func loadDraft() {
        guard let data = UserDefaults.standard.data(forKey: draftKey),
              let draft = try? JSONDecoder().decode(ScenarioDraft.self, from: data) else {
            return
        }

        title = draft.title
        description = draft.description
        selectedIcon = draft.icon
        conversationTurns = draft.turns

        print("📂 [DRAFT] 불러옴: \(draft.turns.count)개 턴")
    }

    private func clearDraft() {
        UserDefaults.standard.removeObject(forKey: draftKey)
        print("🗑️ [DRAFT] 삭제됨")
    }

    private func clearState() {
        title = ""
        description = ""
        selectedIcon = "💬"
        conversationTurns = []
        print("🧹 [STATE] 상태 초기화됨")
    }

    private func saveScenario() {
        let turns = conversationTurns.map { turnData in
            // 모든 옵션을 ConversationTurn.TextOption으로 변환
            let textOptions = turnData.options.map { option in
                ConversationTurn.TextOption(
                    nativeText: option.nativeText,
                    learningText: option.learningText
                )
            }

            return ConversationTurn(
                id: turnData.id,
                speaker: turnData.speaker,
                textOptions: textOptions
            )
        }

        let scenario = CustomScenario(
            nativeLanguage: nativeLanguage,
            learningLanguage: learningLanguage,
            icon: selectedIcon,
            title: title,
            description: description,
            conversationTurns: turns
        )

        scenarioManager.saveScenario(scenario)
        isDiscarding = true  // 저장 후에는 자동 저장 방지
        clearDraft()  // 저장 성공 시 draft 삭제
        clearState()  // 상태 초기화
        dismiss()
    }

    // MARK: - Localized Labels
    private var basicInfoLabel: String {
        switch nativeLanguage {
        case .korean: return "기본 정보"
        case .english: return "Basic Information"
        case .japanese: return "基本情報"
        case .chinese: return "基本信息"
        case .spanish: return "Información básica"
        case .indonesian: return "Informasi Dasar"
        }
    }

    private var iconLabel: String {
        switch nativeLanguage {
        case .korean: return "아이콘"
        case .english: return "Icon"
        case .japanese: return "アイコン"
        case .chinese: return "图标"
        case .spanish: return "Icono"
        case .indonesian: return "Ikon"
        }
    }

    private var titleLabel: String {
        switch nativeLanguage {
        case .korean: return "제목"
        case .english: return "Title"
        case .japanese: return "タイトル"
        case .chinese: return "标题"
        case .spanish: return "Título"
        case .indonesian: return "Judul"
        }
    }

    private var titlePlaceholder: String {
        switch nativeLanguage {
        case .korean: return "시나리오 제목을 입력하세요"
        case .english: return "Enter scenario title"
        case .japanese: return "シナリオのタイトルを入力"
        case .chinese: return "输入场景标题"
        case .spanish: return "Ingrese el título del escenario"
        case .indonesian: return "Masukkan judul skenario"
        }
    }

    private var descriptionLabel: String {
        switch nativeLanguage {
        case .korean: return "설명"
        case .english: return "Description"
        case .japanese: return "説明"
        case .chinese: return "描述"
        case .spanish: return "Descripción"
        case .indonesian: return "Deskripsi"
        }
    }

    private var conversationLabel: String {
        switch nativeLanguage {
        case .korean: return "대화 내용"
        case .english: return "Conversation"
        case .japanese: return "会話内容"
        case .chinese: return "对话内容"
        case .spanish: return "Conversación"
        case .indonesian: return "Percakapan"
        }
    }

    private var addConversationGuide: String {
        switch nativeLanguage {
        case .korean: return "+ 버튼을 눌러 대화를 추가하세요"
        case .english: return "Tap + to add conversation"
        case .japanese: return "+ ボタンをタップして会話を追加"
        case .chinese: return "点击 + 添加对话"
        case .spanish: return "Toca + para agregar conversación"
        case .indonesian: return "Ketuk + untuk menambah percakapan"
        }
    }

    private var createScenarioLabel: String {
        switch nativeLanguage {
        case .korean: return "시나리오 만들기"
        case .english: return "Create Scenario"
        case .japanese: return "シナリオ作成"
        case .chinese: return "创建场景"
        case .spanish: return "Crear escenario"
        case .indonesian: return "Buat Skenario"
        }
    }

    private var cancelLabel: String {
        switch nativeLanguage {
        case .korean: return "취소"
        case .english: return "Cancel"
        case .japanese: return "キャンセル"
        case .chinese: return "取消"
        case .spanish: return "Cancelar"
        case .indonesian: return "Batal"
        }
    }

    private var saveLabel: String {
        switch nativeLanguage {
        case .korean: return "저장"
        case .english: return "Save"
        case .japanese: return "保存"
        case .chinese: return "保存"
        case .spanish: return "Guardar"
        case .indonesian: return "Simpan"
        }
    }

    private var addMetadataLabel: String {
        switch nativeLanguage {
        case .korean: return "제목과 설명 추가하기"
        case .english: return "Add title and description"
        case .japanese: return "タイトルと説明を追加"
        case .chinese: return "添加标题和描述"
        case .spanish: return "Agregar título y descripción"
        case .indonesian: return "Tambah judul dan deskripsi"
        }
    }

    private var addTurnLabel: String {
        switch nativeLanguage {
        case .korean: return "대화 추가"
        case .english: return "Add Turn"
        case .japanese: return "会話を追加"
        case .chinese: return "添加对话"
        case .spanish: return "Agregar turno"
        case .indonesian: return "Tambah Giliran"
        }
    }

    private var addFirstTurnLabel: String {
        switch nativeLanguage {
        case .korean: return "첫 대화 추가하기"
        case .english: return "Add First Turn"
        case .japanese: return "最初の会話を追加"
        case .chinese: return "添加第一轮对话"
        case .spanish: return "Agregar primer turno"
        case .indonesian: return "Tambah Giliran Pertama"
        }
    }

    private var discardAlertTitle: String {
        switch nativeLanguage {
        case .korean: return "변경사항 버리기"
        case .english: return "Discard Changes"
        case .japanese: return "変更を破棄"
        case .chinese: return "放弃更改"
        case .spanish: return "Descartar cambios"
        case .indonesian: return "Buang Perubahan"
        }
    }

    private var discardAlertMessage: String {
        switch nativeLanguage {
        case .korean: return "작성 중인 내용을 버리시겠습니까?"
        case .english: return "Do you want to discard your changes?"
        case .japanese: return "作成中の内容を破棄しますか？"
        case .chinese: return "您要放弃更改吗？"
        case .spanish: return "¿Quieres descartar tus cambios?"
        case .indonesian: return "Apakah Anda ingin membuang perubahan Anda?"
        }
    }

    private var discardLabel: String {
        switch nativeLanguage {
        case .korean: return "버리기"
        case .english: return "Discard"
        case .japanese: return "破棄"
        case .chinese: return "放弃"
        case .spanish: return "Descartar"
        case .indonesian: return "Buang"
        }
    }

    private var keepEditingLabel: String {
        switch nativeLanguage {
        case .korean: return "계속 작성"
        case .english: return "Keep Editing"
        case .japanese: return "編集を続ける"
        case .chinese: return "继续编辑"
        case .spanish: return "Seguir editando"
        case .indonesian: return "Lanjutkan Mengedit"
        }
    }
}

// MARK: - Turn Option
struct TurnOption: Identifiable, Codable {
    let id: String
    var nativeText: String
    var learningText: String

    init(id: String = UUID().uuidString, nativeText: String = "", learningText: String = "") {
        self.id = id
        self.nativeText = nativeText
        self.learningText = learningText
    }
}

// MARK: - Turn Data
struct TurnData: Identifiable, Codable {
    let id: String
    let speaker: ConversationTurn.TurnSpeaker
    var options: [TurnOption]

    init(id: String = UUID().uuidString, speaker: ConversationTurn.TurnSpeaker, options: [TurnOption] = []) {
        self.id = id
        self.speaker = speaker
        self.options = options.isEmpty ? [TurnOption()] : options
    }

    // 기존 코드 호환성을 위한 computed properties
    var nativeText: String {
        get { options.first?.nativeText ?? "" }
        set {
            if options.isEmpty {
                options.append(TurnOption(nativeText: newValue, learningText: ""))
            } else {
                options[0].nativeText = newValue
            }
        }
    }

    var learningText: String {
        get { options.first?.learningText ?? "" }
        set {
            if options.isEmpty {
                options.append(TurnOption(nativeText: "", learningText: newValue))
            } else {
                options[0].learningText = newValue
            }
        }
    }
}

// MARK: - Scenario Draft
struct ScenarioDraft: Codable {
    let title: String
    let description: String
    let icon: String
    let turns: [TurnData]
}

// MARK: - Turn Row
struct TurnRow: View {
    let turn: TurnData
    let index: Int
    let nativeLanguage: Language
    let learningLanguage: Language
    let onUpdate: (TurnData) -> Void
    let onDelete: () -> Void

    init(turn: TurnData, index: Int, nativeLanguage: Language, learningLanguage: Language,
         onUpdate: @escaping (TurnData) -> Void, onDelete: @escaping () -> Void) {
        self.turn = turn
        self.index = index
        self.nativeLanguage = nativeLanguage
        self.learningLanguage = learningLanguage
        self.onUpdate = onUpdate
        self.onDelete = onDelete
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 헤더
            HStack {
                Image(systemName: turn.speaker == .user ? "person.fill" : "brain.head.profile")
                    .foregroundColor(turn.speaker == .user ? .blue : .green)
                Text("\(index + 1). \(speakerLabel)")
                    .font(.headline)

                Text("(\(turn.options.count) \(optionsLabel))")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }

            // 옵션들을 수평 스크롤로 표시 (옵션 추가 버튼이 살짝 보이도록)
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 12) {
                    ForEach(Array(turn.options.enumerated()), id: \.element.id) { optionIndex, option in
                        OptionCard(
                            option: option,
                            optionIndex: optionIndex,
                            nativeLanguage: nativeLanguage,
                            learningLanguage: learningLanguage,
                            onUpdate: { updatedOption in
                                var updatedTurn = turn
                                if optionIndex < updatedTurn.options.count {
                                    updatedTurn.options[optionIndex] = updatedOption
                                    onUpdate(updatedTurn)
                                }
                            },
                            onDelete: {
                                var updatedTurn = turn
                                if updatedTurn.options.count > 1 {
                                    updatedTurn.options.remove(at: optionIndex)
                                    onUpdate(updatedTurn)
                                }
                            }
                        )
                        .frame(width: 280)  // 카드 너비를 줄여서 더 많이 보이도록
                    }

                    // 옵션 추가 버튼 (항상 살짝 보이도록)
                    Button(action: addOption) {
                        VStack(spacing: 8) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                            Text(addOptionLabel)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(width: 120, height: 200)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }
                .padding(.leading, 4)
                .padding(.trailing, 40)  // 오른쪽에 여유 공간을 두어 추가 버튼이 살짝 보이도록
            }
            .frame(height: 220)
        }
        .padding(.vertical, 8)
    }

    private func addOption() {
        var updatedTurn = turn
        updatedTurn.options.append(TurnOption())
        onUpdate(updatedTurn)
    }

    private var speakerLabel: String {
        switch nativeLanguage {
        case .korean: return turn.speaker == .user ? "나" : "상대방"
        case .english: return turn.speaker == .user ? "Me" : "Partner"
        case .japanese: return turn.speaker == .user ? "私" : "相手"
        case .chinese: return turn.speaker == .user ? "我" : "对方"
        case .spanish: return turn.speaker == .user ? "Yo" : "Compañero"
        case .indonesian: return turn.speaker == .user ? "Saya" : "Lawan bicara"
        }
    }

    private var optionsLabel: String {
        switch nativeLanguage {
        case .korean: return "옵션"
        case .english: return "options"
        case .japanese: return "オプション"
        case .chinese: return "选项"
        case .spanish: return "opciones"
        case .indonesian: return "opsi"
        }
    }

    private var addOptionLabel: String {
        switch nativeLanguage {
        case .korean: return "옵션 추가"
        case .english: return "Add Option"
        case .japanese: return "オプション追加"
        case .chinese: return "添加选项"
        case .spanish: return "Agregar opción"
        case .indonesian: return "Tambah Opsi"
        }
    }
}

// MARK: - Option Card
struct OptionCard: View {
    let option: TurnOption
    let optionIndex: Int
    let nativeLanguage: Language
    let learningLanguage: Language
    let onUpdate: (TurnOption) -> Void
    let onDelete: () -> Void

    @State private var nativeText: String
    @State private var learningText: String
    @State private var isTranslating = false
    @State private var translationTask: Task<Void, Never>?
    @State private var userEditedTranslation = false

    init(option: TurnOption, optionIndex: Int, nativeLanguage: Language, learningLanguage: Language,
         onUpdate: @escaping (TurnOption) -> Void, onDelete: @escaping () -> Void) {
        self.option = option
        self.optionIndex = optionIndex
        self.nativeLanguage = nativeLanguage
        self.learningLanguage = learningLanguage
        self.onUpdate = onUpdate
        self.onDelete = onDelete
        self._nativeText = State(initialValue: option.nativeText)
        self._learningText = State(initialValue: option.learningText)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 옵션 헤더
            HStack {
                Text(optionLabel)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                // 번역 상태 표시
                if isTranslating {
                    ProgressView()
                        .scaleEffect(0.7)
                } else if !learningText.isEmpty && !userEditedTranslation {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.caption)
                }

                // 삭제 버튼 (항상 표시, 부모에서 조건 처리)
                Button(action: onDelete) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }

            // 모국어 텍스트
            VStack(alignment: .leading, spacing: 4) {
                Text(nativeLanguageLabel)
                    .font(.caption2)
                    .foregroundColor(.secondary)

                TextField(nativePlaceholder, text: $nativeText, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .lineLimit(3...10)
                    .onChange(of: nativeText) { newValue in
                        updateOption()
                        scheduleTranslation()
                    }
            }

            // 학습 언어 텍스트
            VStack(alignment: .leading, spacing: 4) {
                Text(learningLanguageLabel)
                    .font(.caption2)
                    .foregroundColor(.secondary)

                TextField(learningPlaceholder, text: $learningText, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .lineLimit(3...10)
                    .onChange(of: learningText) { _ in
                        userEditedTranslation = true
                        updateOption()
                    }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }

    private func updateOption() {
        let updated = TurnOption(
            id: option.id,
            nativeText: nativeText,
            learningText: learningText
        )
        onUpdate(updated)
    }

    private func scheduleTranslation() {
        // 이전 번역 작업 취소
        translationTask?.cancel()

        guard !nativeText.isEmpty else {
            learningText = ""
            isTranslating = false
            return
        }

        // 0.5초 디바운스
        translationTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: 500_000_000)

            guard !Task.isCancelled else { return }

            isTranslating = true
            userEditedTranslation = false

            do {
                let translated = try await TranslationService.shared.translate(
                    text: nativeText,
                    from: nativeLanguage,
                    to: learningLanguage
                )

                guard !Task.isCancelled else { return }

                learningText = translated
                isTranslating = false
                updateOption()
            } catch {
                print("⚠️ [OPTION] 번역 실패: \(error)")
                isTranslating = false
            }
        }
    }

    // MARK: - Localized Labels

    private var optionLabel: String {
        switch nativeLanguage {
        case .korean: return "옵션 \(optionIndex + 1)"
        case .english: return "Option \(optionIndex + 1)"
        case .japanese: return "オプション \(optionIndex + 1)"
        case .chinese: return "选项 \(optionIndex + 1)"
        case .spanish: return "Opción \(optionIndex + 1)"
        case .indonesian: return "Opsi \(optionIndex + 1)"
        }
    }

    private var nativeLanguageLabel: String {
        switch nativeLanguage {
        case .korean: return "한국어"
        case .english: return "English"
        case .japanese: return "日本語"
        case .chinese: return "中文"
        case .spanish: return "Español"
        case .indonesian: return "Bahasa Indonesia"
        }
    }

    private var learningLanguageLabel: String {
        switch learningLanguage {
        case .korean: return "한국어"
        case .english: return "English"
        case .japanese: return "日本語"
        case .chinese: return "中文"
        case .spanish: return "Español"
        case .indonesian: return "Bahasa Indonesia"
        }
    }

    private var nativePlaceholder: String {
        switch nativeLanguage {
        case .korean: return "내용을 입력하세요"
        case .english: return "Enter text"
        case .japanese: return "内容を入力"
        case .chinese: return "输入内容"
        case .spanish: return "Ingrese texto"
        case .indonesian: return "Masukkan teks"
        }
    }

    private var learningPlaceholder: String {
        switch nativeLanguage {
        case .korean: return "번역이 자동으로 입력됩니다"
        case .english: return "Translation will appear automatically"
        case .japanese: return "翻訳が自動的に入力されます"
        case .chinese: return "翻译将自动输入"
        case .spanish: return "La traducción aparecerá automáticamente"
        case .indonesian: return "Terjemahan akan muncul secara otomatis"
        }
    }
}

// MARK: - Icon Picker
struct IconPickerView: View {
    @Binding var selectedIcon: String
    @Environment(\.dismiss) var dismiss

    private let icons = [
        "💬", "🗣️", "🎭", "🍜", "🚻", "🏪", "🏥", "🚕",
        "✈️", "🏨", "🍽️", "☕", "📱", "💼", "🎓", "🏋️",
        "🎵", "📚", "🛒", "💰", "🎁", "🌆", "🏖️", "🎪"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 60))
                ], spacing: 16) {
                    ForEach(icons, id: \.self) { icon in
                        Button(action: {
                            selectedIcon = icon
                            dismiss()
                        }) {
                            Text(icon)
                                .font(.system(size: 40))
                                .frame(width: 60, height: 60)
                                .background(
                                    selectedIcon == icon ?
                                    Color.blue.opacity(0.2) :
                                    Color(.systemGray6)
                                )
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Select Icon")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Translation Modifier
struct TranslationModifier: ViewModifier {
    let nativeLanguage: Language
    let learningLanguage: Language

    func body(content: Content) -> some View {
        if #available(iOS 18.0, *) {
            content
                .translationTask(
                    source: Locale.Language(identifier: TranslationService.shared.languageCode(for: nativeLanguage)),
                    target: Locale.Language(identifier: TranslationService.shared.languageCode(for: learningLanguage))
                ) { session in
                    TranslationService.shared.setSession(session, from: nativeLanguage, to: learningLanguage)
                }
        } else {
            content
        }
    }
}

#Preview {
    ScenarioCreationView(nativeLanguage: .korean, learningLanguage: .english)
}
