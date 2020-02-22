//
//  Serialization.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import Foundation
class Serilaization {
   static func Serizalization<T:Codable>(Type:T.Type,data:Data,completion:@escaping(Bool , String? , T?)->()) throws {
    let jsonData = try? JSONSerialization.jsonObject(with:data, options: .mutableContainers)
    print(jsonData as Any)
    let obj:T? = try JSONDecoder().decode(Type.self, from: data)
    completion(true,nil,obj)
  }
}

