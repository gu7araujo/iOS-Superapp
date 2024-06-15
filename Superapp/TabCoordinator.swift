//
//  TabCoordinator.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import Foundation
import UIKit
import Combine

protocol TabCoordinatorProtocol: CoordinatorProtocol {
    var tabBarController: UITabBarController { get set }
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {
    
    var tabBarController: UITabBarController
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    var childControllers: [UIViewController] = []
    var parentCoordinator: (any CoordinatorProtocol)? = nil
    var type: CoordinatorType = .tab

    private var cancellables: Set<AnyCancellable> = []

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    deinit {
        print("\(TabCoordinator.self) deinit")
    }

    func start() {
        let pages = TabSections.allCases.sorted { $0.order < $1.order }
        let controllers = pages.map { getTabController(for: $0) }
        prepareTabBarController(with: controllers)
        bindBadgeValue()
    }
    
    private func bindBadgeValue() {
        Core.shared.$badgeValue
            .sink { [weak self] value in
                self?.tabBarController.tabBar.items?[0].badgeValue = "\(value)"
            }
            .store(in: &cancellables)
    }

    private func prepareTabBarController(with controllers: [UIViewController]) {
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.selectedIndex = TabSections.section1.order
        tabBarController.tabBar.backgroundColor = .lightGray
        tabBarController.tabBar.tintColor = .white
        navigationController.viewControllers = [tabBarController]
        childControllers.append(tabBarController)
    }

    private func getTabController(for section: TabSections) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)
        navController.tabBarItem = UITabBarItem(title: section.title,
                                                        image: section.icon,
                                                        selectedImage: section.selectedIcon)
        navController.tabBarItem.tag = section.order
        startCoordinator(for: section, with: navController)
        return navController
    }
    
    private func startCoordinator(for section: TabSections, with navController: UINavigationController) {
        let coordinator: CoordinatorProtocol
        switch section {
        case .section1:
            let journey1Coordinator = Journey1Coordinator(navController)
            journey1Coordinator.delegate = self
            coordinator = journey1Coordinator
        case .section2:
            coordinator = Journey2Coordinator(navController)
        case .section3:
            coordinator = Journey3Coordinator(navController)
        }
        coordinator.parentCoordinator = self
        coordinator.finishDelegate = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension TabCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
}

extension TabCoordinator: Journey1CoordinatorDelegate {
    func navigateToJourney4() {
        let coordinator = Journey4Coordinator(navigationController)
        coordinator.parentCoordinator = self
        coordinator.finishDelegate = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
