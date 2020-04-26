---
date: 2020-04-26 19:45
description: SwiftUI calendar month view. 
tags: swiftui, swift
---
# Month view for SwiftUI calendar
```swift
struct MonthGrid<Content: View>: View {
    let days: Int
    let content: (Int) -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0 ..< (days / 7), id: \.self) { row in
                HStack {
                    ForEach(0 ..< 7, id: \.self) { column in
                        self.content(column + (row * 7) + 1)
                    }
                }
            }
            HStack {
                if days % 7 >= 1 {
                    ForEach(1 ... (days % 7), id: \.self) { column in
                        self.content(7 * 4 + column)
                    }
                }
            }
        }
    }
    
    init(days: Int, @ViewBuilder content: @escaping (Int) -> Content) {
        self.days = days
        self.content = content
    }
}
```
A SwiftUI component that takes the number of days in a month and lays out the given content in a grid. Made for the forthcoming version two of Ripple, an app for tracking mental health. 
