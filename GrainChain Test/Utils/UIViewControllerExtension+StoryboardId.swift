//
//  UIViewControllerExtension+StoryboardId.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/7/19.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    class var segueID : String {
        return "Navigate" + "\(self)"
    }
    
}
