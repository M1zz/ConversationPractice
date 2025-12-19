import SwiftUI

// MARK: - Display Mode
enum ScriptDisplayMode: String, CaseIterable {
    case both = "both"
    case learningOnly = "learning"
    case nativeOnly = "native"

    var next: ScriptDisplayMode {
        let all = ScriptDisplayMode.allCases
        let currentIndex = all.firstIndex(of: self) ?? 0
        let nextIndex = (currentIndex + 1) % all.count
        return all[nextIndex]
    }
}

// MARK: - Script Viewer Main View
struct ScriptViewerView: View {
    let scenario: Scenario
    let nativeLanguage: Language
    let learningLanguage: Language

    @State private var displayMode: ScriptDisplayMode = .both
    @State private var expandedNodes: Set<String> = []
    @Environment(\.dismiss) private var dismiss

    private var displayModeIcon: String {
        switch displayMode {
        case .both: return "textformat"
        case .learningOnly: return "a.square"
        case .nativeOnly: return "textformat.abc"
        }
    }

    private var displayModeLabel: String {
        switch displayMode {
        case .both: return localizedText.bothLabel
        case .learningOnly: return localizedText.learningOnlyLabel
        case .nativeOnly: return localizedText.nativeOnlyLabel
        }
    }

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Scenario Header
                    ScriptHeaderView(
                        icon: scenario.icon,
                        title: scenario.getTitle(for: nativeLanguage),
                        description: scenario.getDescription(for: nativeLanguage)
                    )

                    // Starting Phrase Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text(localizedText.startingPhraseLabel)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 16)

                        ScriptNodeView(
                            speaker: .user,
                            learningText: scenario.startingPhrase,
                            nativeText: scenario.getStartingPhraseTranslation(for: nativeLanguage),
                            displayMode: displayMode,
                            depth: 0
                        )
                    }

                    // Conversation Tree
                    if scenario.conversationTree.isEmpty {
                        Text(localizedText.noConversationData)
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(localizedText.conversationFlowLabel)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 16)

                            ConversationTreeView(
                                nodes: scenario.conversationTree,
                                nativeLanguage: nativeLanguage,
                                displayMode: displayMode,
                                expandedNodes: $expandedNodes,
                                depth: 0
                            )
                        }
                    }
                }
                .padding(.vertical)
            }
            .onAppear {
                expandAllNodes()
            }
            .navigationTitle(localizedText.scriptViewerTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(localizedText.closeLabel) {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 12) {
                        // Display mode toggle
                        Button(action: {
                            displayMode = displayMode.next
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: displayModeIcon)
                                Text(displayModeLabel)
                                    .font(.caption)
                            }
                            .foregroundColor(.blue)
                        }

                        // Expand/Collapse all
                        Button(action: toggleAllNodes) {
                            Image(systemName: expandedNodes.isEmpty ? "arrow.down.circle" : "arrow.up.circle")
                        }
                    }
                }
            }
        }
    }

    private func toggleAllNodes() {
        if expandedNodes.isEmpty {
            // Expand all
            expandAllNodes()
        } else {
            // Collapse all
            expandedNodes.removeAll()
        }
    }

    private func expandAllNodes() {
        var allNodeIds: Set<String> = []

        func collectNodeIds(from nodes: [ConversationNode]) {
            for node in nodes {
                allNodeIds.insert(node.id)
                if let responses = node.responses {
                    collectNodeIds(from: responses)
                }
            }
        }

        collectNodeIds(from: scenario.conversationTree)
        expandedNodes = allNodeIds
    }
}

// MARK: - Script Header View
struct ScriptHeaderView: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: 12) {
            Text(icon)
                .font(.system(size: 60))

            Text(title)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// MARK: - Branch Indicator View
struct BranchIndicatorView: View {
    let current: Int
    let total: Int

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "arrow.triangle.branch")
                .font(.caption2)
            Text("Branch \(current) of \(total)")
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(.orange)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.orange.opacity(0.1))
        .cornerRadius(6)
    }
}

