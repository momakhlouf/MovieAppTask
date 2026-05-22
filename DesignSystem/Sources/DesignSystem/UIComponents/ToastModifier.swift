//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import SwiftUI

public struct ToastModifier: ViewModifier {
    @Binding var message: String?
  
   public init(message: Binding<String?>) {
       self._message = message
    }
    public func body(content: Content) -> some View {
        ZStack{
            content
            if let message {
                VStack {
                    Spacer()
                    Text(message)
                        .padding()
                        .background(.yellow.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                .transition(.move(edge: .top))
            }
        }
        .animation(.easeInOut, value: message)
    }
}

extension View {
   public func toast(message: Binding<String?>) -> some View {
        modifier(ToastModifier(message: message))
    }
}

