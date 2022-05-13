//
//  Day37View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/14.
//

import SwiftUI

/// If you want to use a class with your SwiftUI data – which you will want to do if that data should be shared across more than one view – then SwiftUI gives us three property wrappers that are useful: @StateObject, @ObservedObject, and @EnvironmentObject
struct Day37View: View {
    
    @StateObject var user = User()
    
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete {
                        removeRows(at: $0)
                    }
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                .padding(30)
                .font(.system(size: 18.0, weight: .semibold, design: .monospaced))
                .foregroundColor(.white)
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
            }
            .toolbar {
                EditButton()
            }
        }
        
        /*Button("Show sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            
        } content: {
            SencondView(name: "Ray")
        }*/
        
        /*VStack {
            
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
            
        }
        .padding(30)
        .background(.green)*/
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct SencondView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        Button("Dismiss for \(name)") {
            dismiss()
        }
    }
}



struct Day37View_Previews: PreviewProvider {
    static var previews: some View {
        Day37View()
    }
}

class User: ObservableObject {
    
    @Published var firstName = "Ray"
    @Published var lastName = "Jhang"
    
}
