//
//  AstronautService.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 17/1/22.
//

import Foundation

protocol AstronautServiceProtocol {
    func getAstronautList(completion: @escaping ([Astronaut]?, Error?) -> Void)
    func getAstronautDetails(for id: Int, completion: @escaping (Astronaut?, Error?) -> Void)
}

class AstronautService: AstronautServiceProtocol {
    let router = Router<ServiceAPI>()
    
    static let `default` = AstronautService()
    
    func getAstronautList(completion: @escaping ([Astronaut]?, Error?) -> Void) {
        router.request(.astronautList) { data, response, error in
            if error != nil {
                
                completion(nil, ServiceError.general(messsage: "Please check your network connection."))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, ServiceError.general(messsage: NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(AstronautsResponse.self, from: responseData)
                        completion(apiResponse.astronauts,nil)
                    }
                    catch {
                        print(error)
                        completion(nil, ServiceError.general(messsage: NetworkResponse.unableToDecode.rawValue))
                    }
                case .failure(let networkFailureError):
                    completion(nil, ServiceError.general(messsage: networkFailureError))
                }
            }
            
        }
    }
    
    func getAstronautDetails(for id: Int, completion: @escaping (Astronaut?, Error?) -> Void) {
        router.request(.astronautDetail(id: id)) { data, response, error in
            if error != nil {
                
                completion(nil, ServiceError.general(messsage: "Please check your network connection."))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, ServiceError.general(messsage: NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(Astronaut.self, from: responseData)
                        completion(apiResponse,nil)
                    } catch {
                        print(error)
                        completion(nil, ServiceError.general(messsage: NetworkResponse.unableToDecode.rawValue))
                    }
                case .failure(let networkFailureError):
                    completion(nil, ServiceError.general(messsage: networkFailureError))
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}


