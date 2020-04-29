---
date: 2020-04-29 17:31
description: return views with Switch in SwiftUI
tags: swiftui, swift
---
# Use Switch to return views in SwiftUI
```swift
func containedView() -> AnyView {
    switch selection {
    case 1:
        return AnyView(ProfileView().environmentObject(session))
    case 2:
        return AnyView(HomeView().environmentObject(session))
    case 3:
        return AnyView(SettingsView().environmentObject(session))
    default:
        return AnyView(HomeView().environmentObject(session))
    }
}
```
Switch can't be used within the body of a SwiftUI view. Get around this by wrapping in a function that returns AnyView. Here, I used this concept for a custom TabView, since the native version is broken. 
