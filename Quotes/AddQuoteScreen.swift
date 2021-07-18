//
//  AddQuoteScreen.swift
//  AddQuoteScreen
//
//  Created by Sergio Bost on 7/17/21.
//

import SwiftUI

struct AddQuoteScreen: View {
    @Environment(\.presentationMode) var pMode
    @State private var category: Categories = .knowledge
    @State private var quote = ""
    
    var savedName: String {
        UserDefaults.standard.value(forKey: "chosenName") as? String ?? "Person"
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.indigo
                Form {
                    Section(header: Text("\(savedName)'s quote")) {
                        TextEditor(text: $quote)
                        
                    }
                    Section(header: Text("Category")) {
                        Picker("Category", selection: $category) {
                            ForEach(Categories.allCases, id: \.self) { cat in
                                Text(cat.rawValue)
                            }
                        }.pickerStyle(.segmented)
                    }
                }
            }.ignoresSafeArea()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Submit"){
                            uploadQuote()
                            self.pMode.wrappedValue.dismiss() }
                    }
            }
        }
    }
    private func uploadQuote() {
        do {
            try NetworkManager.addQuote(quote: quote, author: savedName, category: category.rawValue) { quote in
            print("\(quote) has been uploaded")
        }
        } catch {
            print(error)
        }
    }
}

struct AddQuoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddQuoteScreen()
        }
    }
}


