//
//  MarvelCharactersCoordinator.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 02/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import UIKit

class MarvelCharactersCoordinator: CoordinatorProtocol {
  var marvelCharactersViewController: MarvelCharactersViewController?
  var navigationController: UINavigationController?

  init() {
    let presenter = MarvelCharactersPresenter(coordinator: self)
    marvelCharactersViewController = MarvelCharactersViewController(presenter: presenter)
  }

  func start() {
    guard let marvelCharactersViewController = marvelCharactersViewController else { return }
    navigationController = UINavigationController(rootViewController: marvelCharactersViewController)
    marvelCharactersViewController.hideNavigationBar()
  }

  func goToDetailCharacter(characterId: String) {
    guard let navigationController = navigationController else { return }
    let marvelCharacterDetailCoordinator = MarvelCharacterDetailCoordinator(navigationController: navigationController, characterId: characterId)
    marvelCharacterDetailCoordinator.start()
  }
}
