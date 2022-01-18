//
//  ServiceAPI.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 19/1/22.
//

import Foundation

public enum ServiceAPI {
    case astronautList
    case astronautDetail(id: Int)
}

extension ServiceAPI: ServiceEndPoint {
    var baseURL: URL {
        URL(string: "http://spacelaunchnow.me/api/3.5.0/astronaut")!
    }
    
    var path: String {
        if case .astronautDetail(let astronautId) = self {
            return "/\(astronautId)"
        } else {
            return ""
        }
        
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        .requestParameters(bodyParameters: nil,
                           bodyEncoding: .urlEncoding,
                           urlParameters: nil)
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
