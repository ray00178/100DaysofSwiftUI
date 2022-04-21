//
//  Day20View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/20.
//

import SwiftUI

struct Day20View: View {
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
            
            Button {
                showingAlert = true
            } label: {
                Text("Custom Button")
                    .font(.system(size: 20.0, weight: .bold, design: .default))
                    
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("OK", role: .cancel, action: {})
                Button("Delete", role: .destructive, action: {})
                Button("Think ...", action: {})
            } message: {
                Text("This is content message.")
            }
            .tint(.white)
            .padding(20.0)
            .background(.yellow)
            .cornerRadius(8.0)
            
            Button {
                print("Edit button was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
                    .font(.system(size: 20.0, weight: .medium))
            }
            .tint(.green)
        }
        
        
        /*ZStack {
            VStack(spacing: 0.0) {
                RadialGradient(gradient: Gradient(colors: [.white, .blue]),
                               center: .center,
                               startRadius: 20.0,
                               endRadius: 200.0)
                
                HStack(spacing: 0.0) {
                    Color.blue
                    Color.green
                    LinearGradient(gradient: Gradient(colors: [.purple, .yellow]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                }
                
                AngularGradient(colors: [.red, .brown],
                                center: .center,
                                startAngle: Angle(degrees: 120.0),
                                endAngle: Angle(degrees: 360.0))
            }
            
            Text("Ccontent")
                .foregroundColor(.white)
                .padding(50.0)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()*/
        
        /*VStack(spacing: 20.0) {
            VStack(alignment: .leading, spacing: 20.0) {
                Text("Hello, World!")
                Text("Two lines 🐱")
                    .font(.system(size: 20.0, weight: .semibold, design: .default))
            }
            
            HStack {
                Spacer()
                Text("Hello, World!")
                Text("Two lines 🐱")
                    .font(.system(size: 20.0, weight: .semibold, design: .default))
                Spacer()
            }
            
            ZStack(alignment: .center) {
                Color.red
                    .frame(width: 200.0, height: 200.0)
                Text("Hello, World!")
                Text("Two lines 🐱")
            }
        }
        .padding(.bottom, 20.0)
        .ignoresSafeArea()*/
    }
}

struct Day20View_Previews: PreviewProvider {
    static var previews: some View {
        Day20View()
            //.previewLayout(.sizeThatFits)
    }
}
