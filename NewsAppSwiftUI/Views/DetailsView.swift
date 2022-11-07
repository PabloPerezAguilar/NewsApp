//
//  DetailsView.swift
//  NewsAppSwiftUI
//
//  Created by Consultant on 7/25/22.
//

import SwiftUI
import URLImage

struct DetailsView: View {
    
    let article: Article

    var body: some View {
        VStack {
            Text(article.title ?? "No title")
                .font(.system(size: 24, weight: .bold))
            Text(article.publishedAt ?? Date(), style: .date)
            if let image = article.imageUrl, let url = URL(string: image){
                URLImage(url, identifier: String(article.id),
                    failure: { error, retry in
                        PlaceHolderImageView()
                }, content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                })
                .frame(
                    maxWidth: 300,
                    maxHeight: 300,
                    alignment: .center
                )
                .cornerRadius(10)
            }else{
                PlaceHolderImageView()
            }
            
            Spacer()
            
            Text(article.summary ?? "No info")
                .font(.system(size: 20))
                .padding()
            
            Spacer()
            
//            Button{
//
//            } label: {
//                Text("Go to full info")
//            }
            Link("Go to full info", destination: URL(string: article.url!)!)
            Spacer()
            
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(article: Article.dummyData)
    }
}
