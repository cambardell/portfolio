import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This type acts as the configuration for your website.
struct Cambardell: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case apps
        case swift
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://cambardell.github.io")!
    var name = "Cameron Bardell"
    var description = "Mostly swift, also physics at University of Waterloo"
    var language: Language { .english }
    var imagePath: Path? { nil }
}


try Cambardell().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .cambardell),
    .deploy(using: .gitHub("cambardell/cambardell.github.io"))
    
])

