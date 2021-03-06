//
//  Day33View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/9.
//

import SwiftUI

struct Day33View: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        //TapMeButton()
        //DragView()
        //AnimatingView()
        //ShowingView()
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            Text("Hello")
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
                .background(.red)
                .opacity(isShowingRed ? 1 : 0)
                .animation(.linear(duration: 0.3), value: isShowingRed)
            /*if isShowingRed {
                Rectangle()
                    .fill(.orange)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }*/
        }
        .onTapGesture {
            isShowingRed.toggle()
        }
    }
}

struct TapMeButton: View {
    
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        //.animation(.default, value: enabled)
        // Setting nil can disable animation
        .animation(nil, value: enabled)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
    }
}

struct DragView: View {
    
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(colors: [.yellow,. red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        dragAmount = value.translation
                    })
                    .onEnded({ _ in
                        withAnimation(.spring()) {
                            dragAmount = .zero
                        }
                    })
            )
    }
}

struct AnimatingView: View {
    
    let letters = Array("Hello SwiftUI")
    
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< letters.count) {
                Text(String(letters[$0]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.default.delay(Double($0) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    dragAmount = value.translation
                })
                .onEnded({ value in
                    dragAmount = .zero
                    enabled.toggle()
                })
        )
    }
    
}

struct ShowingView: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    //.transition(.scale)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
        }
    }
}

struct Day33View_Previews: PreviewProvider {
    static var previews: some View {
        Day33View()
    }
}

// MARK: - Custom modifier

struct CornerRotateModifier: ViewModifier {
    
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

// MARK: - Extenison

extension AnyTransition {
    
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
    
}