// MARK: - Script Node View
struct ScriptNodeView: View {
    let speaker: ConversationNode.Speaker
    let learningText: String
    let nativeText: String?
    let displayMode: ScriptDisplayMode
    let depth: Int

    private var speakerIcon: String {
        speaker == .user ? "person.circle.fill" : "person.2.circle.fill"
    }

    private var speakerColor: Color {
        speaker == .user ? .blue : .green
    }

    private var backgroundColor: Color {
        speakerColor.opacity(0.1)
    }

    private var speakerLabel: String {
        speaker == .user ? "User" : "AI"
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Connection line indicator (visual depth)
            if depth > 0 {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 2)
                    .padding(.leading, CGFloat(depth - 1) * 20)
            }

            VStack(alignment: .leading, spacing: 8) {
                // Speaker label with icon
                HStack(spacing: 6) {
                    Image(systemName: speakerIcon)
                        .font(.caption)
                        .foregroundColor(speakerColor)

                    Text(speakerLabel)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(speakerColor)
                }

                // Message content based on display mode
                VStack(alignment: .leading, spacing: 4) {
                    switch displayMode {
                    case .both:
                        Text(learningText)
                            .font(.body)
                        if let nativeText = nativeText {
                            Text(nativeText)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    case .learningOnly:
                        Text(learningText)
                            .font(.body)
                            .fontWeight(.semibold)
                    case .nativeOnly:
                        if let nativeText = nativeText {
                            Text(nativeText)
                                .font(.body)
                                .fontWeight(.semibold)
                        } else {
                            Text(learningText)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .cornerRadius(10)
            .padding(.leading, CGFloat(depth) * 20)
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Conversation Tree View (Recursive)
struct ConversationTreeView: View {
    let nodes: [ConversationNode]
    let nativeLanguage: Language
    let displayMode: ScriptDisplayMode
    @Binding var expandedNodes: Set<String>
    let depth: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(Array(nodes.enumerated()), id: \.element.id) { index, node in
                VStack(alignment: .leading, spacing: 8) {
                    // Show branch indicator if multiple options
                    if nodes.count > 1 {
                        BranchIndicatorView(current: index + 1, total: nodes.count)
                            .padding(.leading, CGFloat(depth) * 20 + 16)
                    }

                    // Node content with expand/collapse button
                    HStack(alignment: .top, spacing: 0) {
                        ScriptNodeView(
                            speaker: node.speaker,
                            learningText: node.text,
                            nativeText: node.translation(for: nativeLanguage),
                            displayMode: displayMode,
                            depth: depth
                        )

                        // Expand/collapse button if has responses
                        if let responses = node.responses, !responses.isEmpty {
                            Button(action: {
                                toggleNode(node.id)
                            }) {
                                Image(systemName: expandedNodes.contains(node.id) ? "chevron.down.circle.fill" : "chevron.right.circle")
                                    .foregroundColor(.gray)
                                    .font(.title3)
                            }
                            .padding(.trailing, 16)
                            .padding(.top, 12)
                        }
                    }

                    // Recursively show responses if expanded
                    if let responses = node.responses,
                       !responses.isEmpty,
                       expandedNodes.contains(node.id) {

                        // Show "Option X" label if multiple response options
                        if responses.count > 1 {
                            ForEach(Array(responses.enumerated()), id: \.element.id) { optionIndex, response in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(spacing: 4) {
                                        Text("Option \(optionIndex + 1)")
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.purple)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.purple.opacity(0.1))
                                    .cornerRadius(6)
                                    .padding(.leading, CGFloat(depth + 1) * 20 + 16)

                                    ConversationTreeView(
                                        nodes: [response],
                                        nativeLanguage: nativeLanguage,
                                        displayMode: displayMode,
                                        expandedNodes: $expandedNodes,
                                        depth: depth + 1
                                    )
                                }
                            }
                        } else {
                            ConversationTreeView(
                                nodes: responses,
                                nativeLanguage: nativeLanguage,
                                displayMode: displayMode,
                                expandedNodes: $expandedNodes,
                                depth: depth + 1
                            )
                        }
                    }
                }
            }
        }
    }

    private func toggleNode(_ nodeId: String) {
        if expandedNodes.contains(nodeId) {
            expandedNodes.remove(nodeId)
        } else {
            expandedNodes.insert(nodeId)
        }
    }
}

// MARK: - Localized Strings Extension
extension LocalizedText {
    var scriptViewerTitle: String {
        switch nativeLanguage {
        case .korean: return "스크립트 보기"
        case .english: return "Script Viewer"
        case .japanese: return "スクリプトビューア"
        case .chinese: return "脚本查看器"
        case .spanish: return "Visor de guión"
        case .indonesian: return "Tampilan Skrip"
        default: return "Script Viewer"
        }
    }

    var closeLabel: String {
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

    var bothLabel: String {
        switch nativeLanguage {
        case .korean: return "둘 다"
        case .english: return "Both"
        case .japanese: return "両方"
        case .chinese: return "都显示"
        case .spanish: return "Ambos"
        case .indonesian: return "Keduanya"
        default: return "Both"
        }
    }

    var learningOnlyLabel: String {
        switch nativeLanguage {
        case .korean: return "학습어"
        case .english: return "Learning"
        case .japanese: return "学習言語"
        case .chinese: return "学习语言"
        case .spanish: return "Aprendizaje"
        case .indonesian: return "Bahasa Belajar"
        default: return "Learning"
        }
    }

    var nativeOnlyLabel: String {
        switch nativeLanguage {
        case .korean: return "모국어"
        case .english: return "Native"
        case .japanese: return "母国語"
        case .chinese: return "母语"
        case .spanish: return "Nativo"
        case .indonesian: return "Bahasa Ibu"
        default: return "Native"
        }
    }

    var startingPhraseLabel: String {
        switch nativeLanguage {
        case .korean: return "시작 문장"
        case .english: return "Starting Phrase"
        case .japanese: return "開始フレーズ"
        case .chinese: return "开始短语"
        case .spanish: return "Frase inicial"
        case .indonesian: return "Frasa Awal"
        default: return "Starting Phrase"
        }
    }

    var conversationFlowLabel: String {
        switch nativeLanguage {
        case .korean: return "대화 흐름"
        case .english: return "Conversation Flow"
        case .japanese: return "会話の流れ"
        case .chinese: return "对话流程"
        case .spanish: return "Flujo de conversación"
        case .indonesian: return "Alur Percakapan"
        default: return "Conversation Flow"
        }
    }

    var noConversationData: String {
        switch nativeLanguage {
        case .korean: return "대화 데이터가 없습니다"
        case .english: return "No conversation data available"
        case .japanese: return "会話データがありません"
        case .chinese: return "无对话数据"
        case .spanish: return "No hay datos de conversación disponibles"
        case .indonesian: return "Tidak ada data percakapan"
        default: return "No conversation data available"
        }
    }
}

#Preview {
    ScriptViewerView(
        scenario: Scenario(
            id: "preview",
            learningLanguage: .indonesian,
            category: .basic,
            icon: "🚻",
            title: [.korean: "화장실 찾기", .english: "Finding Bathroom"],
            description: [.korean: "화장실 위치 물어보기", .english: "Ask for bathroom"],
            startingPhrase: "Di mana toilet?",
            startingPhraseTranslations: [.korean: "화장실이 어디에요?", .english: "Where is the bathroom?"],
            conversationTree: [
                ConversationNode(
                    id: "1",
                    speaker: .native,
                    text: "Toilet ada di sebelah kiri.",
                    translations: [.korean: "화장실은 왼쪽에 있어요.", .english: "The bathroom is on the left."],
                    responses: [
                        ConversationNode(
                            id: "2",
                            speaker: .user,
                            text: "Terima kasih!",
                            translations: [.korean: "감사합니다!", .english: "Thank you!"],
                            responses: nil
                        )
                    ]
                )
            ]
        ),
        nativeLanguage: .korean,
        learningLanguage: .indonesian
    )
}
