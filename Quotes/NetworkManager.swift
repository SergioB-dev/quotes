//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Sergio Bost on 7/17/21.
//

import SwiftUI

final class NetworkManager: ObservableObject {
    @Published var quotes: [Quote] = []
    
    static let shared = NetworkManager()
    
     func getAllQuotes() async {
        do {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "http://127.0.0.1:8080/quotes")!)
        let quotes = try JSONDecoder().decode([Quote].self, from: data)
            DispatchQueue.main.async {
                self.quotes = quotes
            }
        } catch {
            print(error.localizedDescription)
        }
      
    }
    
    static  func addQuote(quote: String, author: String?, category: String, completion: @escaping (String) -> Void) throws {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/quotes")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var temp = ""
        if let author = author {
            temp = author
        }
        let quote = Quote(quote: quote, author: temp, category: category, likes: 1, dislikes: 0)
        let data = try JSONEncoder().encode(quote)
        request.httpBody = data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
        }
      task.resume()
    }
}
