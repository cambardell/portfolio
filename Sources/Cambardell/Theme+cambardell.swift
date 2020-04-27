import Publish
import Foundation
import Plot

public extension Theme {

    static var cambardell: Self {
        Theme(
            htmlFactory: CambardellHTMLFactory(),
            resourcePaths: ["Resources/theme/styles.css", "Resources/theme/font-rules.css", "Resources/theme/splash-colours.css", "Resources/theme/resume-styles.css", "Resources/theme/every-layout-styles.css"]
        )
    }
}

private struct CambardellHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site, stylesheetPaths: ["splash-colours.css", "styles.css", "font-rules.css", "every-layout-styles.css"]),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .div(
                        .class("content"),
                        .contentBody(index.body)
                    ),
                    .appGrid(
                        for: context.items(
                            taggedWith: "app",
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        print(section.path)
        return HTML(
            .lang(context.site.language),
            .if(section.path == "resume",
                .head(for: section, on: context.site, stylesheetPaths: ["resume-styles.css", "font-rules.css", "every-layout-styles.css"])
            ),
            .if(section.path != "resume",
                 .head(for: section, on: context.site, stylesheetPaths: ["splash-colours.css", "styles.css", "font-rules.css", "every-layout-styles.css"])
            ),
           
            .body(
                .header(for: context, selectedSection: section.id),
                
                // Swift samples section
                .if(section.path == "swift",
                    .wrapper(
                        .div(
                            .class("stack"),
                            .forEach(context.items(
                                taggedWith: "swift",
                                sortedBy: \.date,
                                order: .descending
                            )) { item in
                                .swiftItem(for: item)
                            }
                        )
                    )
                ),
                
                .if(section.path == "resume",
                    .wrapper(
                        .div(
                            .class("stack"),
                            .forEach(context.items(
                                taggedWith: "resume",
                                sortedBy: \.date,
                                order: .descending
                            )) { item in
                                .resumeItem(for: item)
                            }
                        )
                    )
                ),
                
                
                
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {

        return HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .article(
                        .div(
                            .class("content"),
                            .contentBody(item.body)
                        ),
                        .span("Tagged with: "),
                        .tagList(for: item, on: context.site)
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .if(page.path == "resume",
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(
                        .div(
                            .class("resume"),
                            .resumeItem(for: context.items(taggedWith: "resume")[0])
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Browse all tags"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        return .header(
            .div(
                .id("header"),
                .class("outer-cluster"),
                .wrapper(
                    .a(.class("site-name"), .href("/"), .text("Home")),
                    .div(
                        .class("inner-cluster"),
                        .wrapper(
                            
                            .a(.class("swift-samples"), .href(context.sections[T.SectionID(rawValue: "swift")!].path),
                               .text("\(context.sections[T.SectionID(rawValue: "swift")!].title) Samples")
                            ),
                            .a(.class("resume"), .href("/resume"),
                               .text("Resume")
                            )
                        )
                    )
                )
            )
        )
    }
    
    // Swift sample post
    static func swiftItem<T: Website>(for item: Item<T>) -> Node {
        
        return .div(
            .class("content"),
            .id(item.title),
            .contentBody(item.body),
            .a(.href("#\(item.title)"),
               .text(dateToString(date: item.date)))
        )
    }
    
    // Resume item
    static func resumeItem<T: Website>(for item: Item<T>) -> Node {
        return .div(
            .class("content"),
            .contentBody(item.body)
        )
    }
    
    // App list below site title and description
    static func appGrid<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .div(
            .class("grid"),
            .forEach(items) { item in
                .appItem(for: item)
                
            }
        )
    }
    
    // App item contained in app grid
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

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            )
        )
    }
}

func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: date)
}
