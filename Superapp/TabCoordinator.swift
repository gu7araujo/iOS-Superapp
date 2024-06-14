//
//  TabCoordinator.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import Foundation
import UIKit

protocol TabCoordinatorProtocol: CoordinatorProtocol {
    var tabBarController: UITabBarController { get set }
    var badgeValue: Int { get set }

    func selectSection(_ section: TabSections)
    func setSelectedIndex(_ index: Int)
    func currentSection() -> TabSections?
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {

    var tabBarController: UITabBarController
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType = .tab

    var badgeValue = 0

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
    }

    private func prepareTabBarController(with controllers: [UIViewController]) {
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.selectedIndex = TabSections.section1.order
        tabBarController.tabBar.backgroundColor = .lightGray
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.items?[0].badgeValue = "\(badgeValue)"
        navigationController.viewControllers = [tabBarController]
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
            coordinator = Journey1Coordinator(navController)
        case .section2:
            coordinator = Journey2Coordinator(navController)
        case .section3:
            coordinator = Journey3Coordinator(navController)
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func selectSection(_ section: TabSections) {
        tabBarController.selectedIndex = section.order
    }

    func setSelectedIndex(_ index: Int) {
        guard let section = TabSections.init(index: index) else { return }
        selectSection(section)
    }

    func currentSection() -> TabSections? {
        TabSections(index: tabBarController.selectedIndex)
    }
}
