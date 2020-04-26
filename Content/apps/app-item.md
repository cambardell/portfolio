---
date: 2020-04-26 16:26
description: App card on homepage
tags: swift
---
# Creating an App Card with Publish
```swift
// App item contained in app list
static func appItem<T: Website>(for item: Item<T>) -> Node {
    return .div(
        .class("stack"),
        //Wrapper to center images
        .div(
            .id("image-parent"),
            .div(
                .id("img-item"),
                .img(.src("screenshots/\(item.description)_1.png")),
                .img(.src("screenshots/\(item.description)_2.png"))
            )
        ),
        .div(
            .class("content"),
            .contentBody(item.body)
        )
    )
}
```
This function is used to generate the app cards seen on the homepage. The stack layout comes from [any-layout](https://any-layout.dev).
