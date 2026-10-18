
import SwiftUI

@main
struct KalamEKHUDAApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0

    private let books = [
        ("پیدائش", "Genesis"),
        ("خروج", "Exodus"),
        ("احبار", "Leviticus"),
        ("گنتی", "Numbers"),
        ("استثنا", "Deuteronomy"),
        ("زبور", "Psalms"),
        ("متی", "Matthew"),
        ("مرقس", "Mark"),
        ("لوقا", "Luke"),
        ("یوحنا", "John"),
        ("رومیوں", "Romans"),
        ("مکاشفہ", "Revelation")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.97, green: 0.95, blue: 0.91)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    header

                    ScrollView {
                        VStack(alignment: .trailing, spacing: 20) {
                            welcomeCard

                            Text("کتابِ مقدس")
                                .font(.system(size: 25, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundStyle(Color(red: 0.28, green: 0.18, blue: 0.15))

                            Text("پرانا عہد نامہ اور نیا عہد نامہ")
                                .font(.system(size: 15))
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .trailing)

                            ForEach(filteredBooks, id: \.1) { book in
                                NavigationLink {
                                    BookView(
                                        urduName: book.0,
                                        englishName: book.1
                                    )
                                } label: {
                                    HStack {
                                        Image(systemName: "book.closed")
                                            .font(.title3)
                                            .foregroundStyle(
                                                Color(red: 0.48, green: 0.24, blue: 0.18)
                                            )

                                        Spacer()

                                        VStack(alignment: .trailing, spacing: 5) {
                                            Text(book.0)
                                                .font(.system(size: 20, weight: .semibold))
                                                .foregroundStyle(.primary)

                                            Text(book.1)
                                                .font(.system(size: 13))
                                                .foregroundStyle(.secondary)
                                        }

                                        Image(systemName: "chevron.left")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(16)
                                    .background(.white.opacity(0.9))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(20)
                    }

                    bottomBar
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .tint(Color(red: 0.48, green: 0.24, blue: 0.18))
    }

    private var filteredBooks: [(String, String)] {
        guard !searchText.isEmpty else { return books }
        return books.filter {
            $0.0.localizedCaseInsensitiveContains(searchText) ||
            $0.1.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: "text.book.closed.fill")
                .font(.title2)
                .foregroundStyle(.white)

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("کلامِ خدا")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundStyle(.white)

                Text("اردو بائبل")
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
        .padding(20)
        .background(Color(red: 0.35, green: 0.17, blue: 0.15))
    }

    private var welcomeCard: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Text("خدا کے کلام میں خوش آمدید")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)

            Text("اپنے مطالعہ کا سفر شروع کریں")
                .font(.system(size: 16))
                .foregroundStyle(.white.opacity(0.9))

            HStack {
                Image(systemName: "magnifyingglass")
                TextField("کتاب تلاش کریں", text: $searchText)
                    .multilineTextAlignment(.trailing)
            }
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .foregroundStyle(.primary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.48, green: 0.24, blue: 0.18),
                    Color(red: 0.26, green: 0.13, blue: 0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var bottomBar: some View {
        HStack {
            tabItem("کتابیں", icon: "books.vertical", index: 0)
            Spacer()
            tabItem("پسندیدہ", icon: "heart", index: 1)
            Spacer()
            tabItem("مطالعہ", icon: "bookmark", index: 2)
            Spacer()
            tabItem("ترتیبات", icon: "gearshape", index: 3)
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 14)
        .background(.white)
    }

    private func tabItem(
        _ title: String,
        icon: String,
        index: Int
    ) -> some View {
        Button {
            selectedTab = index
        } label: {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 19))
                Text(title)
                    .font(.system(size: 11))
            }
            .foregroundStyle(
                selectedTab == index
                ? Color(red: 0.48, green: 0.24, blue: 0.18)
                : .gray
            )
        }
    }
}

struct BookView: View {
    let urduName: String
    let englishName: String

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "book.closed.fill")
                .font(.system(size: 48))
                .foregroundStyle(.brown)

            Text(urduName)
                .font(.system(size: 30, weight: .bold))

            Text(englishName)
                .font(.title3)
                .foregroundStyle(.secondary)

            Text("کتاب کا مکمل متن لائسنس یافتہ بائبل فائل شامل کرنے کے بعد دستیاب ہوگا۔")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.97, green: 0.95, blue: 0.91))
        .navigationTitle(urduName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
