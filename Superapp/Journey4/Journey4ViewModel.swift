//
//  Journey4ViewModel.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 15/06/24.
//

import Foundation

protocol Journey4ViewModelDelegate: AnyObject {
    func finishJourney()
}

class Journey4ViewModel {
    
    weak var delegate: Journey4ViewModelDelegate?
    
    func finishJourney() {
        delegate?.finishJourney()
    }
}
