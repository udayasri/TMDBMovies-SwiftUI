//
//  TMDBAlert.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

struct TMDBAlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct TMDBAlertContext {
    static func errorAlert(error: TMDBMError?) -> TMDBAlertItem {
        switch error {
        case .dataFetchingError(description: let description):
            return TMDBAlertItem(title: Text("Oops!"),
                                 message: Text(description),
                                 dismissButton: .default(Text("OK")))
            
        case .dataDecodingError(description: _):
            return TMDBAlertItem(title: Text("Data Format Update"),
                                 message: Text("Format of your data has been changed"),
                                 dismissButton: .default(Text("OK")))
            
        case .invalidUrl(description: let description):
            return TMDBAlertItem(title: Text("Error"),
                                 message: Text(description),
                                 dismissButton: .default(Text("OK")))
            
        case .none:
            return TMDBAlertItem(title: Text("Error"),
                                 message: Text(error?.localizedDescription ?? "General Error"),
                                 dismissButton: .default(Text("OK")))
        
        }
    }
}
