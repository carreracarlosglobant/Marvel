//
//  UIViewController+Extension.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 02/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import UIKit

extension UIViewController {
  func hideNavigationBar() {
    navigationController?.setNavigationBarHidden(true, animated: true)
  }

  func showNavigationBar() {
      navigationController?.setNavigationBarHidden(false, animated: true)
  }
}
