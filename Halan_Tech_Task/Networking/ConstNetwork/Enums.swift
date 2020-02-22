//
//  Enums.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import Foundation

enum HTTPHeaderField: String {
  case authentication = "Authorization"
  case version = "version"
  case Language = "language"
  case longitude = "long"
  case latitude = "lat"
  case device = "device"
}

enum ContentType: String {
  case json = "application/json"
  case versionType = "ios"
  case English = "en"
  case ststicAuthorizationToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZTQxNTAxNDcyNDhkODAwMTIzYWQ2OTIiLCJ1c2VyUmVxdWVzdENvbnRyb2xsIjpudWxsLCJ0eXBlIjoiVXNlciIsImlzSDM2MCI6ZmFsc2UsImlhdCI6MTU4MjE5NzgyNSwiZXhwIjoxNjEzNzU1NDI1fQ.tjG_zLonYtcKAkZdLR1jU5EkowddfB8wuIOWOiPT0yo"
  case staticDeciveToken = "Mobile;Iphone;Simulator iPhone_11_Pro;N/A;IOS;13.3;4DF14DCA-5357-4EFB-808B-A6FD56D3DB20;en;7200;1581290302;3.0.16;00000000-0000-0000-0000-000000000000"
}
