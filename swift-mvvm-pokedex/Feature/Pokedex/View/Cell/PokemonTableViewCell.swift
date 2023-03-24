//
//  PokemonTableViewCell.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 11/02/23.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    static let identifier = "PokemonIdentifier"
    
    private var viewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ValueConst.const12
        view.backgroundColor = Colors.tintColor
        return view
    }()
    
    private var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage()
        
        return imageView
    }()
    
    private var informationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ValueConst.const12
        view.backgroundColor = Colors.secondTintColor
        return view
    }()
    
    private var pokemonIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Colors.tintColor
        label.font = label.font.withSize(ValueConst.const14)
        label.text = " "
        
        label.numberOfLines = 0
        
        return label
    }()
    
    private var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Colors.tintColor
        label.font = label.font.withSize(ValueConst.const24)
        label.text = " "
        
        label.numberOfLines = 0
        
        return label
    }()
    
    private var pokemonType1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Colors.tintColor
        label.font = label.font.withSize(ValueConst.const14)
        label.text = " "
        label.backgroundColor = .blue
        
        label.numberOfLines = 0
        
        return label
    }()
    
    private var pokemonType2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Colors.tintColor
        label.font = label.font.withSize(ValueConst.const14)
        label.text = " "
        label.backgroundColor = .blue
        label.isHidden = true
        
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - View LifeCycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        backgroundColor = .clear
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(pokemonImageView)
        viewBackground.addSubview(informationView)
        informationView.addSubview(pokemonIdLabel)
        informationView.addSubview(pokemonNameLabel)
        informationView.addSubview(pokemonType1Label)
        informationView.addSubview(pokemonType2Label)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ValueConst.const8),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ValueConst.const8),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ValueConst.const8),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ValueConst.const8),
            
            informationView.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.const8),
            informationView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.const8),
            informationView.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.const8),
            informationView.heightAnchor.constraint(equalToConstant: ValueConst.const168),
            
            pokemonImageView.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.const8),
            pokemonImageView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.const8),
            pokemonImageView.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.const8),
            pokemonImageView.bottomAnchor.constraint(equalTo: informationView.topAnchor, constant: ValueConst.const8),
            
            pokemonIdLabel.topAnchor.constraint(equalTo: informationView.topAnchor, constant: ValueConst.const8),
            pokemonIdLabel.leadingAnchor.constraint(equalTo: informationView.leadingAnchor, constant: ValueConst.const8),

            pokemonType1Label.bottomAnchor.constraint(equalTo: informationView.bottomAnchor, constant: -ValueConst.const8),
            pokemonType1Label.leadingAnchor.constraint(equalTo: informationView.leadingAnchor, constant: ValueConst.const8),
            pokemonType1Label.heightAnchor.constraint(equalToConstant: ValueConst.const18),
            pokemonType1Label.widthAnchor.constraint(equalToConstant: ValueConst.const128),
            
            pokemonType2Label.bottomAnchor.constraint(equalTo: pokemonType1Label.bottomAnchor),
            pokemonType2Label.leadingAnchor.constraint(equalTo: pokemonType1Label.trailingAnchor, constant: ValueConst.const8),
            pokemonType2Label.heightAnchor.constraint(equalToConstant: ValueConst.const18),
            pokemonType2Label.widthAnchor.constraint(equalToConstant: ValueConst.const128),

            pokemonNameLabel.topAnchor.constraint(equalTo: pokemonIdLabel.bottomAnchor, constant: ValueConst.const24),
            pokemonNameLabel.bottomAnchor.constraint(equalTo: pokemonType1Label.topAnchor, constant: ValueConst.const8),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonType1Label.leadingAnchor),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: informationView.trailingAnchor, constant: -ValueConst.const8),
        ])
    }
    
    func setupCell(idPokemon: String, imagePokemon: String, namePokemon: String, typePokemon: [TypeElement]) {
        pokemonIdLabel.text = "#\(idPokemon)"
        
        if let url = URL(string: imagePokemon) {
            pokemonImageView.load(url: url)
        } else {
            pokemonImageView.image = UIImage()
        }
        
        pokemonNameLabel.text = namePokemon
        pokemonType1Label.text = typePokemon.first?.rawValue ?? ""
        pokemonType1Label.backgroundColor = colorForType(type: typePokemon.first)
        
        if typePokemon.count > 1 {
            pokemonType2Label.isHidden = false
            pokemonType2Label.text = typePokemon.last?.rawValue ?? ""
            pokemonType2Label.backgroundColor = colorForType(type: typePokemon.last)
        } else {
            pokemonType2Label.isHidden = true
            pokemonType2Label.text = ""
        }
    }
    
    
    /// Change backgroundColor By Pokemon Type
    /// - Parameter type: The Type of Pokemon
    /// - Returns: Return the new color by PokemonType
    private func colorForType(type: TypeElement?) -> UIColor {
        guard let typePokemon = type else {return .clear}
        
        var bgColor: UIColor = .clear
        switch typePokemon {
        case .normal:
            bgColor = TypeColor.normalColor
        case .fighting:
            bgColor = TypeColor.fightColor
        case .flying:
            bgColor = TypeColor.flyingColor
        case .poison:
            bgColor = TypeColor.poisonColor
        case .ground:
            bgColor = TypeColor.groundColor
        case .rock:
            bgColor = TypeColor.rockColor
        case .bug:
            bgColor = TypeColor.bugColor
        case .ghost:
            bgColor = TypeColor.ghostColor
        case .steel:
            bgColor = TypeColor.steelColor
        case .fire:
            bgColor = TypeColor.fireColor
        case .water:
            bgColor = TypeColor.waterColor
        case .grass:
            bgColor = TypeColor.grassColor
        case .electric:
            bgColor = TypeColor.electricColor
        case .psychic:
            bgColor = TypeColor.psychicColor
        case .ice:
            bgColor = TypeColor.iceColor
        case .dragon:
            bgColor = TypeColor.dragonColor
        case .dark:
            bgColor = TypeColor.darkColor
        case .fairy:
            bgColor = TypeColor.fairyColor
        }
        
        return bgColor
    }
}
