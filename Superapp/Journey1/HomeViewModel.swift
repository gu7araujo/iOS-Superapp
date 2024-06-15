//
//  HomeViewModel.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func navigateToJourney4()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    func navigateToJourney4() {
        delegate?.navigateToJourney4()
    }
}
