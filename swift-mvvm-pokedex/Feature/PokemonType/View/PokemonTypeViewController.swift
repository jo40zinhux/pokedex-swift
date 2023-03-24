//
//  PokemonTypeViewController.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 10/02/23.
//

import UIKit

class PokemonTypeViewController: UIViewController {
    
    // MARK: - Variables
    var delegate: PokemonFavoriteTypeProtocol? = nil
    
    lazy var viewModel: PokemonTypeViewModel = {
        let vm = PokemonTypeViewModel()
        vm.delegate = self
        return vm
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.greenColor
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchData()
        setupLayout()
        setupLayoutConstraints()
    }
    
    // MARK: - Laytou Setups
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.register(PokemonTypeTableViewCell.self,
                           forCellReuseIdentifier: PokemonTypeTableViewCell.identifier)
        view.backgroundColor = Colors.greenColor
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK: - ViewModel Delegate
extension PokemonTypeViewController: PokemonTypeProtocol {
    func fetchData() {
        //hide some loader if have
        self.tableView.reloadData()
    }
    
    func fetchFailData() {
        //hide some loader if have
        //message for error
        self.tableView.reloadData()
    }
}

// MARK: - TableView Delegate
extension PokemonTypeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTypeTableViewCell.identifier,
                                                       for: indexPath) as? PokemonTypeTableViewCell else {return UITableViewCell()}
        
        let pokemontype = viewModel.types[indexPath.row]
        
        cell.setupCell(type: pokemontype.name.capitalized,
                       iconType: pokemontype.thumbnailImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pokemontype = viewModel.types[indexPath.row]
        delegate?.selectedFavoritePokemonType(pokemonType: pokemontype)
        self.dismiss(animated: true)
    }
}
