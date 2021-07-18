//
//  ContentView.swift
//  ContentView
//
//  Created by Sergio Bost on 7/15/21.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldShowQuotes = false
    @State private var nameOption: NameOption = .ownName
    @State private var name = ""
    @State private var randomNoun = ""
    @State private var randomAdj = ""
    @ObservedObject var nm = NetworkManager.shared
    var chosenName: String {
        randomAdj + " " + randomNoun
    }
    
    var body: some View {
        
        ZStack {
            NavigationLink(destination: QuoteScreen(), isActive: $shouldShowQuotes) { EmptyView() }
            Color.indigo
            VStack {
                nameSelectionView()
                Picker("Which name should we use?", selection: $nameOption.animation()) {
                    Text("I'll use my own name").tag(NameOption.ownName)
                    Text("Random name").tag(NameOption.randomName)
                }
                if !randomAdj.isEmpty {
                    HStack {
                        Image(systemName: "person")
                        Text(randomAdj + " " + randomNoun).bold()
                            .font(.custom("Comic Sans", size: 24))
                            .foregroundColor(.pink)
                    }.padding().background(RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.primary.opacity(0.25))
                    )
                }
                Button(action: showQuotes){
                    Text("Get Quotes").bold()
                        .frame(maxWidth: 300)
                }
                .colorInvert()
                .controlProminence(.increased)
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .navigationBarTitle("Hello")
            
        }.ignoresSafeArea()
            .task {
                await nm.getAllQuotes()
            }
        
    }
    private func showQuotes() {
        saveName()
        self.shouldShowQuotes.toggle()
    }
    
    private func saveName() {
        if nameOption == .ownName {
            guard !name.isEmpty else { return }
            UserDefaults.standard.set(name, forKey: "chosenName")
        } else {
            UserDefaults.standard.set(chosenName, forKey: "chosenName")
        }
    }
    
    private enum NameOption {
        case ownName
        case randomName
    }
    
    @ViewBuilder private func nameSelectionView() -> some View {
        if nameOption == .ownName {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding()
        } else {
            HStack(spacing: -150) {
                Spacer()
                Picker("", selection: $randomAdj) {
                    ForEach(Names.randomize(nouns: false), id: \.self){ adj in
                        Text(adj)
                    }
                }
                Picker("", selection: $randomNoun) {
                    ForEach(Names.randomize(nouns: true), id: \.self){ noun in
                        Text(noun)
                    }
                }
                Spacer()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
