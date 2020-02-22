//
//  MainModel.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mainModel = try? newJSONDecoder().decode(MainModel.self, from: jsonData)

import Foundation
import UIKit
import Kingfisher
// MARK: - MainModel
struct MainModel: Codable {
    let status: Int?
    let message: String?
    let data: [MainData]?
}

// MARK: - Datum
struct MainData: Codable {
    let naming: String?
    let pic: String?
    let datumPrefix: String?
    let services: [Service]?

    enum CodingKeys: String, CodingKey {
        case naming, pic
        case datumPrefix = "prefix"
        case services
    }
  
   func GetPicture(completion:@escaping(_ imageFteched:UIImage?)->()){
    if let imageURLString = pic ,let pref = datumPrefix {
        guard let imageURL = URL(string: imageURLString + pref + ".png") else {
            completion(nil)
          return
        }
      Utils().fetchImage(imageUrl: imageURL) {(result) in
        guard let IMG = result else {completion(nil); return}
        completion(IMG)
      }
    }
  }
}

// MARK: - Service
struct Service: Codable {
    let name: String?
    let pic: String?
    let id, servicePrefix, vehicleType, terms: String?
    let termsKey: String?

    enum CodingKeys: String, CodingKey {
        case name, pic, id
        case servicePrefix = "prefix"
        case vehicleType, terms, termsKey
    }
  
  func GetPicture(completion:@escaping(_ imageFteched:UIImage?)->()){
    if let imageURLString = pic ,let pref = servicePrefix {
        guard let imageURL = URL(string: imageURLString + pref + ".png") else {
            completion(nil)
          return
        }
      Utils().fetchImage(imageUrl: imageURL) {(result) in
        guard let IMG = result else {completion(nil); return}
        completion(IMG)
      }
    }
  }
}

