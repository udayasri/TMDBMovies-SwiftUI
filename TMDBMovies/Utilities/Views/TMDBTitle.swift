//
//  TMDBTitle.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-21.
//

import SwiftUI

/// TMDB Title : Custom Title specific for TMDBTitle
public struct TMDBTitle<Content: View>: View {
    
    let configuration : TMDBTitleConfiguration
    let content: Content
    
    init(configuration: TMDBTitleConfiguration = TMDBTitleConfiguration(), @ViewBuilder content: () -> Content) {
        self.configuration = configuration
        self.content = content()
    }
    
    public var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(configuration.font)
            .fontWeight(.medium)
            .foregroundColor(Color(.label))
            .lineLimit(2)
            .minimumScaleFactor(0.8)
            .multilineTextAlignment(.leading)
            .padding()
    }
}



/// Configuration for the TMDMTitle
public struct TMDBTitleConfiguration {
    
    public let font:  Font
    public let fontWeight: Font.Weight
    
    public init(font: Font = .body, fontWeight: Font.Weight = .regular) {
        self.font = font
        self.fontWeight = fontWeight
    }
}


#Preview {
    TMDBTitle {
        Text("Sample Title")
    }
}
