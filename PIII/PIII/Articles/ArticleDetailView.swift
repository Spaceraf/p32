import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title).font(.title)
            Text("Authors: \(article.authors.joined(separator: ", "))")
            if let pdfURLString = article.pdfURL, let pdfURL = URL(string: pdfURLString) {
                Link("Read PDF", destination: pdfURL)
            } else {
                Text("No PDF Available")
            }
        }
        .padding()
        .navigationTitle(Text(article.title))
    }
}
