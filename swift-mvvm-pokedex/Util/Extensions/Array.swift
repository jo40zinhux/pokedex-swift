//
//  Array.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 16/02/23.
//

import Foundation

extension Array {
    func filterDuplicate<T>(_ keyValue:(Element)->T) -> [Element] {
        var uniqueKeys = Set<String>()
        return filter{uniqueKeys.insert("\(keyValue($0))").inserted}
    }
}
