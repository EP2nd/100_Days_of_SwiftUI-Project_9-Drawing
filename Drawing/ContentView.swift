//
//  ContentView.swift
//  Drawing
//
//  Created by Edwin Przeźwiecki Jr. on 16/01/2023.
//

import SwiftUI

struct ArrowHead: Shape {
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ArrowShaft: Shape {
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: 200))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
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

struct ContentView: View {
    
    @State private var shaftThickness = 10.0
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            VStack(spacing: -100) {
                ArrowHead()
                    .fill(.gray)
                    .frame(width: 100, height: 100)
                
                ArrowShaft()
                    .stroke(.brown, lineWidth: shaftThickness)
                    .frame(width: 100, height: 100)
            }
            .padding(200)
            
            Spacer()
            
            Slider(value: $shaftThickness, in: 1...20)
                .padding()
        }
        
        VStack {
            ZStack {
                ColorCyclingRectangle(amount: colorCycle)
                    .frame(width: 300, height: 300)
            }
            .padding(200)
          
            Spacer()
            
            Slider(value: $colorCycle)
                .padding([.bottom, .horizontal])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
