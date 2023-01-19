//
//  ContentView.swift
//  Drawing
//
//  Created by Edwin Przeźwiecki Jr. on 16/01/2023.
//

import SwiftUI

/// Challenge 1:
struct ArrowHead: Shape {
    
    /// Challenge 2:
    var headWidth = 0.5
    
    /// Challenge 2:
    var animatableData: Double {
        get { headWidth }
        set { headWidth = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        /// Challenge 2:
        let headWidth = rect.width * headWidth / 2
        
        /// Challenge 2:
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + headWidth, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX - headWidth, y: rect.maxY))
            path.closeSubpath()
        }
    }
}
    
/// Challenge 1:
struct ArrowShaft: Shape {
    
    /// Challenge 2:
    var shaftThickness = 10.0
    
    /// Challenge 2:
    var animatableData: Double {
        get { shaftThickness }
        set { shaftThickness = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        /// Challenge 2:
        return Path { path in
            path.move(to: CGPoint(x: rect.midX + shaftThickness, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX + shaftThickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - shaftThickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - shaftThickness, y: rect.minY))
            path.closeSubpath()
        }
    }
}

/// Challenge 3:
struct ColorCyclingRectangle: View {
    
    var amount = 0.0
    var steps = 100
    
    var gradientStartX = 0.5
    var gradientStartY = 0.0
    var gradientEndX = 0.5
    var gradientEndY = 1.0
    
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
                            startPoint: UnitPoint(x: gradientStartX, y: gradientStartY),
                            endPoint: UnitPoint(x: gradientEndX, y: gradientEndY)
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
    
    /// Challenge 2:
    @State private var headWidth = 0.5
    @State private var shaftThickness = 20.0
    
    @State private var gradientStartX = 0.5
    @State private var gradientStartY = 0.0
    @State private var gradientEndX = 0.5
    @State private var gradientEndY = 1.0
    
    /// Challenge 3:
    @State private var colorCycle = 0.0
    
    var body: some View {
        /// Challenge 1 and 2:
        VStack {
            VStack(spacing: 0) {
                ArrowHead(headWidth: headWidth)
                    .fill(.gray)
                
                ArrowShaft(shaftThickness: shaftThickness)
                    .fill(.brown)
            }
            .onTapGesture {
                withAnimation {
                    headWidth = Double.random(in: 0.2...0.8)
                    shaftThickness = Double.random(in: 10...20)
                }
            }
        }
        /// Challenge 3:
        VStack {
            VStack {
                ColorCyclingRectangle(amount: colorCycle, gradientStartX: gradientStartX, gradientStartY: gradientStartY, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
                    .frame(width: 300, height: 300)
            }
            .padding()
            
            Group {
                Text("Color:")
                Slider(value: $colorCycle)
                
                Text("Gradient's X start point:")
                Slider(value: $gradientStartX)
                
                Text("Gradient's Y start point:")
                Slider(value: $gradientStartY)
                
                Text("Gradient's X end point:")
                Slider(value: $gradientEndX)
                
                Text("Gradient's Y end point:")
                Slider(value: $gradientEndY)
            }
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
