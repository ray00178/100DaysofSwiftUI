//
//  Day43View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/26.
//

import SwiftUI

struct Day43View: View {
    
    var body: some View {
        VStack(spacing: 20.0) {
            Triangle()
                .stroke(.blue, style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .frame(width: 120, height: 120)
            
            Arc(startAngle: .degrees(-90), endAngle: .degrees(140), clockwise: true)
                .strokeBorder(.red, style: StrokeStyle(lineWidth: 5.0, dash: [2.0, 4.0]))
                .frame(width: 120, height: 120.0)
            
            // .stroke = 繪製時會超出邊界
            // .strokeBorder = 繪製時會符合邊界
            Circle()
                //.stroke(.green, lineWidth: 5.0)
                .strokeBorder(.green, lineWidth: 5.0)
                .frame(width: 120.0, height: 120.0)
            
            Spacer()
        }
        
    }
}

struct Day43View_Previews: PreviewProvider {
    static var previews: some View {
        Day43View()
    }
}

// MARK: - View

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: Shape, InsettableShape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmoun = 0.0
    
    func path(in rect: CGRect) -> Path {
        // What’s happening here is two-fold:
        // In the eyes of SwiftUI 0 degrees is not straight upwards, but instead directly to the right.
        // Shapes measure their coordinates from the bottom-left corner rather than the top-left corner, which means SwiftUI goes the other way around from one angle to the other. This is, in my not very humble opinion, extremely alien.
        
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmoun, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    // 將繪製範圍符合目前的frame
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmoun += amount
        
        return arc
    }
}
