//
//  Day32View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/7.
//

import SwiftUI

struct Day32View: View {
    
    @State private var animationAmount = 1.0
    
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50.0)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        
        /*print(animationAmount)
        
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1 ... 10)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(50.0)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }*/
        
        /*Button("Tap Me") {
            //animationAmount += 1
        }
        .padding(50.0)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        //.scaleEffect(animationAmount)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount)
        )
        .onAppear {
            animationAmount = 2
        }
        //.animation(.default, value: animationAmount)
        //.animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
        //.animation(.easeIn(duration: 2).delay(1), value: animationAmount)
        //.animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animationAmount)
        //.animation(.easeIn(duration: 2).repeatCount(3, autoreverses: true), value: animationAmount)
        //.blur(radius: (animationAmount - 1) * 3)*/
    }
}

struct Day32View_Previews: PreviewProvider {
    static var previews: some View {
        Day32View()
    }
}
