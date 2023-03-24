//
//  IntroViewController.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 08/02/23.
//

import UIKit

class IntroViewController: UIViewController {
    
    // MARK: - Variables
    private var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ImageName.pokemonLogo)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var subLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ImageName.finderLogo)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var pikachuImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ImageName.pikachu)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ImageName.background)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Text.introButtonTitle.localized, for: .normal)
        button.layer.cornerRadius = ValueConst.const14
        button.isUserInteractionEnabled = true
        button.backgroundColor = Colors.pinkColor
        
        return button
    }()
    
    // MARK: - View LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLayout()
        setupLayoutConstraints()
        setupAction()
    }
    
    // MARK: - Layout Setups
    private func setupLayout() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImage)
        view.addSubview(subLogoImage)
        view.addSubview(pikachuImage)
        view.addSubview(startButton)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ValueConst.const16),
            logoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.const8),
            logoImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.const8),
            
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.const16),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.const16),
            startButton.heightAnchor.constraint(equalToConstant: ValueConst.const40),
            
            subLogoImage.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: ValueConst.const12),
            subLogoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ValueConst.const8),
            subLogoImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -ValueConst.const8),
            
            pikachuImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pikachuImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    // MARK: - Action Setups
    private func setupAction() {
        startButton.addTarget(self, action: #selector(getStartFlow), for: .touchUpInside)
    }
    
    @objc private func getStartFlow() {
        let trainerVC = TrainerViewController()
        self.navigationController?.pushViewController(trainerVC, animated: true)
    }
}
