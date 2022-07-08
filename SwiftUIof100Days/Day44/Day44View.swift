//
//  Day44View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/31.
//

import SwiftUI

struct Day44View: View {
    
    @State private var petalOffset: Double = -20.0
    @State private var petalWidth: Double = 100.0
    
    @State private var colorCycle: Double = 0.0
    
    var body: some View {
        
        // Enabling high-performance Metal rendering with drawingGroup()
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
        
        // Creative borders and fills using ImagePaint
        /*VStack {
            Text("Hello world")
                .frame(width: 150, height: 150)
                .background(.green)
            
            Text("Hello world Border")
                .frame(width: 150, height: 150)
                .border(.green, width: 10.0)
            
            Text("Hello world Image")
                .foregroundColor(.white)
                .frame(width: 150, height: 150)
                .background(Image("Germany"))
            
            // If you want to try using the sourceRect parameter, make sure you pass in a CGRect of relative sizes and positions: 0 means “start” and 1 means “end”. For example, this will show the entire width of our example image, but only the middle half:
            Text("Hello World")
                .frame(width: 150, height: 150)
                .border(ImagePaint(image: Image("Germany"), /*sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5),*/ scale: 0.2), width: 30)
            
            // ImagePaint will automatically keep tiling its image until it has filled its area – it can work with backgrounds, strokes, borders, and fills of any size.
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Germany"), scale: 0.5), lineWidth: 10)
                .frame(width: 150, height: 100)
        }*/
        
        // Transforming shapes using CGAffineTransform and even-odd fills
        /*VStack {
            
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                //.stroke(.red, lineWidth: 1)
                // eoFill = true, 表示路徑重疊時，會填滿反之不填滿
                .fill(.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }*/
    }
}

struct Day44View_Previews: PreviewProvider {
    static var previews: some View {
        Day44View()
    }
}

// MARK: - Custom View

struct Flower: Shape {
    
    // How much to move this petal away from the center
    var petalOffset: Double = -20.0
    
    // How wide to make each petal
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            
            let rotation = CGAffineTransform(rotationAngle: number)
            
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct ColorCyclingCircle: View {
    
    var amount = 0.0
  var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0 ..< steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        // This tells SwiftUI it should render the contents of the view into an off-screen image before putting it back onto the screen as a single rendered output, which is significantly faster. Behind the scenes this is powered by Metal, which is Apple’s framework for working directly with the GPU for extremely fast graphics.
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    
}
