import SwiftUI

struct LanguageSelectionView: View {
    var body: some View {
        VStack(spacing: 24) {
                // 헤더 - 모든 언어로 표시
                VStack(spacing: 12) {
                    Text("Select Your Language")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("모국어를 선택하세요")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)

                // 언어 목록
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(Language.allCases) { language in
                        NavigationLink(destination: LearningLanguageSelectionView(nativeLanguage: language)) {
                            LanguageCard(language: language)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
    }
}

// MARK: - 언어 카드
struct LanguageCard: View {
    let language: Language

    var body: some View {
        VStack(spacing: 12) {
            Text(language.flag)
                .font(.system(size: 50))

            Text(language.displayName)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationView {
        LanguageSelectionView()
    }
}
