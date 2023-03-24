//
//  PokedexViewController.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 11/02/23.
//

import UIKit

class PokedexViewController: UIViewController {
    
    // MARK: - Variables
    var delegate: PokedexProtocol? = nil
    
    lazy var viewModel: PokedexViewModel = {
        let vm = PokedexViewModel()
        vm.delegate = self
        return vm
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ImageName.background)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var pokemonTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 600
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var typeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        return collectionView
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokédex"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchPokedexData()
        viewModel.fetchPokemonTypeListData()
        
        setupLayout()
        setupLayoutConstraints()
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        view.addSubview(backgroundImage)
        view.addSubview(typeCollectionView)
        view.addSubview(pokemonTableView)
        
        typeCollectionView.register(PokemonTypeCollectionViewCell.self, forCellWithReuseIdentifier: PokemonTypeCollectionViewCell.identifier)
        pokemonTableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.identifier)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            typeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            typeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            typeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            typeCollectionView.heightAnchor.constraint(equalToConstant: ValueConst.const128),
            
            pokemonTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pokemonTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pokemonTableView.topAnchor.constraint(equalTo: typeCollectionView.bottomAnchor),
        ])
    }
}

// MARK: - ViewModel Delegate
extension PokedexViewController: PokedexProtocol {
    func fetchPokedexListData() {
        //hide some loader if have
        self.pokemonTableView.reloadData()
        let topIndexPath = IndexPath(row: 0, section: 0)
        self.pokemonTableView.scrollToRow(at: topIndexPath, at: .top, animated: true)
    }
    
    func fetchPokedexListFailData() {
        //hide some loader if have
        //message for error
        self.pokemonTableView.reloadData()
    }
    
    func fetchPokedexTypeData() {
        //hide some loader if have
        self.typeCollectionView.reloadData()
    }
    
    func fetchPokedexTypeFailData() {
        //hide some loader if have
        //message for error
        self.typeCollectionView.reloadData()
    }
}

// MARK: - TableView Delegate
extension PokedexViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier,
                                                       for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        
        let pokemon = viewModel.pokemons[indexPath.row]
        cell.setupCell(idPokemon: "\(pokemon.id)",
                       imagePokemon: pokemon.thumbnailImage,
                       namePokemon: pokemon.thumbnailAltText,
                       typePokemon: pokemon.type)
        return cell
    }
}

// MARK: - CollectionViewDelegate
extension PokedexViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonTypeCollectionViewCell.identifier, for: indexPath) as? PokemonTypeCollectionViewCell else {return UICollectionViewCell()}
        
        let type = viewModel.types[indexPath.row]
        cell.setupCell(typeImage: type.thumbnailImage, typeName: type.name.capitalized)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ValueConst.const128, height: ValueConst.const128)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedType = viewModel.types[indexPath.row]
        viewModel.filterPokemonByType(type: selectedType)
    }
}
