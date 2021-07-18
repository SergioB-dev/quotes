//
//  Quote.swift
//  Quote
//
//  Created by Sergio Bost on 7/15/21.
//

import Foundation

struct Quote: Codable, Identifiable {
    var id: String? 
    let quote: String
    let author: String
    let category: String
    let likes: Int
    let dislikes: Int
}

enum Categories: String, CaseIterable {
    case life = "Life"
    case knowledge = "Knowledge"
    case intuition = "Intuition"
    case virtue = "Virtue"
    
}


let array = ["", "",
"", "",
             
]
