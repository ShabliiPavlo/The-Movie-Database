//
//  ExtantionUITabBarController.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 26.03.2023.
//

import Foundation
import UIKit

extension UITabBarController {
    func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        if tabBar.isHidden == hidden { return }
        let frame = tabBar.frame
        let offset = (hidden ? tabBar.frame.size.height : -tabBar.frame.size.height)
        let duration: TimeInterval = (animated ? 1.0 : 0.0)
        tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        tabBar.isHidden = hidden
        UIView.animate(withDuration: duration) {
            self.tabBar.frame = frame
        }
    }
}
