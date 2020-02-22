//
//  ResponseMangment.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import Foundation
import Alamofire


enum NetworkResponse:String {
    case success = "Success"
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}


class ResponseManagment {
  
 static func ManageSuccess<T:Codable>(_ type: T.Type ,response:AFDataResponse<Any>,completion:@escaping(Bool , String? , T?) -> Void) {
    guard let responseData = response.data else {
              completion(true, NetworkResponse.noData.rawValue,nil)
              return
            }
          do {
            try Serilaization.Serizalization(Type: T.self, data: responseData, completion: { (Done, error, obj) in
              completion(Done,error,obj)
            })
          }catch let error {
            completion(false , error.localizedDescription , nil)
          }
       }
  
  
  
   static func ManageFailure<T:Codable>(_ type: T.Type ,Err:String,response:AFDataResponse<Any>,completion:@escaping(Bool , String? , T?) -> Void) {
    guard let responseData = response.data else {
                      completion(true, Err,nil)
                      return
                  }
            do {
              try Serilaization.Serizalization(Type: T.self, data: responseData, completion: { (Done, error, obj) in
                completion(Done,error,obj)
              })
            }catch let error {
              completion(false , error.localizedDescription , nil)
            }
          }
       }

