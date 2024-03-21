//
//  TMDBTitleModifier.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-21.
//

import SwiftUI

@available(*, deprecated, message: "Use TMDBTitle(configuration:_){...}")

/// Custom modifier for all the titles
public struct TMDBTitleModifier: ViewModifier {
    
    let font: Font
    
    public init(font: Font){
        self.font = font
    }
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(font)
            .fontWeight(.medium)
            .foregroundColor(Color(.label))
            .lineLimit(2)
            .minimumScaleFactor(0.8)
            .multilineTextAlignment(.leading)
            .padding()
    }
}


