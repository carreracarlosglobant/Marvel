//
//  RequestProtocol.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 03/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

/// Defines methods for RequestProtocol compatibility.
/// Concrete Request Services can implement it to add `RequestProtocol` compatiblity.
protocol RequestProtocol {
  /// An baseURL String
  var baseURL: URL { get }
  /// Path of specific service to request
  var path: String { get }
  /// `headers` required to make the `URLRequest` of an specific Service or API.
  var headers: Headers { get }
  /// `HTTP Method GET-POST-DELETE` required to make the `URLRequest` of an specific Service or API.
  var method: HTTPMethod { get }
  /// `TimeInterval` for obtaining request data.
  var timeoutInterval: TimeInterval { get }
  /// `Parameters` required to make the `URLRequest` of an specific Service or API.
  var parameters: [String: Any] { get }
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case delete = "DELETE"
}
