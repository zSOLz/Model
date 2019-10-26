//
//  KeyboardSizeObserver.swift
//  Model-Sample
//
//  Created by SOL on 09.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import UIKit

class KeyboardHeightObserver {
    var heightChangedClosure: ((CGFloat) -> Void)?
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KeyboardHeightObserver.keyboardWillChangeSize(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KeyboardHeightObserver.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KeyboardHeightObserver.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

private extension KeyboardHeightObserver {
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        heightChangedClosure?(frame.size.height)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        heightChangedClosure?(0)
    }

    @objc func keyboardWillChangeSize(_ notification: NSNotification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        heightChangedClosure?(frame.size.height)
    }

}
