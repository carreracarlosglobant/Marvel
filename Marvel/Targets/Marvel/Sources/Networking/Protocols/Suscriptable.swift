//
//  Suscriptable.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 03/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation

protocol Subscriptable {
  associatedtype Name: Hashable
  subscript(index: Name) -> String { get set }
}
