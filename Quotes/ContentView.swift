//
//  ContentView.swift
//  ContentView
//
//  Created by Sergio Bost on 7/15/21.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldShowQuotes = false
    var body: some View {
        ZStack {
            Color.indigo
            VStack {
                Button(action: showQuotes){
                    Text("Get Quotes").bold()
                        .frame(maxWidth: 300)
                }
                    .controlProminence(.increased)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
            }
            .fullScreenCover(isPresented: $shouldShowQuotes) {
                QuoteScreen()
            }
        }.ignoresSafeArea()
    }
    private func showQuotes() {
        self.shouldShowQuotes.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
