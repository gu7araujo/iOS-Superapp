//
//  CoordinatorProtocol.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import UIKit
import Foundation

public enum CoordinatorType {
    case tab, journey1, journey2, journey3, journey4
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

protocol CoordinatorProtocol: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var childControllers: [UIViewController] { get set }
    var parentCoordinator: CoordinatorProtocol? { get set }
    var type: CoordinatorType { get }
    
    init(_ navigationController: UINavigationController)
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    func finish() {
        var viewControllers = navigationController.viewControllers
        childControllers.forEach { viewController in viewControllers.removeAll { $0 === viewController } }
        
        if let lastViewController = viewControllers.last {
            navigationController.popToViewController(lastViewController, animated: true)
        }
        
        childControllers.removeAll()
        childCoordinators.removeAll()
        parentCoordinator = nil
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
