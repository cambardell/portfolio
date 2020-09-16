---
date: 2020-09-15 20:30
description: SwiftUI JSON
tags: swiftui, swift
---
# Fetching and Parsing JSON with SwiftUI
```swift
struct SuggestionsView: View {
    
    @ObservedObject var fetcher: BookFetcher
    
    init(searchString: String) {
        fetcher = BookFetcher(searchString: searchString)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("See Me")
                VStack {
                    ForEach(fetcher.books, id: \.self) { book in
                        Text(book.title)
                    }
                }
            }
        }.background(Color.white)
    }
}

public class BookFetcher: ObservableObject {

    @Published var books = [Book]()
    
    init(searchString: String){
        load(searchString: searchString)
    }
    
    func load(searchString: String) {
        let queryItems = [URLQueryItem(name: "q", value: searchString), URLQueryItem(name: "page", value: "1")]
        var urlComps = URLComponents(string: "https://openlibrary.org/search.json")!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
    
        URLSession.shared.dataTask(with: result) {(data,response,error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Books.self, from: data) {
                    DispatchQueue.main.async {
                        print(decodedResponse.allBooks)
                        self.books = decodedResponse.allBooks
                    }
                    return
                }
            }
            
        }.resume()
         
    }
}

struct Book: Decodable, Hashable {
    
    let title: String
    let author_names: [String]
    
    enum CodingKeys: String, CodingKey {
        case title
        case author_names = "author_name"
    }
}

struct Books: Decodable {
    let numFound: Int
    let allBooks: [Book]
    
    enum CodingKeys: String, CodingKey {
        case numFound
        case allBooks = "docs"
    }
}


```
Using the OpenLibrary search API to search for books, decode the results, and display them in a stack.
