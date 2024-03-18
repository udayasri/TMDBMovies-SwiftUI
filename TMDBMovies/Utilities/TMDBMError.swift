//
//  TMDBMError.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import Foundation


enum TMDBMError: Error {
    case invalidUrl(description:String)
    case dataDecodingError(description:String)
    case dataFetchingError(description: String)
}
