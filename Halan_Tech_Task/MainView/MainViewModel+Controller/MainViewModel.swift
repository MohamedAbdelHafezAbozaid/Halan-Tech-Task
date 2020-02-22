//
//  MainViewModel.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MainViewModel {
  
  var onError:(()->Void)?
  var onSuccess:(()->Void)?
  var homeData = [MainData](){didSet{onSuccess?()}}
  var result:LocationAllow  = .deniad
  
  
  func RefreshView(UserLat:Double , UserLong:Double, returnCash:Bool = false){
    homeData = []
    FetchData(UserLat:UserLat , UserLong:UserLong , returnCash:returnCash)
  }
  
  //MARK:- Fetching Categories
  
  func FetchData(UserLat:Double , UserLong:Double , returnCash:Bool = false){
    let request = MainRouter.servicesData(latitude: UserLat, longitude: UserLong ,returnCached:returnCash)
    NetworkManager.send( MainModel.self, request) { [weak self](Done, Err, Data) in
      guard let self = self else {return}
      if Done{
      guard Err == nil else {self.onError?(); return}
        if returnCash  && Data == nil {
          self.FetchData(UserLat:UserLat , UserLong:UserLong)
        }else{
         self.homeData.append(contentsOf: (Data?.data)!)
        }
      }
    }
  }
  
}
