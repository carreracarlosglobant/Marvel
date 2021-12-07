//
//  MarvelCharactersServicesManager.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 03/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

typealias MarvelCharactersModelResponse = APIResult<MarvelCharactersResponse?>

struct MarvelCharactersServicesManager {
  // MARK: - Private properties
  private let networking = Networking()

  // MARK: - Inits
  init() { }

  // MARK: - Methods
  func marvelCharacters(completion: @escaping MarvelCharactersModelResponse) {
    let service = MarvelCharactersRequest.marvelCharacters
    networking.fetchMarvelCharacters(service: service) { result in
      completion(result)
    }
  }

  func marvelCharacterDetail(id: String, completion: @escaping MarvelCharactersModelResponse) {
    let service = MarvelCharactersRequest.marvelCharacterDetail(id: id)
    networking.fetchMarvelCharacters(service: service) { result in
      completion(result)
    }
  }
}
