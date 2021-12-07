//
//  Networking.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 03/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

typealias APIResult<T> = (Result<T,NetworkError>) -> Void

class Networking {
  // MARK: - Inits
  init() { }

  // MARK: - Handlers
  func fetchMarvelCharacters(service: RequestProtocol, completion: @escaping MarvelCharactersModelResponse) {
    let request = makeRequest(service: service)
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
      // Validation of task error
      if let sesionError = error {
        completion(.failure(NetworkError.errorForParseFailed(error: sesionError.localizedDescription)))
        return
      }
      guard let responseData = data, let json = try? JSONSerialization.jsonObject(with: responseData, options: []) else {
        completion(.failure(NetworkError.errorForWrongStructure()))
        return
      }
      completion(ParserHelper.parseObject(of: MarvelCharactersResponse?.self, data: json))
    }.resume()
  }

  func makeRequest(service: RequestProtocol) -> URLRequest {

    guard let urlStr = service.baseURL.appendingPathComponent(service.path).absoluteString.removingPercentEncoding,
          let url = URL(string: urlStr) else { return URLRequest(url: service.baseURL) }
    var request = URLRequest(url: url,
                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: service.timeoutInterval)
    request.httpMethod = service.method.rawValue
    for header in service.headers.collection {
      request.setValue(header.value, forHTTPHeaderField: header.key.rawValue)
    }
    switch service.method {
    case .delete, .post:
      guard let httpBody = try? JSONSerialization.data(withJSONObject: service.parameters, options: []) else {
        return request
      }
      request.httpBody = httpBody
    case .get:
      return request
    }
    return request
  }
}
