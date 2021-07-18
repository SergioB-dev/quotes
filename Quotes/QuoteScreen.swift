//
//  QuoteScreen.swift
//  QuoteScreen
//
//  Created by Sergio Bost on 7/15/21.
//

import SwiftUI

struct QuoteScreen: View {
    @GestureState private var dragOffset = CGSize.zero
    @State private var moveValue = 0
    @State private var quoteIndex = 0

    @State private var addQuoteScreen = false
    @ObservedObject var nm = NetworkManager.shared
    
    var currentQuote: Quote {
        nm.quotes[quoteIndex]
    }
    
    var quoteCount: Int {
        nm.quotes.count
    }
    var body: some View {
        ZStack {
            Color.indigo
            VStack {
                Spacer()
                QuoteView(quote: currentQuote)
                    .transition(.slide)
                
                    .navigationBarTitle("Hello")
                    
                   
                    .offset(x: dragOffset.width)
                    .gesture(
                        DragGesture()
                            .updating($dragOffset, body: { value, state, transaction in
                                state = value.translation
                                
                            }).onEnded({ value in
                                withAnimation(.easeIn(duration: 0.8)) {
                                    self.moveValue = Int(value.translation.width)
                                }
                                print(value.translation.width)
                                if moveValue < -180 {
                                    progress()
                                    print("Progressing because width is \(moveValue)")
                                } else if moveValue > 200 {
                                    degress()
                                    print("Degressing because width is \(moveValue)")
                                }
                            })
                    )
                
                ZStack {
                    Capsule(style: .circular)
                        .fill(Color.primary.opacity(0.34))
                    HStack {
                        CapsuleRowView(showAddQuote: $addQuoteScreen)
                            
                    }
                }
                .sheet(isPresented: $addQuoteScreen){ AddQuoteScreen() }
                .frame(height: 80)
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { }){
                                Image(systemName: "plus")
                            }
                        }
                    }
                    
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
        print("Index: \(quoteIndex), Range: \(quoteCount)")
        guard quoteIndex + 1 < quoteCount else {
            print("Out of range, safety exit triggered")
            return
        }
        withAnimation {
            self.quoteIndex += 1
        }
        print("NEW VALUE\n **************\nIndex: \(quoteIndex), Range: \(quoteCount)\n***************")
    }
    
    private func degress() {
        print("Index: \(quoteIndex), Range: \(quoteCount)")
        guard quoteIndex + quoteCount > quoteCount else {
            print("Out of range, safety exit triggered")
            return
        }
        withAnimation {
            self.quoteIndex -= 1
                
        }
        print("NEW VALUE\n **************\nIndex: \(quoteIndex), Range: \(quoteCount)\n***************")
    }
    
  
}

struct QuoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuoteScreen()
        }
    }
}

struct CapsuleRowView: View {
    @Binding var showAddQuote: Bool
    var body: some View {
        ForEach(1..<5){ cir in
            Circle()
                .opacity(0.4)
                .overlay(
                    overlayContent(cir)
                )
        }
    }
    @ViewBuilder private func overlayContent(_ index: Int) -> some View {
        switch index {
        case 1:
            Button(action: {self.showAddQuote.toggle() }){
            Image(systemName: "arrow.up.message.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.teal)
            }
        case 2:
            Image(systemName: "paperplane.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.teal)
        case 3:
            Image(systemName: "seal.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.teal)
        default:
            Image(systemName: "die.face.3.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.teal)
        }
    }
}
