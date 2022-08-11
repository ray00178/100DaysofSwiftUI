//
//  CardView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/11.
//

import SwiftUI

// MARK: - CardView

struct CardView: View {
  
  @State private var isShowingAnswer = false
    
  let card: Card
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25.0, style: .circular)
        .fill(.white)
        .shadow(radius: 10)
      
      VStack {
        Text(card.prompt)
          .font(.largeTitle)
          .foregroundColor(.black)
        
        if isShowingAnswer {
          Text(card.answer)
            .font(.title)
            .foregroundColor(.gray)
        }
      }
      .padding(20)
      .multilineTextAlignment(.center)
      
    }
    .padding([.leading, .trailing])
    .frame(width: .infinity, height: 250)
    .onTapGesture {
      withAnimation {
        isShowingAnswer.toggle()
      }
    }
  }
}

// MARK: - CardView_Previews

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card.example)
  }
}
