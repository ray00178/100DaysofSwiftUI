//
//  ContentView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/17.
//

import SwiftUI

// MARK: - Day62View

struct Day62View: View {
  
  @State private var blurAmount = 0.0
  
  @State private var showingConfirmation = false
  @State private var backgroundColor = Color.yellow
  
  var body: some View {
    Text("Hello world")
      .frame(width: 200.0, height: 280.0, alignment: .center)
      .background(backgroundColor)
      .onTapGesture {
        showingConfirmation = true
      }
      .confirmationDialog(
        "Change BackgroundColor",
        isPresented: $showingConfirmation) {
          Button("Red", action: { backgroundColor = .red })
          Button("Blue", action: { backgroundColor = .blue })
          Button("Green", action: { backgroundColor = .green })
          Button("Yellow", action: { backgroundColor = .yellow })
        } message: {
          Text("Select a new Color")
        }
    
    /*VStack(spacing: 12.0) {
      Text("Hello world!")
        .font(.largeTitle)
        .blur(radius: blurAmount)
        .padding(4)
        .background(.yellow)
      
      Slider(value: $blurAmount, in: 0...20)
        .padding([.horizontal], 20.0)
        .onChange(of: blurAmount) { newValue in
          print("New value is \(newValue)")
        }
      
      Button("Random") {
        blurAmount = Double.random(in: 0...20)
      }
      .padding(20.0)
      .font(.title)
      .foregroundColor(.white)
      .background(.black)
      .cornerRadius(4)
    }*/
  }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Day62View()
  }
}
