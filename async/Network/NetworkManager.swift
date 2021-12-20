//
//  NetworkManager.swift
//  async
//
//  Created by 최형우 on 2021/12/20.
//

import Foundation
import Moya
import Alamofire

protocol NetworkManagerType: class{
    func sessionTest() async throws -> [Todo]
    func alamofireTest() async throws -> [Todo]
    func moyaTest() async throws -> [Todo]
    
}

final class NetworkManager: NetworkManagerType{
    static let shared = NetworkManager()
    
    private let provider = MoyaProvider<JsonAPI>()
    
    func sessionTest() async throws -> [Todo] {
        let (data, res) = try await URLSession.shared.data(from: URL(string: "https://jsonplaceholder.typicode.com/todos")!)
        guard let res = res as? HTTPURLResponse,
              res.statusCode == 200 else{
                  throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 200))
              }
        let json = try? JSONDecoder().decode([Todo].self, from: data)
        
        return json ?? []
    }
    
    func alamofireTest() async throws -> [Todo] {
        let req = await withCheckedContinuation({ config in
            AF.request(
                URL(string: "https://jsonplaceholder.typicode.com/todos")!,
                method: .get,
                encoding: URLEncoding.default
            ).responseJSON { req in
                config.resume(returning: req)
            }
        })
        if req.response?.statusCode != 200 {
            throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: req.response?.statusCode ?? 0))
        }
        
        let json = try? JSONDecoder().decode([Todo].self, from: req.data ?? .init())
        
        return json ?? []
    }
    
    func moyaTest() async throws -> [Todo] {
        let req = await withCheckedContinuation({ config in
            provider.request(.getTodos) { result in
                config.resume(returning: result)
            }
            
        })
        switch req{
        case let .success(res):
            let json = try? JSONDecoder().decode([Todo].self, from: res.data)
            return json ?? []
        case let .failure(err):
            throw err.asAFError!
        }
    }
    
    
}
