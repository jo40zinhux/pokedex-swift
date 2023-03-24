//
//  PokemonTypeCollectionViewCell.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 11/02/23.
//

import UIKit

class PokemonTypeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    private var viewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ValueConst.const12
        view.backgroundColor = Colors.tintColor
        return view
    }()
    
    private var typeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.image = UIImage()
        
        return imageView
    }()
    
    private var typeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Colors.secondTintColor
        label.font = label.font.withSize(ValueConst.const14)
        label.text = " "
        
        label.numberOfLines = 0
        
        return label
    }()
    
    static let identifier = "PokemonTypeIdentifier"
    
    // MARK: - View LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        backgroundColor = .clear
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(typeImageView)
        viewBackground.addSubview(typeNameLabel)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ValueConst.const8),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ValueConst.const8),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ValueConst.const8),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ValueConst.const8),
            
            typeImageView.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.const8),
            typeImageView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.const8),
            typeImageView.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.const8),
            typeImageView.heightAnchor.constraint(equalToConstant: ValueConst.const64),
            
            typeNameLabel.topAnchor.constraint(equalTo: typeImageView.bottomAnchor, constant: ValueConst.const8),
            typeNameLabel.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.const8),
            typeNameLabel.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.const8),
            typeNameLabel.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.const8),  
        ])
    }
    
    func setupCell(typeImage: String, typeName: String) {
        typeNameLabel.text = typeName
        
        if let url = URL(string: typeImage) {
            typeImageView.load(url: url)
        } else {
            typeImageView.image = UIImage()
        }
    }
}
