//
//  Article.swift
//  GoodNews
//
//  Created by Naoki Muroya on 2020/01/19.
//  Copyright © 2020 Naoki Muroya. All rights reserved.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

extension ArticlesList {
    static var all: Resource<ArticlesList> = {
        // your api key
        let url = URL(string: "")!
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    let title: String
    let description: String?
}
