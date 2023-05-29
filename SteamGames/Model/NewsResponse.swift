//
//  NewsResponse.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import Foundation

// MARK: - News
struct NewsResponse: Decodable {
    let appnews: Appnews
}

// MARK: - Appnews
struct Appnews: Decodable {
    let appID: Int
    let newsItems: [NewsItem]
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case appID = "appid"
        case newsItems = "newsitems"
        case count
    }
}

// MARK: - Newsitem
struct NewsItem: Decodable {
    let gid, title: String
    let url: String
    let isExternalURL: Bool
    let author, contents, feedLabel: String
    let date: Int
    let feedName: String
    let feedType: Int
    let appID: Int
    let tags: [String]?

    enum CodingKeys: String, CodingKey {
        case gid, title, url
        case isExternalURL = "is_external_url"
        case author, contents, date
        case feedLabel = "feedlabel"
        case feedType = "feed_type"
        case feedName = "feedname"
        case appID = "appid"
        case tags
    }
}
