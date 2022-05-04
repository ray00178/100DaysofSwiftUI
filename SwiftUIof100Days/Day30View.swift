//
//  Day30View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/4.
//

import SwiftUI

struct Day30View: View {
    
    @State private var useWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(useWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit {
                addNewWord()
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        withAnimation {
            useWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
}

struct Day30_Previews: PreviewProvider {
    static var previews: some View {
        Day30View()
    }
}
