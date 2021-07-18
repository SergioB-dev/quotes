//
//  QuoteView.swift
//  QuoteView
//
//  Created by Sergio Bost on 7/15/21.
//

import SwiftUI

struct QuoteView: View {
    @State private var showQuotes = false
    let quote: Quote
    var body: some View {
        ZStack {
            Color.white
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 6)
            VStack {
                HStack {
                    Text(quote.quote)
                }.background {
                    GeometryReader { geo in
                        Rectangle()
                            .fill(.teal)
                            .frame(width: 8, alignment: .leading)
                            .offset(x: -16)
                    }
                }
                Text("-" + quote.author)
                    .frame(maxWidth: 300, alignment: .trailing)
                    .foregroundColor(.secondary)
            }.frame(maxWidth: 280)
            Image(systemName: "star")
                .resizable()
                .frame(width: 35, height: 35)
                
                .position(x: UIScreen.main.bounds.width * 0.85, y: 30)
                
                
               
                Image(systemName: "hand.thumbsdown")
                .resizable()
                .frame(width: 25, height: 25)
                .position(x: 40, y: 370)
            Image(systemName: "hand.thumbsup")
                .resizable()
                .frame(width: 25, height: 25)
                .position(x: 360, y: 370)
        }
        .cornerRadius(25)
        
        .frame(height: 400)
            .padding()
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(quote: dummyData[0])
    }
}
