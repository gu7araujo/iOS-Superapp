//
//  TabSections.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import Foundation
import UIKit

enum TabSections: Int, CaseIterable {
    case section1 = 0
    case section2
    case section3

    init?(index: Int) {
        self.init(rawValue: index)
    }

    var title: String {
        switch self {
        case .section1:
            return "Section 1"
        case .section2:
            return "Section 2"
        case .section3:
            return "Section 3"
        }
    }

    var order: Int {
        return self.rawValue
    }

    var icon: UIImage? {
        switch self {
        case .section1:
            return UIImage(systemName: "heart")
        case .section2:
            return UIImage(systemName: "book")
        case .section3:
            return UIImage(systemName: "trash")
        }
    }

    var selectedIcon: UIImage? {
        switch self {
        case .section1:
            return UIImage(systemName: "heart.fill")
        case .section2:
            return UIImage(systemName: "book.fill")
        case .section3:
            return UIImage(systemName: "trash.fill")
        }
    }
}
