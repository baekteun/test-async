//
//  JsonAPI.swift
//  async
//
//  Created by 최형우 on 2021/12/20.
//

import Moya

enum JsonAPI{
    case getTodos
}

extension JsonAPI: TargetType{
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self{
        case .getTodos:
            return "/todos"
        }
    }
    
    var method: Method {
        switch self{
        case .getTodos:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .getTodos:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
