//
//  Headers.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 03/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

struct Headers: Subscriptable {

  var collection: [HeaderName: String] = [:]

  init() {}

  subscript(index: HeaderName) -> String {
    get { return collection[index] ?? "" }
    set { collection[index] = newValue }
  }
}

enum HeaderName: String, Hashable {
  case contentType = "Content-Type"
  case authorization = "Authorization"
}
