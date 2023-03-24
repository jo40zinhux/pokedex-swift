//
//  PokedexViewModel.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 16/02/23.
//

import Foundation

class PokedexViewModel {
    // MARK: - Variables
    public var types: [PokemonType] = []
    public var pokemons: [Pokemon] = []
    public var delegate: PokedexProtocol?
    private var fullListPokemon: [Pokemon] = []
    
    // MARK: - Fetch Methods
    func fetchPokedexData() {
        ApiWorker.shared.requestObject(endpoint: Endpoint.pokeList.url,
                                       method: .get,
                                       headers: nil,
                                       type: [Pokemon].self,
                                       encoder: .json) { [weak self] result in
            switch result {
            case .success(let output):
                self?.pokemons = output
                self?.filterPokemons()
            case .failure:
                self?.pokemons = []
                self?.delegate?.fetchPokedexListFailData()
            }
        }
    }
    
    func fetchPokemonTypeListData() {
        ApiWorker.shared.requestObject(endpoint: Endpoint.types.url,
                                       method: .get,
                                       headers: nil,
                                       type: PokemonTypeList.self,
                                       encoder: .json) { [weak self] result in
            switch result {
            case .success(let output):
                self?.types = output.results
                self?.delegate?.fetchPokedexTypeData()
            case .failure:
                self?.types = []
                self?.delegate?.fetchPokedexTypeFailData()
            }
        }
    }
    
    // MARK: - Filter Methods
    func filterPokemonByType(type: PokemonType) {
        guard let typeEnum = TypeElement(rawValue: type.name) else { return }
        pokemons = fullListPokemon
        pokemons = pokemons.filter({ ($0.type.contains(typeEnum)) })
        delegate?.fetchPokedexListData()
    }
    
    private func filterPokemons() {
        self.pokemons = self.pokemons.filterDuplicate{ ($0.id) }
        self.fullListPokemon = self.pokemons
        delegate?.fetchPokedexListData()
    }
}
