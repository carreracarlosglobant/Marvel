//
//  AppCoordinator.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 02/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
  var navigationController: UINavigationController?

  private var window: UIWindow

  init(window: UIWindow) {
    self.window = window
  }

  func start() {
    let marvelCharactersCoordinator = MarvelCharactersCoordinator()
    marvelCharactersCoordinator.start()
    window.rootViewController = marvelCharactersCoordinator.navigationController
  }
}
