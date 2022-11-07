//
//  NewsEndpoint.swift
//  NewsAppSwiftUI
//
//  Created by Consultant on 7/14/22.
//

import Foundation

protocol APIBuilder{
    var urlRequest: URLRequest { get }
    var baseURL: String { get }
    var path: String { get set }
    var url: URL { get }
}

//enum NewsAPI {
//    case getNews
//    case getNewsCount
//}

struct NewsAPI: APIBuilder{
    var path: String
    
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
    
    var baseURL: String  {
        return "https://api.spaceflightnewsapi.net/v3"
    }
    
    var url: URL {
        return URL(string: "\(baseURL)/\(path)" )!
    }
    
    
    
    
    
    
}
