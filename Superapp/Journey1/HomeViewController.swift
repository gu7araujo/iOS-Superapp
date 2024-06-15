//
//  HomeViewController.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import Foundation
import UIKit
import Combine

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel
    private var cancellables: Set<AnyCancellable> = []

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Counter"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Core.shared.badgeValue)"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Increase", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(increaseValue), for: .touchUpInside)
        return button
    }()
    
    let decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Decrease", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(decreaseValue), for: .touchUpInside)
        return button
    }()
    
    let divisionLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let navigateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Navigate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateToNextScreen), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(counterLabel)
        view.addSubview(increaseButton)
        view.addSubview(decreaseButton)
        view.addSubview(divisionLine)
        view.addSubview(navigateButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            counterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            increaseButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            increaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            decreaseButton.topAnchor.constraint(equalTo: increaseButton.bottomAnchor, constant: 20),
            decreaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            divisionLine.topAnchor.constraint(equalTo: decreaseButton.bottomAnchor, constant: 20),
            divisionLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            divisionLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            divisionLine.heightAnchor.constraint(equalToConstant: 1),
            
            navigateButton.topAnchor.constraint(equalTo: divisionLine.bottomAnchor, constant: 20),
            navigateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        bindBadgeValue()
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindBadgeValue() {
        Core.shared.$badgeValue
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.counterLabel.text = "\(value)"
            }
            .store(in: &cancellables)
    }
    
    @objc func increaseValue() {
        Core.shared.badgeValue += 1
    }
    
    @objc func decreaseValue() {
        Core.shared.badgeValue -= 1
    }
    
    @objc func navigateToNextScreen() {
        viewModel.navigateToJourney4()
    }
}
