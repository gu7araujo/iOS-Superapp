//
//  Journey4ViewController.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 15/06/24.
//

import Foundation
import UIKit
import Combine
import Core

class Journey4ViewController: UIViewController {
    
    var viewModel: Journey4ViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Finish Journey", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(finishJourney), for: .touchUpInside)
        return button
    }()
    
    let divisionLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        label.text = "\(Shared.shared.badgeValue)"
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
    
    init(viewModel: Journey4ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        view.addSubview(finishButton)
        view.addSubview(divisionLine)
        view.addSubview(titleLabel)
        view.addSubview(counterLabel)
        view.addSubview(increaseButton)
        view.addSubview(decreaseButton)
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            divisionLine.topAnchor.constraint(equalTo: finishButton.bottomAnchor, constant: 20),
            divisionLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            divisionLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            divisionLine.heightAnchor.constraint(equalToConstant: 1),
            
            titleLabel.topAnchor.constraint(equalTo: divisionLine.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            counterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            increaseButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            increaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            decreaseButton.topAnchor.constraint(equalTo: increaseButton.bottomAnchor, constant: 20),
            decreaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        bindBadgeValue()
    }
    
    private func bindBadgeValue() {
        Shared.shared.$badgeValue
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.counterLabel.text = "\(value)"
            }
            .store(in: &cancellables)
    }
    
    @objc func finishJourney() {
        viewModel.finishJourney()
    }
    
    @objc func increaseValue() {
        Shared.shared.badgeValue += 1
    }
    
    @objc func decreaseValue() {
        Shared.shared.badgeValue -= 1
    }
}
