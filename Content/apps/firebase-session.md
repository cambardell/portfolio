---
date: 2020-05-6 19:04
description: SwiftUI firebase session
tags: swiftui, swift, firebase, combine
---
# Firebase Authentication Session with SwiftUI
```swift
class FirebaseSession: ObservableObject {
    
    //MARK: Properties
    @Published var workouts: [Workout] = []
    @Published var exercises: [Exercise] = []
    
    let db = Firestore.firestore()
    
    var didChange = PassthroughSubject<FirebaseSession, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    //MARK: Authentication functions
    
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
      
        
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

}
```
Using Combine's ObservableObject with Firebase and SwiftUI is a great way to track the authentication state of the user. This way, I can conditionally display SignIn or MainContent, depending on the user's auth state. 

```swift
struct ContentView: View {
    
    @EnvironmentObject var session: FirebaseSession

    func getUser () {
        print("appear")
        session.listen()
    }
    
    var body: some View {
        Group {
          if (session.session != nil) {
            MainContent().environmentObject(session)
          } else {
            SignIn().environmentObject(session)
          }
        }.onAppear(perform: getUser)
    }
}
```
