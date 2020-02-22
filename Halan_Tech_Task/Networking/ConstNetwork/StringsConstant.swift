//
//  StringsConstant.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import Foundation


class NetworkConstants {
  private let BaseURL = "https://api-staging.halan.io/api/v1/"
  var baseURL: URL {
        guard let url = URL(string: BaseURL) else { fatalError("baseURL could not be configured.")}
           return url
      }
}
