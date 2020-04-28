---
date: 2020-04-27 21:02
description: SwiftUI floating button
tags: swiftui, swift
---
# SwiftUI floating buttons 
```swift
// Embedded stacks to put button in bottom corner
HStack {
    Spacer()
    VStack {
        Spacer()
        Button(action: {
            self.showAddQuote.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.footnoteRed)
                .padding()
        }
    }
}
```
Embed a stack within a stack, and place at the top level of a ZStack, to have a button (or anything else) floating in the corner of the UI. This button floats in the bottom right. 
