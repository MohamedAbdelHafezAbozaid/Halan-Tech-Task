//
//  MainRouter.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import Foundation
import Alamofire

enum MainRouter : URLRequestConvertible {
  
  case servicesData(latitude:Double , longitude:Double , returnCached:Bool = false)
  
  private var method: HTTPMethod {
      switch self {
      case .servicesData:
        return .get
      }
    }
  
  private var path: String {
  switch self {
  case .servicesData:
    return "user/services"
    }
  }
  
  private var parameters: [String: Any]? {
     switch self {
     case .servicesData:
      return nil
    }
  }
  
  private var Headers :[String:String]? {
    switch self {
      case .servicesData(let lat , let long ,_):
        return ["lat":String(lat) , "long":String(long)]
    }
  }
  
  
  
  private func checkCaching()->Bool{
    switch self {
      case .servicesData(_ , _ ,let caching):
        return caching
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = NetworkConstants().baseURL
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    // HTTP Method
    urlRequest.httpMethod = method.rawValue
    urlRequest.timeoutInterval = 10
    if checkCaching() {
    urlRequest.cachePolicy = .returnCacheDataElseLoad
    } else {
    urlRequest.cachePolicy = .reloadIgnoringCacheData
    }
    
    if let headers = Headers {
    for (key, value) in headers {
        urlRequest.setValue(value, forHTTPHeaderField: key)
       }
     }
    urlRequest.setValue(ContentType.ststicAuthorizationToken.rawValue, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
    urlRequest.setValue(ContentType.staticDeciveToken.rawValue, forHTTPHeaderField: HTTPHeaderField.device.rawValue)
    urlRequest.setValue(ContentType.versionType.rawValue, forHTTPHeaderField: HTTPHeaderField.version.rawValue)
    urlRequest.setValue(ContentType.English.rawValue, forHTTPHeaderField: HTTPHeaderField.Language.rawValue)
    
    // Parameters
    if let parameters = parameters {
      do {
        if urlRequest.httpMethod == "GET"{
          urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }else if  urlRequest.httpMethod == "POST" || (urlRequest.httpMethod == "PUT") || (urlRequest.httpMethod == "DELETE") {
          urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
      } catch {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
      }
    }
    return urlRequest
  }
  
}
