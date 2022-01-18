//
//  SpaceLaunchDetailViewModel.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 18/1/22.
//

import Foundation

protocol SpaceLaunchDetailViewModelDelegate: AnyObject {
    func shouldReloadView()
    func showErrorMessage(message: String?)
}

class SpaceLaunchDetailViewModel {
    
    weak var delegate: SpaceLaunchDetailViewModelDelegate?
    
    var astronaut: Astronaut?
    var id: Int
    var astronautService: AstronautService
    
    init(astronautService: AstronautService, id: Int) {
        self.astronautService = astronautService
        self.id = id
    }
    
    var nameText: String {
        "Name: \(astronaut?.name ?? "")"
    }
    
    var nationality: String {
        "Nationality: \(astronaut?.nationality ?? "")"
    }
    
    var dateOfBirth : String {
        guard let dob = astronaut?.dateOfBirth else { return "" }
        let dateString = DateFormatter.currentLocaleFormatter.string(from: dob)
        return"DOB: \(dateString)"
    }
    
    var firstFlight: String {
        guard let firstFlight = astronaut?.firstFlight else { return "" }
        let dateString = DateFormatter.currentLocaleFormatter.string(from: firstFlight)
        return"First Flight: \(dateString)"
    }
    
    func getAstronautDetails() {
        astronautService.getAstronautDetails(for: id) { [weak self] details, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let details = details {
                    self.astronaut = details
                    self.delegate?.shouldReloadView()
                } else {
                    self.delegate?.showErrorMessage(message: error?.localizedDescription)
                }
            }
        }
    }
}
