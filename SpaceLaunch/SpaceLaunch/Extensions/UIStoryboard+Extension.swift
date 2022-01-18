//
//  UIStoryboard+Extension.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 17/1/22.
//

import UIKit

extension UIStoryboard {
    private static let main = UIStoryboard(name: "Main", bundle: nil)

    static var spaceLaunchHomeViewController: SpaceLaunchHomeViewController  {
        return UIStoryboard.main.instantiateViewController(withIdentifier: "SpaceLaunchHomeViewController") as! SpaceLaunchHomeViewController
    }
    
    static var spaceLaunchDetailViewController: SpaceLaunchDetailViewController  {
        return UIStoryboard.main.instantiateViewController(withIdentifier: "SpaceLaunchDetailViewController") as! SpaceLaunchDetailViewController
    }
}
