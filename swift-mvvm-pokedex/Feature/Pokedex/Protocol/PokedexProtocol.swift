//
//  PokedexProtocol.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 16/02/23.
//

import Foundation

protocol PokedexProtocol {
    func fetchPokedexListData()
    func fetchPokedexListFailData()
    func fetchPokedexTypeData()
    func fetchPokedexTypeFailData()
}
