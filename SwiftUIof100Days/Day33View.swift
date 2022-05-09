//
//  Day33View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/9.
//

import SwiftUI

struct Day33View: View {
    
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
    }
}

struct Day33View_Previews: PreviewProvider {
    static var previews: some View {
        Day33View()
    }
}
