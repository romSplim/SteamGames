//
//  NetworkService.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

final class NetworkService {
    
    private var session: URLSession
    private var decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        
        self.session = session
        self.decoder = decoder
    }
    
    func getAllApps(completion: @escaping (Result<[App], NetworkError>) -> Void) {
        guard let url = APIManager.getAllApps.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let data {
                do {
                    let result = try self.decoder.decode(AppsResponse.self,
                                                         from: data)
                    let apps = result.appList.apps
                    completion(.success(apps))
                } catch {
                    completion(.failure(.cannotDecode))
                }
            }
        }.resume()
    }
    
    func getAppNews(with appID: Int, completion: @escaping (Result<Appnews, NetworkError>) -> Void) {
        guard let url = APIManager.getNewsForApp(appID: appID).url else {
            completion(.failure(.invalidURL))
            return
        }
        print(url)
        session.dataTask(with: url) { data, response, error in
            if let data {
                print("DATA EXIST")
                do {
                    let result = try self.decoder.decode(NewsResponse.self,
                                                         from: data)
                    let apps = result.appnews
                    completion(.success(apps))
                } catch let error {
                    print(error)
                    completion(.failure(.cannotDecode))
                }
            }
        }.resume()
    }
    
    
    
//    func getAllAppsAsync() async throws -> AppsResponse {
//        guard let url = URL(string: "https://api.steampowered.com/ISteamApps/GetAppList/v2/") else {
//            throw NetworkError.invalidURL
//        }
//
//        let (data, response) = try await session.data(from: url)
//
//        if let response = response as? HTTPURLResponse {
//            print(response.statusCode)
//        }
//
//        let result = try decoder.decode(AppsResponse.self, from: data)
//
//        return result
//    }
}
