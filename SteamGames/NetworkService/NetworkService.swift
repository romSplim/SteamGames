//
//  NetworkService.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

final class NetworkService {
    
    //MARK: - Properties
    private var session: URLSession
    private var decoder: JSONDecoder
    
    //MARK: - Init
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        
        self.session = session
        self.decoder = decoder
    }
    
    //MARK: - Methods
    func getAppNews(with resource: APIResource,
                    completion: @escaping (Result<Appnews, NetworkError>) -> Void) {
        
        guard let url = resource.url else {
            completion(.failure(.invalidURL))
            return
        }
        session.dataTask(with: url) { data, response, error in
            if let data {
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
    
    func getAppByCategoryTest(with request: APIResource,
                          completion: @escaping (Result<Response, NetworkError>) -> Void) {
        
        guard let url = request.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let data {
                do {
                    let result = try self.decoder.decode(AppsByCategory.self,
                                                         from: data)
                    let apps = result.response
                    completion(.success(apps))
                } catch let error {
                    print(error)
                    completion(.failure(.cannotDecode))
                }
            }
        }.resume()
    }
    
}
