//
//  ForceTouchUtility.swift
//  Brandi
//
//  Created by brandi on 2016. 5. 23..
//  Copyright © 2016년 Brandi. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
class ForceTouchUtility {
    
    static func registerViewControllerForPreview(_ viewController: SuperViewController, delegate: UIViewControllerPreviewingDelegate, sourceView: UIView) {
        if viewController.traitCollection.forceTouchCapability == .available {
            viewController.registerForPreviewing(with: delegate, sourceView: sourceView)
        }
    }
}
