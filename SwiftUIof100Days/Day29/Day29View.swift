//
//  Day29View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/3.
//

import SwiftUI

struct Day29View: View {
    
    private let people = ["Ray", "Aida", "Mary", "John"]
    
    private var fileContent: String? {
        guard let fileURL = Bundle.main.url(forResource: "URL-file", withExtension: "txt")
        else {
            return nil
        }
        
        return try? String(contentsOf: fileURL)
    }
    
    var body: some View {
        List(people, id: \.self) {
            Text("\($0) \(String(checkWord()))")
        }
//        List {
//            Section("Section 1") {
//                Text("one")
//                Text("two")
//                Text("three")
//            }
//
//            Section("Section 2") {
//                ForEach(0 ..< 5) {
//                    Text("Dynamic \($0) row")
//                }
//            }
//        }
//        .listStyle(.grouped)
    }
    
    /// 檢查拼字是否正確
    private func checkWord() -> Bool {
        let word = "swift child"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")
        
        return misspelledRange.location == NSNotFound
    }
}

struct Day28View_Previews: PreviewProvider {
    static var previews: some View {
        Day29View()
    }
}
