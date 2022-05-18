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
    
    var currency: String {
        return Locale.current.currencyCode ?? "USD"
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { (item) in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: currency))
                    }
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
                AddView(expenses: expenses, currency: currency)
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

struct ExpenseItem: Identifiable, Codable {
    
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
}

class Expenses: ObservableObject {
    
    @Published var items = [ExpenseItem]() {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: "Items")
            }
        }
    }
    
    init() {
        guard let data = UserDefaults.standard.data(forKey: "Items"),
              let value = try? JSONDecoder().decode([ExpenseItem].self, from: data)
        else {
            return
        }
        
        items = value
    }
}
