//
//  TMDBAlert.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

struct TMDBAlertItem: Identifiable {
    let id = UUID()
    let titleString: String
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    let actionButton = Button<Text>(action: {}, label: { Text("Ok") })
}

struct TMDBAlertContext {
    
    // Static functions and properties are class-level members that belong to the type itself, rather than an instance of the type. This means that they can be called without having to create an instance of the class or struct. In Swift, the keyword static is used to define a static function or property.
    
    static func errorAlert(error: TMDBMError?) -> TMDBAlertItem {
        switch error {
        case .dataFetchingError(description: let description):
            return TMDBAlertItem(titleString: "Oops!", 
                                 title: Text("Oops!"),
                                 message: Text(description),
                                 dismissButton: .default(Text("OK")))
            
        case .dataDecodingError(description: _):
            return TMDBAlertItem(titleString: "Data Format Update", 
                                 title: Text("Data Format Update"),
                                 message: Text("Format of your data has been changed"),
                                 dismissButton: .default(Text("OK")))
            
        case .invalidUrl(description: let description):
            return TMDBAlertItem(titleString: "Error", 
                                 title: Text("Error"),
                                 message: Text(description),
                                 dismissButton: .default(Text("OK")))
            
        case .none:
            return TMDBAlertItem(titleString: "Error", 
                                 title: Text("Error"),
                                 message: Text(error?.localizedDescription ?? "General Error"),
                                 dismissButton: .default(Text("OK")))
        }
    }
}
