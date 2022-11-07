//
//  NewsViewModel.swift
//  NewsAppSwiftUI
//
//  Created by Consultant on 7/14/22.
//

import Foundation
import Combine
import SwiftUI

protocol NewsViewModel{
    func getArticles()
}

class NewsViewModelImp: ObservableObject, NewsViewModel{
    private let service: NewsService
    private(set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    private var limit: Int = 10
    private var start: Int = 0
    
    @Published private(set) var state: ResultState = .success(content: [])
    @Published private(set) var loading: Bool = false
    
    init(service: NewsService){
        self.service = service
    }
    
    func loadMore(){
        limit += 10
        start += 10
        getArticles()
    }
    
    func getArticles() {
        self.loading = true
        let api = NewsAPI(path: "articles?_limit=\(limit)&_start=\(start)")
        let cancellable = service.request(from: api.urlRequest).sink{ result in
            self.loading = false
            switch result{
            case .finished:
                self.state = .success(content: self.articles)
            case .failure(let error):
                self.state = .error(error: error)
            }
        } receiveValue: { response in
            self.articles.append(contentsOf: response)
        }
        self.cancellables.insert(cancellable)
    }
    
    
}

