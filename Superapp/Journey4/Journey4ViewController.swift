//
//  Journey4ViewController.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 15/06/24.
//

import Foundation
import UIKit

class Journey4ViewController: UIViewController {
    
    var viewModel: Journey4ViewModel
    
    let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Finish Journey", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(finishJourney), for: .touchUpInside)
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
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func finishJourney() {
        viewModel.finishJourney()
    }
}
