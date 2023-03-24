//
//  PokemonType.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 16/02/23.
//

import Foundation

struct PokemonTypeList: Decodable {
    let results: [PokemonType]
}

struct PokemonType: Decodable {
    let thumbnailImage: String
    let name: String
    let _id: Int
}
