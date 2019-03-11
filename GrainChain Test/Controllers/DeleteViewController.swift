//
//  DeleteViewController.swift
//  GrainChain Test
//
//  Created by Tecnocen on 3/7/19.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation
import UIKit
import MZFormSheetPresentationController

class DeleteViewController: UIViewController {
    
    var listViewController : ContactListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    static func newInstance(uiViewController: UIViewController,
                            parentViewController: UIViewController) -> MZFormSheetPresentationViewController {
        let formSheetController = MZFormSheetPresentationViewController(contentViewController: uiViewController)
        formSheetController.presentationController?.shouldDismissOnBackgroundViewTap = true
        formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyle.dropDown
        formSheetController.presentationController?.shouldCenterVertically = true
        formSheetController.presentationController?.contentViewSize = CGSize(width: parentViewController.view.bounds.size.width - 40.0, height: 230.0)
        return formSheetController
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func deleteContact (_ sender: Any) {

        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name.CompleteContactDelete, object: self)
        }
    }
    
}
extension Notification.Name {
    static let CompleteContactDelete = Notification.Name(
        rawValue: "CompleteContactDelete")
}
