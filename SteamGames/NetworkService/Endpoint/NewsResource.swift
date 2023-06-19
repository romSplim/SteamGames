//
//  NewsResource.swift
//  SteamGames
//
//  Created by ramil on 19.06.2023.
//

import UIKit

struct NewsResource: APIResource {
    
    //MARK: - Properties
    var appID: Int
    var path: String = "/ISteamNews/GetNewsForApp/v2/"
    
    var queryItems: [String : String]? {
        return ["appid": "\(appID)"]
    }
    
    //MARK: - Init
    init(appID: Int) {
        self.appID = appID
    }
}
