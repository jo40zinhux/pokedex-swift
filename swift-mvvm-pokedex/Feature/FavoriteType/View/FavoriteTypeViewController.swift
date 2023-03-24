//
//  FavoriteTypeViewController.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 10/02/23.
//

import UIKit

class FavoriteTypeViewController: UIViewController {
    
    
    // MARK: - Variables
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ImageName.background)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Colors.tintColor
        label.font = label.font.withSize(ValueConst.const28)
        label.numberOfLines = 0
        
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Colors.tintColor
        label.font = label.font.withSize(ValueConst.const18)
        label.text = Text.favoriteLabelSubtitle.localized
        label.numberOfLines = 0
        
        return label
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Text.favoriteButtonTitle.localized, for: .normal)
        button.layer.cornerRadius = ValueConst.const14
        button.isUserInteractionEnabled = true
        button.backgroundColor = Colors.pinkColor
        
        return button
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: Text.favoriteTextFieldPlaceholder.localized,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.tintColor ?? UIColor.white]
        )
        textField.font = textField.font?.withSize(ValueConst.const14)
        textField.autocorrectionType = .no
        textField.keyboardType = .namePhonePad
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        return textField
    }()
    
    private var textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.tintColor
        return view
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLayout()
        setupAction()
        setupLayoutConstraints()
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(nextButton)
        view.addSubview(nameTextField)
        view.addSubview(textFieldView)
        
        let userName = UserDefaults.standard.string(forKey: UserDefaultKeys.userName) ?? ""
        titleLabel.text = "\(Text.favoriteLabelTitle.localized)\(userName)"
        
        nextButton.setEnable(enable: false)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.const48),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.const16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.const16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ValueConst.const24),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.const16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.const16),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ValueConst.const16),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.const8),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.const8),
            nextButton.heightAnchor.constraint(equalToConstant: ValueConst.const40),
            
            nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.const16),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.const16),
            
            textFieldView.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            textFieldView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: ValueConst.const8),
            textFieldView.heightAnchor.constraint(equalToConstant: ValueConst.const1)
        ])
    }
    
    // MARK: - Action Setups
    private func setupAction() {
        nextButton.addTarget(self, action: #selector(goToPokedex), for: .touchUpInside)
    }
    
    @objc private func goToPokedex() {
        let pokedexVC = PokedexViewController()
        self.navigationController?.pushViewController(pokedexVC, animated: true)
    }
}

// MARK: - TextField Delegate
extension FavoriteTypeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let pokemonTypeVC = PokemonTypeViewController()
        pokemonTypeVC.modalPresentationStyle = .pageSheet
        if let sheet = pokemonTypeVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = ValueConst.const24
        }
        pokemonTypeVC.delegate = self
        present(pokemonTypeVC, animated: true, completion: nil)
        return false
    }
}

// MARK: - PokemonType Delegate
extension FavoriteTypeViewController: PokemonFavoriteTypeProtocol {
    func selectedFavoritePokemonType(pokemonType: PokemonType) {
        nameTextField.text = pokemonType.name.capitalized
        nextButton.setEnable(enable: true)
    }
}
