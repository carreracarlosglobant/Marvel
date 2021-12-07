//
//  UIImageView+Extension.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 05/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import UIKit

extension UIImageView {
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
