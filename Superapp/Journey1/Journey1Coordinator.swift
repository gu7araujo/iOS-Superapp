//
//  Journey1Coordinator.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import Foundation
import UIKit

protocol Journey1CoordinatorDelegate: AnyObject {
    func navigateToJourney4()
}

class Journey1Coordinator: CoordinatorProtocol {
    
    weak var delegate: (any Journey1CoordinatorDelegate)?
    weak var finishDelegate: (any CoordinatorFinishDelegate)?
    var navigationController: UINavigationController
    var childCoordinators: [any CoordinatorProtocol] = []
    var childControllers: [UIViewController] = []
    var parentCoordinator: (any CoordinatorProtocol)?
    var type: CoordinatorType = .journey1
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(Journey1Coordinator.self) deinit")
    }
    
    func start() {
        let viewModel = HomeViewModel()
        viewModel.delegate = self
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        childControllers.append(viewController)
    }
}

extension Journey1Coordinator: HomeViewModelDelegate {
    func navigateToJourney4() {
        delegate?.navigateToJourney4()
    }
}
