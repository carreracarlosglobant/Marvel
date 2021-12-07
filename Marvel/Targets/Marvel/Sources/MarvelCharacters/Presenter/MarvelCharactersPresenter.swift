//
//  MarvelCharactersPresenter.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 02/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

protocol MarvelCharactersPresenterDelegate: AnyObject {
  func updateContent()
  func showMessageError(message: String)
  func showActivityView()
  func hideActivityView()
}

class MarvelCharactersPresenter {
  private let coordinator: MarvelCharactersCoordinator
  private let manager = MarvelCharactersServicesManager()

  weak var delegate: MarvelCharactersPresenterDelegate?
  var model: MarvelCharactersModel = MarvelCharactersModel()
  var characters: [MarvelCharacter] = []
  
  init(coordinator: MarvelCharactersCoordinator) {
    self.coordinator = coordinator
  }

  func getMarvelCHaracters() {
    self.delegate?.showActivityView()
    manager.marvelCharacters { [weak self] result in
      switch result {
      case .success(let response):
        if let characters = response?.data.results {
          self?.characters = characters
          self?.delegate?.updateContent()
          self?.delegate?.hideActivityView()
        }
      case .failure(let error):
        self?.delegate?.hideActivityView()
        self?.delegate?.showMessageError(message: error.error)

      }
    }
  }

  func goToCharacterDetail(characterId: Int?) {
    guard let characterId = characterId else { return }
    coordinator.goToDetailCharacter(characterId: "\(characterId)")
  }
}
