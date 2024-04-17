import FirebaseFirestoreSwift

struct Article: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var authors: [String]
    var pdfURL: String?
}
