//
//  NewsService.swift
//  NewsAppSwiftUI
//
//  Created by Consultant on 7/14/22.
//

import Foundation
import Combine

protocol NewsService{
    func request(from urlRequest:URLRequest) -> AnyPublisher<[Article], APIError>
}

struct NewsServiceImp: NewsService{
    func request(from urlRequest: URLRequest) -> AnyPublisher<[Article], APIError> {
        return
            URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.unknown }
            .flatMap{ data, response -> AnyPublisher<[Article], APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if(200...299).contains(response.statusCode){
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    return Just(data)
                        .decode(type: [Article].self, decoder: jsonDecoder)
                        .mapError{_ in APIError.decodingError }
                        .eraseToAnyPublisher()
                            
                }else{
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }.eraseToAnyPublisher()
    }
    
    
}


