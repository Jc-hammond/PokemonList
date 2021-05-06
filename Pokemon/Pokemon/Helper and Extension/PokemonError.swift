//
//  PokemonError.swift
//  Pokemon
//
//  Created by Connor Hammond on 5/5/21.
//

import Foundation

enum PokemonError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the serer"
        case .thrownError(let error):
            print(error.localizedDescription)
            return "That pokemon does not exist\nPlease check your spelling"
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "The server responed with bad data. Blame the back end team, not front end"
        }
    }
}//End of enum

