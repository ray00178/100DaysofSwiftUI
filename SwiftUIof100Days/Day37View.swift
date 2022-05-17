//
//  Day37View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/16.
//

import SwiftUI

struct Day37View: View {
    
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) {
                    Text($0.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct Day37View_Previews: PreviewProvider {
    static var previews: some View {
        Day37View()
    }
}

// MARK: - Model

struct ExpenseItem: Identifiable {
    
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
    
}

class Expenses: ObservableObject {
    
    @Published var items = [ExpenseItem]()
}
