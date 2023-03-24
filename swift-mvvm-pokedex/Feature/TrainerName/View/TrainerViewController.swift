//
//  TrainerViewController.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 08/02/23.
//

import UIKit

class TrainerViewController: UIViewController {
    
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
        label.text = Text.meetLabelTitle.localized
        label.numberOfLines = 0
        
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Colors.tintColor
        label.font = label.font.withSize(ValueConst.const18)
        label.text = Text.meetLabelSubtitle.localized
        label.numberOfLines = 0
        
        return label
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Text.meetButtonTitle.localized, for: .normal)
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
            string: Text.meetTextFieldPlaceholder.localized,
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
    
    // MARK: - View LifeCycle
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
        nextButton.addTarget(self, action: #selector(goToSelectPokemonType), for: .touchUpInside)
    }
    
    @objc private func goToSelectPokemonType() {
        UserDefaults.standard.set(nameTextField.text, forKey: UserDefaultKeys.userName)
        let favTypeVC = FavoriteTypeViewController()
        self.navigationController?.pushViewController(favTypeVC, animated: true)
    }
}

// MARK: - TextField Delegate
extension TrainerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let enable = !(text.count <= 1 && string.isEmpty)
        nextButton.setEnable(enable: enable)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
