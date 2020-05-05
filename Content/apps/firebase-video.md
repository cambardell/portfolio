---
date: 2020-05-5 17:08
description: SwiftUI calendar month view. 
tags: swiftui, swift, firebase
---
# Downloading from Firebase storage with SwiftUI
```swift
struct VideoPlayer: View {
    let storage = Storage.storage()
    @State var videoURL = ""
    @State var videoTitle: String
    var body: some View {
        VStack {
            
            if videoURL == "" {
                Text("Downloading").onAppear(perform: downloadFromFirebase)
                
                
            } else {
                PlayerContainerView(player: AVPlayer(url: URL(string: videoURL)!), url: videoURL)
            }
        }
    }
    
    func downloadFromFirebase() {
        print("download called")
        let storageRef = storage.reference()
        let videoRef = storageRef.child("\(videoTitle).mov")
        // Fetch the download URL
        videoRef.downloadURL { url, error in
            if let error = error {
                // Handle any errors
                print("download error: \(error)")
                
            } else {
                print("url: \(String(describing: url))")
                self.videoURL = url?.absoluteString ?? ""
            }
        }
    }
}
```
Video is then displayed with AVPlayer and UIViewRepresentable. Next step is adding some kind of progress indicator. 
