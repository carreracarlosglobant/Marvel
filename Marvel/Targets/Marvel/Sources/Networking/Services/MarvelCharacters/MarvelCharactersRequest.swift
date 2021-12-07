//
//  MarvelCharactersRequest.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 03/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

enum MarvelCharactersRequest: RequestProtocol {
  case marvelCharacters
  case marvelCharacterDetail(id: String)

  var baseURL: URL {
    return URL(string: "https://gateway.marvel.com")!
  }

  var path: String {
    switch self {
    case .marvelCharacters:
      return "/v1/public/characters?ts=\(ServicesConstants.ts)&apikey=\(ServicesConstants.apikey)&hash=\(ServicesConstants.hash)"
    case .marvelCharacterDetail(let id):
      return "/v1/public/characters/\(id)?ts=\(ServicesConstants.ts)&apikey=\(ServicesConstants.apikey)&hash=\(ServicesConstants.hash)"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .marvelCharacters, .marvelCharacterDetail:
      return .get
    }
  }

  var timeoutInterval: TimeInterval {
    return 30.0
  }

  var headers: Headers {
    var headers = Headers()
    headers[.contentType] = "application/json"
    return headers
  }

  var parameters: [String: Any] {
    switch self {
    case .marvelCharacters, .marvelCharacterDetail:
      return [:]
    }
  }

}
