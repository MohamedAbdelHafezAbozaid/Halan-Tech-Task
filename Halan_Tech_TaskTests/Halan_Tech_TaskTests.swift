//
//  Halan_Tech_TaskTests.swift
//  Halan_Tech_TaskTests
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import XCTest
import Alamofire
@testable import Halan_Tech_Task

class Halan_Tech_TaskTests: XCTestCase {

  var resData: Data? = nil
  var err :String? = nil
  
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTagsApi() {
        let request = MainRouter.servicesData(latitude: 30.063173, longitude: 31.216457)
      AF.request(request).responseJSON { (response) in
        if let Err = response.error {
          self.err = Err.localizedDescription
        } else {
          let result = NetworkManager.handleNetworkResponse(response.response!)
          switch result {
            case .success:
              self.resData = response.data
          case .failure(let Erro):
             self.err = Erro
            }
          }
        }
        
      let pred = NSPredicate(format: "resData != nil")
      let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
      let res = XCTWaiter.wait(for: [exp], timeout: 10.0)
      
        if res == XCTWaiter.Result.completed {
          XCTAssertNotNil(resData, "No data recived from the server for InfoView content")
        } else {
          XCTAssert(false, "The call to get the URL ran into some other error")
        }
      
      let predError = NSPredicate(format: "err == nil")
      let expError = expectation(for: predError, evaluatedWith: self, handler: nil)
      let resError = XCTWaiter.wait(for: [expError], timeout: 10.0)
      
      if resError == XCTWaiter.Result.completed {
          XCTAssertNotNil(resError, "No data recived from the server for InfoView content")
      } else {
          XCTAssert(false, "The call to get the URL ran into some other error")
      }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
