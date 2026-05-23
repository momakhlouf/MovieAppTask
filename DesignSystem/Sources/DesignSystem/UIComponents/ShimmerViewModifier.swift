//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2026.
//

import SwiftUI

public struct ShimmerViewModifier: ViewModifier{
    public let speed: Double
    public let color: Color
    public let angle: Double
    public let animateOpacity: Bool
    public let animateScale: Bool
    @State public var move: Bool = false
    init(speed: Double, color: Color, angle: Double, animateOpacity: Bool, animateScale: Bool) {
        self.speed = speed
        self.color = color
        self.angle = angle
        self.animateOpacity = animateOpacity
        self.animateScale = animateScale
    }
    public func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader{ geometry in
                    let gradient = LinearGradient(gradient: Gradient(colors:
                                                                        [color.opacity(0),
                                                                         color.opacity(0.5),
                                                                         color.opacity(0)]),
                                                  startPoint: .leading,
                                                  endPoint: .trailing
                    )
                    Rectangle()
                        .fill(gradient)
                        .rotationEffect(.degrees(angle))
                        .frame(width: geometry.size.width / 2.5, height: geometry.size.height * 2.5)
                        .offset(x: move ? geometry.size.width * 1.1 : -geometry.size.width * 1.4, y: -geometry.size.height / 2)
                        .animation(.linear(duration: speed).repeatForever(autoreverses: false), value: move)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                move = true
                            }
                        }
                }
            }
            .mask(content)
            .scaleEffect(animateScale ? (move ? 1 : 0.95) : 1)
            .opacity(animateOpacity ? (move ? 1 : 0.95) : 1)
            .animation((animateScale || animateOpacity) ? .linear(duration: 2).repeatForever(autoreverses: true) : nil, value: move
            )
    }
}

extension View{
    public func shimmer(speed: Double = 1.5, color: Color = .white, angle: Double = 0, animateOpacity: Bool = false, animateScale: Bool = false) -> some View{
        self.modifier(ShimmerViewModifier(speed: speed, color: color, angle: angle, animateOpacity: animateOpacity, animateScale: animateScale))
    }
}
