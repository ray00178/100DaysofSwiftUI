//
//  Day45View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/2.
//

import SwiftUI

struct Day45View: View {
    
    @State private var amount = 0.0
    
    @State private var insetAmount = 50.0
    
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount1 = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        // Creating a spirograph with SwiftUI
        VStack(spacing: 0) {
            Spacer()
            
            Spirograph(innerRadius: Int(innerRadius),
                       outerRadius: Int(outerRadius),
                       distance: Int(distance),
                       amount: amount1)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Group {
                Text("Inner radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal,. bottom])
                
                Text("Outer radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \(amount1, format: .number.precision(.fractionLength(2)))")
                Slider(value: $amount1)
                    .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }
        
        
        // Animating complex shapes with AnimatablePair
        /*Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }*/
        
        // Animating simple shapes with animatableData
        /*Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }
            }*/
        
        // Special effects in SwiftUI: blurs, blending, and more
        /*VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -40)
                    .blendMode(.screen)

                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -40)
                    .blendMode(.screen)

                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .offset(x: 0.0, y: 40.0)
                    .blendMode(.screen)
                
            }
            .frame(width: 300, height: 300)
            
            Image("apollo1")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(width: .infinity, height: .infinity)
        .background(.black)
        .ignoresSafeArea()*/
        
        /*Image("apollo1")
            .colorMultiply(.red)*/
    }
}

struct Day45View_Previews: PreviewProvider {
    static var previews: some View {
        Day45View()
    }
}

// MARK: - Custom View

struct Trapezoid: Shape {
    
    var insetAmount: Double
    
    // Use an animatableData property to let us animate changes to shapes
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
    }
}

struct Checkerboard: Shape {
    
    var rows: Int
    var columns: Int
    
    // Of course, the next question is: how do we animate three properties? Or four?
    // To answer that, let me show you the animatableData property for SwiftUI’s EdgeInsets type:
    // AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>>>
    // Yes, they use three separate animatable pairs,
    // then just dig through them using code such as newValue.second.second.first.
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let colSize = rect.width / Double(columns)
        
         for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = colSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX,
                                      y: startY,
                                      width: colSize,
                                      height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
    
}

struct Spirograph: Shape {
    
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
    
    // We then prepare three values from that data, starting with the greatest common divisor (GCD) of the inner radius and outer radius.
    // Calculating the GCD of two numbers is usually done with Euclid's algorithm, which in a slightly simplified form looks like this:
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b

        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }

        return a
    }
    
}
