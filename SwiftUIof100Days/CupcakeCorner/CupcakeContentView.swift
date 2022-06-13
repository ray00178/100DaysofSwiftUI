//
//  CupcakeContentView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/8.
//

import SwiftUI

struct CupcakeContentView: View {
  
  @StateObject var order = Order()
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Select your cake type", selection: $order.type) {
            ForEach(Order.types.indices) {
              Text(Order.types[$0])
            }
          }
        }
        
        Section {
          Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
          
          if order.specialRequestEnabled {
            Toggle("Add extra frosting", isOn: $order.extraFrosting)
            
            Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
          }
        }
        
        Section {
          NavigationLink {
            AddressView(order: order)
          } label: {
            Text("Delivery details")
          }
        }
      }
      .navigationTitle("Cupcake Corner")
    }
  }
}

struct CupcakeContentView_Previews: PreviewProvider {
  static var previews: some View {
    CupcakeContentView()
  }
}
