//
//  BaseViewController.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/22/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import UIKit
import CoreLocation

class BaseViewController: UIViewController {

  let locationManager = CLLocationManager()
  var userLocation = CLLocationCoordinate2D()
  let utils = Utils()
  var fromCach = true
  
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotification), name: Notification.Name("enterForeGround"), object: nil)
         fromCach = true
         checkPermission()
        }
        deinit {
          NotificationCenter.default.removeObserver(self)
        }

    //MARK:- Handle Return to ForGround
    @objc func handleNotification(_ refreshControl: UIRefreshControl) {
        checkPermission(formNotificationCenter:true)
    }
   
  func fetchDataFromAPI(FromCach:Bool = false){
    
  }
  
  //MARK:- Get Location & CHECK Permission
  func getUserLocation() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
   }
  
  @objc func checkPermission(formNotificationCenter:Bool = false){
  utils.onSuccess = {[weak self] in
    guard let self = self else {return}
    switch self.utils.Status {
    case .Accept:
      self.getUserLocation()
      if !formNotificationCenter{ self.fetchDataFromAPI(FromCach:self.fromCach) }
      break
    case .deniad:
      self.utils.alertBlocker(Controller: self)
      break
    case .notDetermined:
      self.getUserLocation()
//      self.utils.alertBlocker(Controller: self)
      break
    case .none:
      break
    }
  }
  utils.CheckPermission()
   }
  
  //MARK:- Shake Events
  override func becomeFirstResponder() -> Bool {
      return true
  }
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
      fromCach = false
      self.checkPermission()
    }
  }
}

//MARK:- Location Manager Delegates
extension BaseViewController : CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways || status == .authorizedWhenInUse {
      fromCach = false
      checkPermission()
    } else {
      utils.alertBlocker(Controller: self)
    }
  }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = (locations.last?.coordinate)!
    }
  }
