//
//  ParserHelper.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 03/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

public final class ParserHelper {
  /// Parse result to a Object
  ///
  /// - Parameters:
  ///   - data: Data
  ///   - completion: Result<[T], ParserErrorResult>
  public static func parseObject<T: Decodable>(of type: T.Type, data: Any, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Result<T, NetworkError> {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = keyDecodingStrategy
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
      let object = try decoder.decode(T.self, from: jsonData)
      return .success(object)
    } catch {
      print("Error info: \(error)")
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

