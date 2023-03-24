//
//  Pokemon.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 16/02/23.
//

import Foundation

struct Pokemon: Decodable  {
    let abilities: [String]
    let detailPageURL: String
    let weight: Double
    let weakness: [String]
    let number: String
    let height: Double
    let collectibles_slug: String
    let featured: String
    let slug: String
    let name: String
    let thumbnailAltText: String
    let thumbnailImage: String
    let id: Int
    let type: [TypeElement]
}

public enum TypeElement: String, Decodable {
    case normal = "normal"
    case fighting = "fighting"
    case flying = "flying"
    case poison = "poison"
    case ground = "ground"
    case rock = "rock"
    case bug = "bug"
    case ghost = "ghost"
    case steel = "steel"
    case fire = "fire"
    case water = "water"
    case grass = "grass"
    case electric = "electric"
    case psychic = "psychic"
    case ice = "ice"
    case dragon = "dragon"
    case dark = "dark"
    case fairy = "fairy"
}
