//
//  MarvelCharacterDetailCoordinator.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 05/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import UIKit

class MarvelCharacterDetailCoordinator: CoordinatorProtocol {
  var marvelCharacterDetailViewController: MarvelCharacterDetailViewController?
  var navigationController: UINavigationController?

  init(navigationController: UINavigationController, characterId: String) {
    self.navigationController = navigationController
    let presenter = MarvelCharacterDetailPresenter(coordinator: self, characterId: characterId)
    marvelCharacterDetailViewController = MarvelCharacterDetailViewController(presenter: presenter)
  }

  func start() {
    guard let marvelCharacterDetailViewController = marvelCharacterDetailViewController else { return }
    navigationController?.pushViewController(marvelCharacterDetailViewController, animated: true)
    marvelCharacterDetailViewController.showNavigationBar()
  }
}
