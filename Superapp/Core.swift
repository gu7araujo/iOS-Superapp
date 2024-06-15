//
//  Core.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import Foundation
import Combine

final class Core {
    
    static var shared = Core()
    @Published var badgeValue: Int = 0
    
    private init() { }
}
