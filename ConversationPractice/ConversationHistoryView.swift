import SwiftUI

// MARK: - Conversation History View
struct ConversationHistoryView: View {
    let nativeLanguage: Language

    @StateObject private var historyManager = ConversationHistoryManager.shared
    @State private var selectedHistory: ConversationHistory?
    @State private var showingHistoryDetail = false
    @Environment(\.dismiss) private var dismiss

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    var body: some View {
        NavigationView {
            contentView
                .navigationTitle(localizedText.historyLabel)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(localizedText.closeLabel) {
                            dismiss()
                        }
                    }

                    if !historyManager.histories.isEmpty {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(role: .destructive) {
                                historyManager.clearAllHistories()
                            } label: {
                                Text(localizedText.clearAllLabel)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingHistoryDetail) {
                    if let history = selectedHistory {
                        HistoryDetailView(
                            history: history,
                            nativeLanguage: nativeLanguage
                        )
                    }
                }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if historyManager.histories.isEmpty {
            emptyStateView
        } else {
            historyListView
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 60))
                .foregroundColor(.gray)

            Text(localizedText.noHistoryLabel)
                .font(.headline)
                .foregroundColor(.secondary)

            Text(localizedText.noHistoryDescriptionLabel)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }

    private var historyListView: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(historyManager.historiesGroupedByScenario(), id: \.scenarioId) { group in
                    ScenarioGroupView(
                        group: group,
                        nativeLanguage: nativeLanguage,
                        localizedText: localizedText,
                        onHistoryTap: { history in
                            selectedHistory = history
                            showingHistoryDetail = true
                        },
                        onHistoryDelete: { history in
                            historyManager.deleteHistory(history)
                        }
                    )
                }
            }
            .padding()
        }
    }
}

// MARK: - Scenario Group View
struct ScenarioGroupView: View {
    let group: (scenarioId: String, scenarioTitle: [Language: String], scenarioIcon: String, learningLanguage: Language, histories: [ConversationHistory])
    let nativeLanguage: Language
    let localizedText: LocalizedText
    let onHistoryTap: (ConversationHistory) -> Void
    let onHistoryDelete: (ConversationHistory) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Scenario header
            HStack(spacing: 12) {
                Text(group.scenarioIcon)
                    .font(.title2)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(group.scenarioTitle[nativeLanguage] ?? group.scenarioTitle[.english] ?? "")
                            .font(.headline)

                        Text(group.learningLanguage.flag)
                            .font(.caption)
                    }

                    Text("\(group.histories.count) \(localizedText.conversationsLabel)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding(.horizontal)

            // History list for this scenario
            ForEach(group.histories) { history in
                Button(action: {
                    onHistoryTap(history)
                }) {
                    HistoryCardView(
                        history: history,
                        nativeLanguage: nativeLanguage
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        onHistoryDelete(history)
                    } label: {
                        Label(localizedText.deleteLabel, systemImage: "trash")
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - History Card View
struct HistoryCardView: View {
    let history: ConversationHistory
    let nativeLanguage: Language

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: history.date)
    }

    private var conversationLength: Int {
        history.conversationNodes.count
    }

    var body: some View {
        HStack(spacing: 12) {
            // Date badge
            VStack(spacing: 4) {
                Text(dateDay)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(dateMonth)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(width: 50)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                Text(history.getTitle(for: nativeLanguage))
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack(spacing: 8) {
                    Label("\(conversationLength)", systemImage: "bubble.left.and.bubble.right")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(formattedTime)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    }

    private var dateDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: history.date)
    }

    private var dateMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: history.date)
    }

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: history.date)
    }
}

// MARK: - History Detail View
struct HistoryDetailView: View {
    let history: ConversationHistory
    let nativeLanguage: Language

    @State private var displayMode: ScriptDisplayMode = .both
    @Environment(\.dismiss) private var dismiss

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

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

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: history.date)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    VStack(spacing: 12) {
                        Text(history.scenarioIcon)
                            .font(.system(size: 60))

                        Text(history.getTitle(for: nativeLanguage))
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)

                        Text(formattedDate)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Conversation history
                    VStack(alignment: .leading, spacing: 8) {
                        Text(localizedText.conversationLabel)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 16)

                        ForEach(history.conversationNodes) { node in
                            ScriptNodeView(
                                speaker: node.speaker,
                                learningText: node.text,
                                nativeText: node.translation(for: nativeLanguage),
                                displayMode: displayMode,
                                depth: 0
                            )
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle(localizedText.historyDetailLabel)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(localizedText.closeLabel) {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
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
                }
            }
        }
    }
}

// MARK: - Localized Text Extension
extension LocalizedText {
    var historyLabel: String {
        switch nativeLanguage {
        case .korean: return "대화 기록"
        case .english: return "History"
        case .japanese: return "履歴"
        case .chinese: return "历史记录"
        case .spanish: return "Historial"
        case .indonesian: return "Riwayat"
        default: return "History"
        }
    }

    var noHistoryLabel: String {
        switch nativeLanguage {
        case .korean: return "대화 기록이 없습니다"
        case .english: return "No History"
        case .japanese: return "履歴がありません"
        case .chinese: return "没有历史记录"
        case .spanish: return "Sin historial"
        case .indonesian: return "Tidak ada riwayat"
        default: return "No History"
        }
    }

    var noHistoryDescriptionLabel: String {
        switch nativeLanguage {
        case .korean: return "대화를 시작하면 여기에 기록이 저장됩니다"
        case .english: return "Start a conversation and it will be saved here"
        case .japanese: return "会話を始めるとここに記録されます"
        case .chinese: return "开始对话后会保存在这里"
        case .spanish: return "Inicia una conversación y se guardará aquí"
        case .indonesian: return "Mulai percakapan dan akan disimpan di sini"
        default: return "Start a conversation and it will be saved here"
        }
    }

    var conversationsLabel: String {
        switch nativeLanguage {
        case .korean: return "개 대화"
        case .english: return "conversations"
        case .japanese: return "件の会話"
        case .chinese: return "次对话"
        case .spanish: return "conversaciones"
        case .indonesian: return "percakapan"
        default: return "conversations"
        }
    }

    var deleteLabel: String {
        switch nativeLanguage {
        case .korean: return "삭제"
        case .english: return "Delete"
        case .japanese: return "削除"
        case .chinese: return "删除"
        case .spanish: return "Eliminar"
        case .indonesian: return "Hapus"
        default: return "Delete"
        }
    }

    var clearAllLabel: String {
        switch nativeLanguage {
        case .korean: return "전체 삭제"
        case .english: return "Clear All"
        case .japanese: return "すべて削除"
        case .chinese: return "清除全部"
        case .spanish: return "Borrar todo"
        case .indonesian: return "Hapus Semua"
        default: return "Clear All"
        }
    }

    var historyDetailLabel: String {
        switch nativeLanguage {
        case .korean: return "대화 상세"
        case .english: return "Conversation Detail"
        case .japanese: return "会話の詳細"
        case .chinese: return "对话详情"
        case .spanish: return "Detalle de conversación"
        case .indonesian: return "Detail Percakapan"
        default: return "Conversation Detail"
        }
    }

    var conversationLabel: String {
        switch nativeLanguage {
        case .korean: return "대화 내용"
        case .english: return "Conversation"
        case .japanese: return "会話"
        case .chinese: return "对话"
        case .spanish: return "Conversación"
        case .indonesian: return "Percakapan"
        default: return "Conversation"
        }
    }
}

#Preview {
    ConversationHistoryView(nativeLanguage: .korean)
}
