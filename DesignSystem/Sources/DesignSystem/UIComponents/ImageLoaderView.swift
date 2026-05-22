//
//  SwiftUIView.swift
//  Commons
//
//  Created by Mohamed Makhlouf Ahmed on 20/05/2026.
//

import SwiftUI
import SDWebImageSwiftUI

public struct ImageLoaderView: View {
    public let url: URL?
    public let contentMode: ContentMode
    public let width: CGFloat?
    public var height: CGFloat?
    
    public init(url: URL?, contentMode: ContentMode, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.url = url
        self.contentMode = contentMode
        self.width = width
        self.height = height
    }
    public var body: some View {
        WebImage(url: url) { image in
            image
                .resizable()
                .frame(width: width, height: height)
                .aspectRatio(contentMode: contentMode)
        } placeholder: {
            Color.gray.opacity(0.2)
                .frame(width: width, height: height)
        }
    }
}

#Preview {
   // ImageLoaderView()
}
