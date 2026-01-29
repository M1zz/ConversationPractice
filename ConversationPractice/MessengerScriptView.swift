import SwiftUI

// MARK: - Messenger Script View
struct MessengerScriptView: View {
    let scenario: Scenario
    let nativeLanguage: Language
    let learningLanguage: Language

    @State private var showTranslations = true
    @Environment(\.dismiss) private var dismiss

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    // Flatten conversation tree into linear messages
    private var messages: [MessageItem] {
        var result: [MessageItem] = []

        // Add starting phrase
        result.append(MessageItem(
            id: "start",
            speaker: .user,
            text: scenario.startingPhrase,
            translation: scenario.getStartingPhraseTranslation(for: nativeLanguage)
        ))

        // Flatten the tree by taking the first option at each branch
        flattenTree(nodes: scenario.conversationTree, into: &result)

        return result
    }

    private func flattenTree(nodes: [ConversationNode], into result: inout [MessageItem]) {
        for node in nodes {
            result.append(MessageItem(
                id: node.id,
                speaker: node.speaker,
                text: node.text,
                translation: node.translation(for: nativeLanguage)
            ))

            // Take first response option if available
            if let responses = node.responses, !responses.isEmpty {
                flattenTree(nodes: [responses[0]], into: &result)
            }
        }
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    HStack {
                        Text(scenario.icon)
                            .font(.system(size: 40))

                        VStack(alignment: .leading, spacing: 4) {
                            Text(scenario.getTitle(for: nativeLanguage))
                                .font(.headline)

                            Text(scenario.getDescription(for: nativeLanguage))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                }

                // Messages
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(messages) { message in
                            MessageBubbleView(
                                message: message,
                                showTranslation: showTranslations
                            )
                            .padding(.bottom, 12)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(closeLabel) {
                    dismiss()
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showTranslations.toggle()
                }) {
                    Image(systemName: showTranslations ? "eye.fill" : "eye.slash.fill")
                }
            }
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
}

// MARK: - Message Item
struct MessageItem: Identifiable {
    let id: String
    let speaker: ConversationNode.Speaker
    let text: String
    let translation: String?
}

// MARK: - Message Bubble View
struct MessageBubbleView: View {
    let message: MessageItem
    let showTranslation: Bool

    private var isUser: Bool {
        message.speaker == .user
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
                Text(isUser ? speakerLabel.me : speakerLabel.partner)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 4)

                // 메시지 내용
                VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                    // Main text
                    Text(message.text)
                        .font(.body)
                        .foregroundColor(isUser ? .white : .primary)

                    // Translation
                    if showTranslation, let translation = message.translation {
                        Text(translation)
                            .font(.caption)
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
                .cornerRadius(18)
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
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

    private var speakerLabel: (me: String, partner: String) {
        // 간단하게 영어로 고정 (또는 LocalizedText 사용 가능)
        return (me: "Me", partner: "Partner")
    }
}

#Preview {
    NavigationStack {
        MessengerScriptView(
            scenario: Scenario(
                id: "preview",
                learningLanguage: .indonesian,
                category: .basic,
                icon: "👋",
                title: [.korean: "인사하기", .english: "Greeting"],
                description: [.korean: "기본 인사", .english: "Basic greeting"],
                startingPhrase: "Halo!",
                startingPhraseTranslations: [.korean: "안녕하세요!", .english: "Hello!"],
                conversationTree: [
                    ConversationNode(
                        id: "1",
                        speaker: .native,
                        text: "Halo! Apa kabar?",
                        translations: [.korean: "안녕하세요! 어떻게 지내세요?", .english: "Hello! How are you?"],
                        responses: [
                            ConversationNode(
                                id: "2",
                                speaker: .user,
                                text: "Baik, terima kasih!",
                                translations: [.korean: "좋아요, 감사합니다!", .english: "Good, thank you!"],
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
}
