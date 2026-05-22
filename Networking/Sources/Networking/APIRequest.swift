//
//  File 2.swift
//  Networking
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public struct APIRequest<T: Decodable>{
   public var method: HTTPMethod
   public var path: APIRoute
   public var queryItems: [URLQueryItem] = []
   public var headers: [String: String] = [:]
   public let body: Data?
    public init(
        method: HTTPMethod,
        path: APIRoute,
        queryItems: [URLQueryItem] = [],
        headers: [String : String] = [:],
        body: Data? = nil
    ){
        self.method = method
        self.path = path
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
    }
    init<Body: Encodable>(
        method: HTTPMethod,
        path: APIRoute,
        queryItems: [URLQueryItem] = [],
        headers: [String : String] = [:],
        encoder: JSONEncoder = JSONEncoder(),
        body: Body? = nil
    )throws{
        self.method = method
        self.path = path
        self.headers = headers
        self.body = try encoder.encode(body)
        self.queryItems = queryItems
        if self.headers["Content-Type"] == nil{
            self.headers["Content-Type"] = "application/json"
        }
    }
    
    public func makeURLRequest(baseURL: URL, defaultHeaders: [String:String] = [:], apiKey: String? = nil) throws(NetworkError) -> URLRequest{
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path.path), resolvingAgainstBaseURL: true) else{
            throw NetworkError.badURL
        }
        var allQueryItems = queryItems

        if let apiKey {
                allQueryItems.append(URLQueryItem(name: "api_key", value: apiKey))
            }
        
        if !allQueryItems.isEmpty{
            components.queryItems = allQueryItems
        }
        
        guard let url = components.url else{
            throw NetworkError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        var mergedHeaders = defaultHeaders
        mergedHeaders.merge(headers) { (_, new) in new}
        request.allHTTPHeaderFields = mergedHeaders
        request.httpBody = body
        return request
    }
}

