//
//  HomeView.swift
//  NewsAppSwiftUI
//
//  Created by Consultant on 7/14/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = NewsViewModelImp(service: NewsServiceImp())
    
    var body: some View {
        Group{
            switch viewModel.state{
            case .error(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView{
                    List {
                        ForEach(articles){ item in
                            NavigationLink(destination: DetailsView(article: item)){
                                ArticleView(article: item).onAppear{
                                    if item == articles.last {
                                        viewModel.loadMore()
                                    }
                                }
                            }
                        }
                        if viewModel.loading {
                            ProgressView()
                                .frame(
                                    idealWidth: .infinity,
                                    maxWidth: .infinity,
                                    alignment: .center
                                )
                        }
                    }.navigationTitle(Text("News"))
                }.navigationViewStyle(.stack)
            }
        }.onAppear(perform: viewModel.getArticles)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
