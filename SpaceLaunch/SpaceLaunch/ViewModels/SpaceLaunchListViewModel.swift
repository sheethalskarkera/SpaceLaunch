//
//  SpaceLaunchListViewModel.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 18/1/22.
//

import Foundation

protocol SpaceLaunchListViewModelDelegate: AnyObject {
    func shouldReloadView()
    func showErrorMessage(message: String?)
}

class SpaceLaunchListViewModel {
    
    var astronautService: AstronautService
    
    init(astronautService: AstronautService) {
        self.astronautService = astronautService
    }
    
    weak var delegate: SpaceLaunchListViewModelDelegate?
    
    var astronauts: [Astronaut]?
    
    var title: String {
        "Space Launch Astronauts"
    }
    var numberOfRows: Int {
        astronauts?.count ?? 0
    }
    
    func fetchSpaceLaunchCellViewModel(index: Int) -> SpaceLaunchCellViewModel {
        let cellModel = astronauts?[index]
        return SpaceLaunchCellViewModel(name: cellModel?.name ?? "",
                                        nationality: cellModel?.nationality ?? "",
                                        imageURLString: cellModel?.profileImageThumbnail ?? "")
    }

    func getAstronautList() {
        astronautService.getAstronautList { [weak self] responselist, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let responselist = responselist {
                    self.astronauts = responselist
                    self.sortAstronauts(type: .ascending)
                } else {
                    self.delegate?.showErrorMessage(message: error?.localizedDescription)
                }
            }
        }
    }
    
    func sortAstronauts(type: SortType)  {
        astronauts?.sort {
            switch type {
            case .ascending:
                return $0.name?.localizedStandardCompare($1.name ?? "") == .orderedAscending
            case .descending:
                return $0.name?.localizedStandardCompare($1.name ?? "") == .orderedDescending
            }
        }
        delegate?.shouldReloadView()
    }
}

enum SortType: String {
    case ascending = "AZ"
    case descending = "ZA"
}
