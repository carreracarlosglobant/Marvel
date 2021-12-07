//
//  MarvelCharacterDetailPresenter.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 05/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

protocol MarvelCharacterDetailPresenterDelegate: AnyObject {
  func updateData()
  func showActivityView()
  func hideActivityView()
  func showMessageError(message: String)
}


class MarvelCharacterDetailPresenter {
  private let coordinator: MarvelCharacterDetailCoordinator
  private var characterId: String
  private let manager = MarvelCharactersServicesManager()

  var model: MarvelCharacterDetailModel?
  var delegate: MarvelCharacterDetailPresenterDelegate?
  
  init(coordinator: MarvelCharacterDetailCoordinator, characterId: String) {
    self.coordinator = coordinator
    self.characterId = characterId
  }

  func getMarvelCharacterDetail() {
    delegate?.showActivityView()
    manager.marvelCharacterDetail(id: characterId) { [weak self] result in
      switch result {
      case .success(let response):
        if let character = response?.data.results.first {
          self?.delegate?.hideActivityView()
          let description = character.description.isEmpty ? "Description not available" : character.description
          let image = "\(character.thumbnail.path).\(character.thumbnail.extensionString)"
          self?.model = MarvelCharacterDetailModel(title: character.name,
                                                   description: description,
                                                   URLImage: image)
          self?.delegate?.updateData()
        }
      case .failure(let error):
        self?.delegate?.hideActivityView()
        self?.delegate?.showMessageError(message: error.error)
      }
    }
  }
}
