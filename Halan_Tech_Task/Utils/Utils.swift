//
//  File.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Kingfisher

//MARK:- location Permission status
enum LocationAllow:String{
  case Accept
  case deniad
  case notDetermined
}

class Utils {
  
 
  
  var onSuccess:(()->Void)?
  var Status :LocationAllow!{didSet{onSuccess?()}}
//MARK:- Check User is Allow Location
  func CheckPermission() {
  if CLLocationManager.locationServicesEnabled(){
  let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
  if status == CLAuthorizationStatus.notDetermined {
    Status = .notDetermined
  } else if status == CLAuthorizationStatus.denied {
    Status = .deniad
  } else  if status == CLAuthorizationStatus.authorizedAlways ||  status == CLAuthorizationStatus.authorizedWhenInUse {
    Status = .Accept
  }else{
    Status = .deniad
    }
  } else {
    Status = .notDetermined
      }
   }
  
  //MARK:- Blocking Alert
  func alertBlocker(Controller:UIViewController){
    let Alert = UIAlertController(title: "Sorry you Need To Allow you Location", message: "", preferredStyle: .alert)
    let oKAction = UIAlertAction(title: "ok", style: .default) { _ in
      let path = UIApplication.openSettingsURLString
      if let settingsURL = URL(string: path), UIApplication.shared.canOpenURL(settingsURL) {
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
      }
    }
    Alert.addAction(oKAction)
    Controller.present(Alert, animated: true)
  }
  
  //MARK:- Terms Alert Nav
  func TermsAlert(Cont:UIViewController , Terms:String , completion:@escaping(_ Done:Bool)->()){
    let vc = AlertVC(onViewController: Cont ,terms:Terms )
    vc.onAccept = {
      vc.dismiss { (Done) in
        completion(true)
      }
    }
    vc.onDecline = {
      vc.dismiss { (Done) in
        completion(false)
      }
    }
    vc.show()
  }
  
  //MARK:- Image Fetcher
  func fetchImage(imageUrl:URL , completion:@escaping(_ imageFteched:UIImage?)->()){
    if ImageCache.default.isCached(forKey: imageUrl.absoluteString) {
          ImageCache.default.retrieveImage(forKey: imageUrl.absoluteString, completionHandler: { (result) in
           switch result {
             case .success(let value):
               completion(value.image)
             case .failure(_):
              completion(nil)
             }
           })
    }else {
          KingfisherManager.shared.retrieveImage(with: imageUrl) { (result) in
              switch result {
              case .success(let value):
                  ImageCache.default.store(value.image, forKey: imageUrl.absoluteString)
                  completion(value.image)
              case .failure(_):
                  completion(nil)
              }
            }
          }
       }
  
}
