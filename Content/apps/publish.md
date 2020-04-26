---
date: 2020-04-26 2:12
description: First post, using Publish to generate a static site
tags: swift
---
# Static Site Generation with Swift and Publish
```swift
// Swift sample post
   static func swiftItem<T: Website>(for item: Item<T>) -> Node {
       print(item.title)
       return .div(
           .class("content"),
           .id(item.title),
           .contentBody(item.body),
           .a(.href("#\(item.title)"),
           .text("Permalink"))
       )
   }
```
As a first post on my new site, here's how I use John Sundell's excellent static site generator, called Publish, to generate this section. 
