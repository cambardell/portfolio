---
date: 2020-04-26 2:12
description: First post, using Publish to generate a static site
tags: swift
---
# Static Site Generation with Swift and Publish
```swift
// Swift sample post
static func swiftItem<T: Website>(for item: Item<T>) -> Node {
    return .div(
        .class("content"),
        .contentBody(item.body)
    )
}
```
As a first post on my new site, here's how I use John Sundell's excellent static site generator, called Publish, to generate this section. 
