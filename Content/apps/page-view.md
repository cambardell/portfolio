---
date: 2020-06-19 13:33
description: SwiftUI page view
tags: swiftui, swift
---
# Page View in SwiftUI with spring animation
```swift
struct PageView<Content: View>: View {
    @Binding var pageIndex: Int
    
    let pageCount: Int

    let content: Content

    init(pageCount: Int, pageIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._pageIndex = pageIndex
        self.content = content()
    }
    
    @GestureState private var translation: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.pageIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.2))
                
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.pageIndex) - offset).rounded()
                    self.pageIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}
```
A reusable page view component with a custom spring animation. Takes any content and supports any number of pages. 
