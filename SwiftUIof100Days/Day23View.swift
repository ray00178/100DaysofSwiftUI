//
//  Day23View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/26.
//

import SwiftUI

struct Day23View: View {
    
    @State private var isGreen = false
    
    @ViewBuilder var spells: some View {
        HStack {
            Text("Lumos")
                .modifier(Title())
            Text("Obliviate")
                .titleStyle()
        }
    }
    
    var body: some View {
        VStack(spacing: 30.0) {
            spells
            
            CommonText(text: "Common 1")
                .foregroundColor(.blue)
            CommonText(text: "Common 2")
                .foregroundColor(.yellow)
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
                .font(.largeTitle)
            
            Button {
                isGreen.toggle()
                print(type(of: self.body))
            } label: {
                Text("Button")
                    .font(.system(size: 30.0, weight: .semibold))
                    .tint(isGreen ? .yellow : .green)
                    .padding()
                    .background(isGreen ? .green : .yellow)
                    .cornerRadius(8)
                    .shadow(radius: 8.0)
            }
            
            GridStack(rows: 3, columns: 3) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
        .font(.title)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct Day23View_Previews: PreviewProvider {
    static var previews: some View {
        Day23View()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

struct CommonText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.black)
            .clipShape(Capsule())
    }
}

// MARK: - Custom modifier

struct Title: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Extension View

extension View {
    
    func titleStyle() -> some View {
        modifier(Title())
    }
    
}

// MARK: - Custom containers

struct GridStack<Content: View>: View {
    
    let rows: Int
    let columns: Int
    
    // 添加隱性的HStack, 因外層是HStack
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}
