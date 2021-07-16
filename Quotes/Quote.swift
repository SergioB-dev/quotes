//
//  Quote.swift
//  Quote
//
//  Created by Sergio Bost on 7/15/21.
//

import Foundation

struct Quote: Codable, Identifiable {
    let id = UUID()
    let quote: String
    let author: String
    let index: Int
}
