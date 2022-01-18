//
//  ServiceEndPoint.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 18/1/22.
//


import Foundation

protocol ServiceEndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

public enum HTTPMethod : String {
    case get = "GET"
}

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}



