import SwiftUI
import FirebaseFirestore

struct TrackListView: View {
    @State private var tracks: [Track] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(tracks) { track in
                    NavigationLink(destination: ArticleListView(track: track)) {
                        Text(track.name)
                    }
                }
            }
            .onAppear(perform: fetchTracks)
            .navigationTitle("Tracks")
        }
    }

    private func fetchTracks() {
        let db = Firestore.firestore()
        db.collection("tracks").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                tracks = querySnapshot!.documents.compactMap { document -> Track? in
                    try? document.data(as: Track.self)
                }
            }
        }
    }
}
