//
//  PokemonTypeTableViewCell.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 10/02/23.
//

import UIKit
import IQKeyboardManagerSwift

class PokemonTypeTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "PokemonTypeTableIdentifier"
    
    private var viewBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ValueConst.const12
        view.backgroundColor = Colors.tintColor
        
        return view
    }()
    
    private var typeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Colors.secondTintColor
        label.font = label.font.withSize(ValueConst.const14)
        label.text = " "
        label.numberOfLines = 0
        
        return label
    }()
    
    private var typeImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage()
        
        return imageView
        
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
    
    // MARK: - Layout Setup
    private func setupLayout() {
        backgroundColor = .clear
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(typeImageView)
        viewBackground.addSubview(typeLabel)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ValueConst.const8),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ValueConst.const8),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ValueConst.const8),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ValueConst.const8),
            
            typeImageView.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.const8),
            typeImageView.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.const8),
            typeImageView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: ValueConst.const8),
            typeImageView.widthAnchor.constraint(equalToConstant: ValueConst.const48),
            typeImageView.heightAnchor.constraint(equalToConstant: ValueConst.const48),
            
            typeLabel.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: ValueConst.const8),
            typeLabel.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -ValueConst.const8),
            typeLabel.leadingAnchor.constraint(equalTo: typeImageView.trailingAnchor, constant: ValueConst.const8),
            typeLabel.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -ValueConst.const8),
        ])
    }
    
    func setupCell(type: String, iconType: String) {
        typeLabel.text = type
        if let url = URL(string: iconType) {
            typeImageView.load(url: url)
        } else {
            typeImageView.image = UIImage()
        }
    }
}
