//
//  NetworkManager.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import Foundation
import Alamofire



public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()
enum Result<T> {
    case success(T)
    case failure(String)
}

struct  NetworkManager {
  
static func send<T:Codable>(_ type: T.Type, _ request:  URLRequestConvertible,completion:@escaping(Bool , String? , T?) -> Void){
  AF.request(request).responseJSON { (response) in
    if let _ = response.error {
      completion(false ,response.error?.localizedDescription , nil )
    } else {
      let result = self.handleNetworkResponse(response.response!)
      switch result {
        case .success:
          ResponseManagment.ManageSuccess(type, response: response) { (Done, error, Data) in
          completion(Done, error, Data)
        }
      case .failure(let networkFailureError):
        ResponseManagment.ManageFailure(type , Err:networkFailureError, response: response) { (Done, error, Data) in
          completion(Done, error, Data)
        }
      }
    }
  }
}
  
  

    
    
    
  
  

  
  
  
  static func monitorReachability() {
      NetworkReachabilityManager.default?.startListening { status in
        print("Reachability Status Changed: \(status)")
        print(NetworkReachabilityManager.default?.isReachable as Any)
      }
    
    
  }
  
  
   static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
      switch response.statusCode {
      case 200...299: return .success(NetworkResponse.success.rawValue)
      case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
      case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
      case 600: return .failure(NetworkResponse.outdated.rawValue)
      default: return .failure(NetworkResponse.failed.rawValue)
      }
  }

}




