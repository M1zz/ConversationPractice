import SwiftUI

struct ScenarioImportView: View {
    let nativeLanguage: Language
    let learningLanguage: Language

    @Environment(\.dismiss) var dismiss
    @StateObject private var scenarioManager = CustomScenarioManager.shared

    @State private var selectedTab = 0
    @State private var situation = ""
    @State private var generatedPrompt = ""
    @State private var jsonInput = ""
    @State private var showCopiedAlert = false
    @State private var importError: String?
    @State private var showImportSuccess = false

    // Preview
    @State private var previewTitle = ""
    @State private var previewDescription = ""
    @State private var previewIcon = ""
    @State private var previewTurns: [TurnData] = []
    @State private var showPreview = false

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                // Tab 1: 프롬프트 생성
                promptGenerationTab
                    .tabItem {
                        Label(promptTabLabel, systemImage: "wand.and.stars")
                    }
                    .tag(0)

                // Tab 2: JSON 가져오기
                jsonImportTab
                    .tabItem {
                        Label(importTabLabel, systemImage: "square.and.arrow.down")
                    }
                    .tag(1)
            }
            .navigationTitle(importScenarioLabel)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(closeLabel) {
                        dismiss()
                    }
                }
            }
            .alert(copiedLabel, isPresented: $showCopiedAlert) {
                Button("OK") { }
            } message: {
                Text(copiedMessageLabel)
            }
            .alert(successLabel, isPresented: $showImportSuccess) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text(importSuccessLabel)
            }
        }
    }

    // MARK: - Tab 1: 프롬프트 생성
    private var promptGenerationTab: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 설명
                VStack(alignment: .leading, spacing: 8) {
                    Text(howToUseLabel)
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(0..<5) { index in
                            HStack(alignment: .top, spacing: 8) {
                                Text("\(index + 1).")
                                    .foregroundColor(.secondary)
                                Text(stepLabel(for: index))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // 상황 입력
                VStack(alignment: .leading, spacing: 8) {
                    Text(situationLabel)
                        .font(.headline)

                    TextField(situationPlaceholder, text: $situation, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3...5)
                }

                // 생성 버튼
                Button(action: generatePrompt) {
                    HStack {
                        Image(systemName: "wand.and.stars")
                        Text(generatePromptLabel)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(situation.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(situation.isEmpty)

                // 생성된 프롬프트
                if !generatedPrompt.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(generatedPromptLabel)
                                .font(.headline)
                            Spacer()
                            Button(action: copyPrompt) {
                                HStack {
                                    Image(systemName: "doc.on.doc")
                                    Text(copyLabel)
                                }
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }

                        ScrollView {
                            Text(generatedPrompt)
                                .font(.caption)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        }
                        .frame(height: 200)
                    }
                }
            }
            .padding()
        }
    }

    // MARK: - Tab 2: JSON 가져오기
    private var jsonImportTab: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 설명
                VStack(alignment: .leading, spacing: 8) {
                    Text(pasteJsonLabel)
                        .font(.headline)

                    Text(pasteJsonDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // JSON 입력
                VStack(alignment: .leading, spacing: 8) {
                    Text("JSON")
                        .font(.headline)

                    TextEditor(text: $jsonInput)
                        .font(.system(.caption, design: .monospaced))
                        .frame(minHeight: 200)
                        .padding(4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }

                // 에러 표시
                if let error = importError {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
                }

                // 미리보기
                if showPreview {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(previewLabel)
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(previewIcon)
                                    .font(.system(size: 30))
                                VStack(alignment: .leading) {
                                    Text(previewTitle)
                                        .font(.headline)
                                    Text(previewDescription)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }

                            Divider()

                            Text("\(previewTurns.count) \(turnsLabel)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }

                // 버튼들
                HStack(spacing: 12) {
                    Button(action: parseJSON) {
                        HStack {
                            Image(systemName: "eye")
                            Text(previewLabel)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(jsonInput.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(jsonInput.isEmpty)

                    if showPreview {
                        Button(action: importScenario) {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                Text(importLabel)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
        }
    }

    // MARK: - Actions

    private func generatePrompt() {
        generatedPrompt = ScenarioImporter.generatePrompt(
            situation: situation,
            nativeLanguage: nativeLanguage,
            learningLanguage: learningLanguage
        )
    }

    private func copyPrompt() {
        UIPasteboard.general.string = generatedPrompt
        showCopiedAlert = true
    }

    private func parseJSON() {
        importError = nil
        showPreview = false

        do {
            let result = try ScenarioImporter.importFromJSON(
                jsonInput,
                nativeLanguage: nativeLanguage,
                learningLanguage: learningLanguage
            )

            previewTitle = result.title
            previewDescription = result.description
            previewIcon = result.icon
            previewTurns = result.turns
            showPreview = true
        } catch let error as ScenarioImporter.ImportError {
            importError = error.errorDescription
        } catch {
            importError = error.localizedDescription
        }
    }

    private func importScenario() {
        let turns = previewTurns.map { turnData in
            let textOptions = turnData.options.map { option in
                ConversationTurn.TextOption(
                    nativeText: option.nativeText,
                    learningText: option.learningText
                )
            }

            return ConversationTurn(
                speaker: turnData.speaker,
                textOptions: textOptions
            )
        }

        let scenario = CustomScenario(
            nativeLanguage: nativeLanguage,
            learningLanguage: learningLanguage,
            icon: previewIcon,
            title: previewTitle,
            description: previewDescription,
            conversationTurns: turns
        )

        scenarioManager.saveScenario(scenario)
        showImportSuccess = true
    }

    // MARK: - Localized Strings

    private var importScenarioLabel: String {
        switch nativeLanguage {
        case .korean: return "시나리오 가져오기"
        case .english: return "Import Scenario"
        case .japanese: return "シナリオをインポート"
        case .chinese: return "导入场景"
        case .spanish: return "Importar escenario"
        case .indonesian: return "Impor Skenario"
        default: return "Import Scenario"  // Fallback to English for new languages
        }
    }

    private var promptTabLabel: String {
        switch nativeLanguage {
        case .korean: return "프롬프트 생성"
        case .english: return "Generate Prompt"
        case .japanese: return "プロンプト生成"
        case .chinese: return "生成提示"
        case .spanish: return "Generar prompt"
        case .indonesian: return "Buat Prompt"
        default: return "Generate Prompt"
        }
    }

    private var importTabLabel: String {
        switch nativeLanguage {
        case .korean: return "JSON 가져오기"
        case .english: return "Import JSON"
        case .japanese: return "JSONインポート"
        case .chinese: return "导入JSON"
        case .spanish: return "Importar JSON"
        case .indonesian: return "Impor JSON"
        default: return "Import JSON"
        }
    }

    private var closeLabel: String {
        switch nativeLanguage {
        case .korean: return "닫기"
        case .english: return "Close"
        case .japanese: return "閉じる"
        case .chinese: return "关闭"
        case .spanish: return "Cerrar"
        case .indonesian: return "Tutup"
        default: return "Close"
        }
    }

    private var howToUseLabel: String {
        switch nativeLanguage {
        case .korean: return "사용 방법"
        case .english: return "How to Use"
        case .japanese: return "使い方"
        case .chinese: return "使用方法"
        case .spanish: return "Cómo usar"
        case .indonesian: return "Cara Menggunakan"
        default: return "How to Use"
        }
    }

    private func stepLabel(for index: Int) -> String {
        switch nativeLanguage {
        case .korean:
            let steps = [
                "아래에 상황을 입력하세요 (예: 식당에서 주문할 때)",
                "'프롬프트 생성' 버튼을 눌러 GPT용 프롬프트를 만드세요",
                "'복사' 버튼으로 프롬프트를 클립보드에 복사하세요",
                "ChatGPT에 붙여넣고 JSON 결과를 받으세요",
                "'JSON 가져오기' 탭에서 결과를 붙여넣으세요"
            ]
            return steps[index]
        case .english:
            let steps = [
                "Enter a situation below (e.g., ordering at a restaurant)",
                "Click 'Generate Prompt' to create a GPT prompt",
                "Use 'Copy' button to copy the prompt",
                "Paste in ChatGPT and get JSON result",
                "Paste the result in 'Import JSON' tab"
            ]
            return steps[index]
        case .japanese:
            let steps = [
                "状況を入力してください（例：レストランで注文）",
                "「プロンプト生成」でGPT用プロンプトを作成",
                "「コピー」ボタンでプロンプトをコピー",
                "ChatGPTに貼り付けてJSON結果を取得",
                "「JSONインポート」タブに結果を貼り付け"
            ]
            return steps[index]
        case .chinese:
            let steps = [
                "输入场景（例如：在餐厅点餐）",
                "点击\"生成提示\"创建GPT提示",
                "使用\"复制\"按钮复制提示",
                "粘贴到ChatGPT并获取JSON结果",
                "在\"导入JSON\"标签中粘贴结果"
            ]
            return steps[index]
        case .spanish:
            let steps = [
                "Ingrese una situación (ej: pedir en restaurante)",
                "Haga clic en 'Generar prompt' para crear prompt",
                "Use 'Copiar' para copiar el prompt",
                "Pegue en ChatGPT y obtenga resultado JSON",
                "Pegue el resultado en pestaña 'Importar JSON'"
            ]
            return steps[index]
        case .indonesian:
            let steps = [
                "Masukkan situasi (mis: memesan di restoran)",
                "Klik 'Buat Prompt' untuk membuat prompt GPT",
                "Gunakan tombol 'Salin' untuk menyalin prompt",
                "Tempel di ChatGPT dan dapatkan hasil JSON",
                "Tempel hasil di tab 'Impor JSON'"
            ]
            return steps[index]
        default:
            let steps = [
                "Enter a situation below (e.g., ordering at a restaurant)",
                "Click 'Generate Prompt' to create a GPT prompt",
                "Use 'Copy' button to copy the prompt",
                "Paste in ChatGPT and get JSON result",
                "Paste the result in 'Import JSON' tab"
            ]
            return steps[index]
        }
    }

    private var situationLabel: String {
        switch nativeLanguage {
        case .korean: return "상황 입력"
        case .english: return "Enter Situation"
        case .japanese: return "状況を入力"
        case .chinese: return "输入场景"
        case .spanish: return "Ingrese situación"
        case .indonesian: return "Masukkan Situasi"
        default: return "Enter Situation"
        }
    }

    private var situationPlaceholder: String {
        switch nativeLanguage {
        case .korean: return "예: 식당에서 음식 주문하기"
        case .english: return "e.g., Ordering food at a restaurant"
        case .japanese: return "例：レストランで料理を注文する"
        case .chinese: return "例如：在餐厅点餐"
        case .spanish: return "ej: Pedir comida en un restaurante"
        case .indonesian: return "mis: Memesan makanan di restoran"
        default: return "e.g., Ordering food at a restaurant"
        }
    }

    private var generatePromptLabel: String {
        switch nativeLanguage {
        case .korean: return "프롬프트 생성"
        case .english: return "Generate Prompt"
        case .japanese: return "プロンプト生成"
        case .chinese: return "生成提示"
        case .spanish: return "Generar prompt"
        case .indonesian: return "Buat Prompt"
        default: return "Generate Prompt"
        }
    }

    private var generatedPromptLabel: String {
        switch nativeLanguage {
        case .korean: return "생성된 프롬프트"
        case .english: return "Generated Prompt"
        case .japanese: return "生成されたプロンプト"
        case .chinese: return "生成的提示"
        case .spanish: return "Prompt generado"
        case .indonesian: return "Prompt yang Dibuat"
        default: return "Generated Prompt"
        }
    }

    private var copyLabel: String {
        switch nativeLanguage {
        case .korean: return "복사"
        case .english: return "Copy"
        case .japanese: return "コピー"
        case .chinese: return "复制"
        case .spanish: return "Copiar"
        case .indonesian: return "Salin"
        default: return "Copy"
        }
    }

    private var copiedLabel: String {
        switch nativeLanguage {
        case .korean: return "복사 완료"
        case .english: return "Copied"
        case .japanese: return "コピー完了"
        case .chinese: return "已复制"
        case .spanish: return "Copiado"
        case .indonesian: return "Disalin"
        default: return "Copied"
        }
    }

    private var copiedMessageLabel: String {
        switch nativeLanguage {
        case .korean: return "프롬프트가 클립보드에 복사되었습니다"
        case .english: return "Prompt copied to clipboard"
        case .japanese: return "プロンプトがクリップボードにコピーされました"
        case .chinese: return "提示已复制到剪贴板"
        case .spanish: return "Prompt copiado al portapapeles"
        case .indonesian: return "Prompt disalin ke clipboard"
        default: return "Prompt copied to clipboard"
        }
    }

    private var pasteJsonLabel: String {
        switch nativeLanguage {
        case .korean: return "JSON 붙여넣기"
        case .english: return "Paste JSON"
        case .japanese: return "JSONを貼り付け"
        case .chinese: return "粘贴JSON"
        case .spanish: return "Pegar JSON"
        case .indonesian: return "Tempel JSON"
        default: return "Paste JSON"
        }
    }

    private var pasteJsonDescription: String {
        switch nativeLanguage {
        case .korean: return "ChatGPT에서 받은 JSON을 아래에 붙여넣으세요"
        case .english: return "Paste the JSON you received from ChatGPT below"
        case .japanese: return "ChatGPTから受け取ったJSONを下に貼り付けてください"
        case .chinese: return "将从ChatGPT收到的JSON粘贴到下面"
        case .spanish: return "Pegue el JSON que recibió de ChatGPT a continuación"
        case .indonesian: return "Tempel JSON yang Anda terima dari ChatGPT di bawah"
        default: return "Paste the JSON you received from ChatGPT below"
        }
    }

    private var previewLabel: String {
        switch nativeLanguage {
        case .korean: return "미리보기"
        case .english: return "Preview"
        case .japanese: return "プレビュー"
        case .chinese: return "预览"
        case .spanish: return "Vista previa"
        case .indonesian: return "Pratinjau"
        default: return "Preview"
        }
    }

    private var turnsLabel: String {
        switch nativeLanguage {
        case .korean: return "턴"
        case .english: return "turns"
        case .japanese: return "ターン"
        case .chinese: return "轮"
        case .spanish: return "turnos"
        case .indonesian: return "giliran"
        default: return "turns"
        }
    }

    private var importLabel: String {
        switch nativeLanguage {
        case .korean: return "가져오기"
        case .english: return "Import"
        case .japanese: return "インポート"
        case .chinese: return "导入"
        case .spanish: return "Importar"
        case .indonesian: return "Impor"
        default: return "Import"
        }
    }

    private var successLabel: String {
        switch nativeLanguage {
        case .korean: return "성공"
        case .english: return "Success"
        case .japanese: return "成功"
        case .chinese: return "成功"
        case .spanish: return "Éxito"
        case .indonesian: return "Berhasil"
        default: return "Success"
        }
    }

    private var importSuccessLabel: String {
        switch nativeLanguage {
        case .korean: return "시나리오를 성공적으로 가져왔습니다!"
        case .english: return "Scenario imported successfully!"
        case .japanese: return "シナリオが正常にインポートされました！"
        case .chinese: return "场景导入成功！"
        case .spanish: return "¡Escenario importado exitosamente!"
        case .indonesian: return "Skenario berhasil diimpor!"
        default: return "Scenario imported successfully!"
        }
    }
}

#Preview {
    ScenarioImportView(nativeLanguage: .korean, learningLanguage: .english)
}
