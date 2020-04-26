import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct Cambardell: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case apps
        case blog
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://cambardell.github.io")!
    var name = "Cameron Bardell"
    var description = "A description of Cambardell"
    var language: Language { .english }
    var imagePath: Path? { nil }
}


try Cambardell().publish(using: [
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .cambardell),
    .deploy(using: .gitHub("cambardell/cambardell.github.io"))
    
])

