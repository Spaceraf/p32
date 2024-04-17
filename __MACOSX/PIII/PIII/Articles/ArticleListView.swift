import SwiftUI
import FirebaseFirestore

struct ArticleListView: View {
    @State private var articles: [Article] = []
    
    var body: some View {
        List(articles) { article in
            NavigationLink(destination: ArticleDetailView(article: article)) {
                Text(article.title)
            }
        }
        .onAppear(perform: fetchArticles)
        .navigationTitle("Articles")
    }

    private func fetchArticles() {
        let db = Firestore.firestore()
        db.collection("articles").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                articles = querySnapshot?.documents.compactMap { document -> Article? in
                    try? document.data(as: Article.self)
                } ?? []
            }
        }
    }
}
