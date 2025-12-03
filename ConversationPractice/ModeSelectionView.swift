import SwiftUI

struct ModeSelectionView: View {
    let nativeLanguage: Language
    let learningLanguage: Language
    @State private var showSettings = false

    private var localizedText: LocalizedText {
        LocalizedText(nativeLanguage: nativeLanguage)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 헤더
                VStack(spacing: 8) {
                    Text(learningLanguage.flag)
                        .font(.system(size: 60))

                    Text("\(learningLanguage.displayName) \(localizedText.practice)")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(localizedText.selectMode)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)

                // 모드 카드들
                ForEach(PracticeMode.allCases) { mode in
                    NavigationLink(destination: destinationView(for: mode)) {
                        ModeCard(mode: mode, nativeLanguage: nativeLanguage)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showSettings = true
                }) {
                    Image(systemName: "gearshape")
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }

    @ViewBuilder
    private func destinationView(for mode: PracticeMode) -> some View {
        switch mode {
        case .freeConversation:
            FreeConversationView(
                nativeLanguage: nativeLanguage,
                learningLanguage: learningLanguage
            )
        case .scenario:
            ContentView(
                nativeLanguage: nativeLanguage,
                learningLanguage: learningLanguage
            )
        case .pronunciation:
            PronunciationPracticeView(
                nativeLanguage: nativeLanguage,
                learningLanguage: learningLanguage
            )
        }
    }
}

// MARK: - 모드 카드
struct ModeCard: View {
    let mode: PracticeMode
    let nativeLanguage: Language

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: mode.icon)
                .font(.system(size: 30))
                .foregroundColor(.blue)
                .frame(width: 60, height: 60)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 4) {
                Text(mode.displayName(for: nativeLanguage))
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(mode.description(for: nativeLanguage))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationView {
        ModeSelectionView(nativeLanguage: .korean, learningLanguage: .english)
    }
}
