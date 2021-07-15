//
//  QuoteScreen.swift
//  QuoteScreen
//
//  Created by Sergio Bost on 7/15/21.
//

import SwiftUI

struct QuoteScreen: View {
    @State private var quoteIndex = 0
    var currentQuote: Quote {
        return dummyData[quoteIndex]
    }
    var body: some View {
        ZStack {
            Color.indigo
            VStack {
                QuoteView(quote: currentQuote)
                Spacer()
                HStack {
                    Button(action: degress) {
                        Image(systemName: "arrow.left.square.fill")
                            .resizable()
                        .frame(width: 50, height: 50)
                    }
                    Spacer()
                    Button(action: progress) {
                        Image(systemName: "arrow.right.square.fill")
                            .resizable()
                        .frame(width: 50, height: 50)
                    }
                }
                .padding(28)
                    .buttonStyle(.plain)
                    
            }
        }.ignoresSafeArea()
    }
    private func progress() {
        quoteIndex += 1
    }
    
    private func degress() {
        quoteIndex -= 1
    }
}

struct QuoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuoteScreen()
    }
}
