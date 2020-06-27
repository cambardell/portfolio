---
date: 2020-06-27 00:30
description: SwiftUI Bar Graph
tags: swiftui, swift
---
# Bar Graph in SwiftUI
```swift
var body: some View {
    VStack {
        ZStack {
            VStack {
                // To match above layer
                Text("Day").foregroundColor(.clear)
                ForEach((1...10), id: \.self) { item in
                    Divider()
                    Spacer()
                }
            }.padding()
            
            HStack(alignment: .bottom) {
                ForEach(data, id: \.self) { item in
                    VStack {
                        Text("Day")
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.rippleRed)
                            
                        }.scaleEffect(CGSize(width: 0.7, height: item), anchor: .bottom)
                    }
                    
                }
            }.padding()
        }
    }
    .background(Color.rippleBlue)
    .cornerRadius(8)
    .padding()
    .shadow(radius: 5)
}
```
An easy to make SwiftUI bar graph, used in this case to present weekly data. ZStacks are useful for creating axis lines. 
