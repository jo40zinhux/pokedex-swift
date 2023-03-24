//
//  PokemonTypeViewModel.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 16/02/23.
//

import Foundation

class PokemonTypeViewModel {
    // MARK: - Variables
    public var types: [PokemonType] = []
    public var delegate: PokemonTypeProtocol?
    
    
    // MARK: - Methods
    /// Get API Data for View Model - Pokemon Type List
    func fetchData() {
        ApiWorker.shared.requestObject(endpoint: Endpoint.types.url,
                                       method: .get,
                                       headers: nil,
                                       type: PokemonTypeList.self,
                                       encoder: .json) { [weak self] result in
            switch result {
            case .success(let output):
                self?.types = output.results
                self?.delegate?.fetchData()
            case .failure:
                self?.types = []
                self?.delegate?.fetchFailData()
            }
        }
    }
}
