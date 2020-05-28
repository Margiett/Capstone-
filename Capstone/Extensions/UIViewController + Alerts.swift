//
//  UIViewController + Alerts.swift
//  Capstone
//
//  Created by Margiett Gil on 5/28/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func showAlert(title: String?, message: String?, _ completion: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}


