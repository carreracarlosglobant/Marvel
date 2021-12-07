//
//  TestUtils.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 06/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

class TestUtils {
  fileprivate static func readLocalFile(forName name: String, in bundle: Bundle) -> Data? {
    do {
      if let bundlePath = bundle.path(forResource: name, ofType: "json"),
         let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
        return jsonData
      }
    } catch {
      print(error)
    }
    return nil
  }

  static func loadLocalJson<T: Decodable>(fileName: String, in bundle: Bundle = Bundle(for: TestUtils.self)) -> Result<T, NetworkError> {
    guard let data = readLocalFile(forName: fileName, in: bundle) else {
      return .failure(NetworkError.errorReadingFile())
    }
    guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
      return .failure(NetworkError.errorForWrongStructure())
    }
    return (ParserHelper.parseObject(of: T.self, data: json))
  }
}
