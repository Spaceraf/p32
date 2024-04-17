import FirebaseFirestoreSwift

struct Track: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var articles: [Article]
}
