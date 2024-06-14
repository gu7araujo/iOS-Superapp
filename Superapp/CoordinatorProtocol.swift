//
//  CoordinatorProtocol.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import UIKit
import Foundation

public enum CoordinatorType {
    case journey1, journey2, journey3
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

protocol CoordinatorProtocol: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
    
    init(_ navigationController: UINavigationController)
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
