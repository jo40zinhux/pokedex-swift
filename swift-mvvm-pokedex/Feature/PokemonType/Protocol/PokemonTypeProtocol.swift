//
//  PokemonFavoriteTypeProtocol.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 16/02/23.
//

import Foundation

protocol PokemonFavoriteTypeProtocol {
    func selectedFavoritePokemonType(pokemonType: PokemonType)
}

protocol PokemonTypeProtocol {
    func fetchData()
    func fetchFailData()
}
