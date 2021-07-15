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
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 2)
            VStack {
                Text(quote.quote)
                frame(maxWidth: 300)
                Text(quote.author)
                    .frame(maxWidth: 300, alignment: .trailing)
                    .foregroundColor(.secondary)
            }
            
        }.navigationBarHidden(true)
        .frame(height: 400)
            .padding()
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(quote: dummyData[0])
    }
}
