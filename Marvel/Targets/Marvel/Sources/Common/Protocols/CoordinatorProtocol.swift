//
//  CoordinatorProtocol.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 02/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import UIKit

/// Defines properties and methods that a `Coordinator` implementation must comply.
protocol CoordinatorProtocol: AnyObject {
    /// Initial method to set up the `Navigation` of a module
    func start()
}
