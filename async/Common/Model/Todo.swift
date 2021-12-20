//
//  Todo.swift
//  async
//
//  Created by 최형우 on 2021/12/20.
//

import Foundation

struct Todo: Codable{
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
