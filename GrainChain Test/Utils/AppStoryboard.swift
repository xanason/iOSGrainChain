//
//  AppStoryboard.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/7/19.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    
    case Main,Contacts
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController> (viewControllerClass: T.Type) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardId) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
    
}


