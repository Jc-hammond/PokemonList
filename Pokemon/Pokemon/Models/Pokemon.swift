//
//  Pokemon.swift
//  Pokemon
//
//  Created by Connor Hammond on 5/5/21.
//

import Foundation

struct TopLevelObject: Codable {
    let results: [SecondLevleObject]
}

struct SecondLevleObject: Codable {
    let name: String
    let url: URL?
}

struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: Sprites
    let abilities: [Abilities]
}

struct Sprites: Codable {
    let classic: URL?
            
    enum CodingKeys: String, CodingKey {
        case classic = "front_default"
        }
    }

struct Abilities: Codable {
        let ability: Ability
    
    struct Ability: Codable {
        let name: String
    }
}
