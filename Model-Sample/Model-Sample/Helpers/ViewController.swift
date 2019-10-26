//
//  ViewController.swift
//  Model-Sample
//
//  Created by Andrei Salavei on 10/19/19.
//  Copyright © 2019 SOL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
    }
    
    func setupContent() {
        // Empty. Override to perform custom content setup.
        // Method should be called once during life cycle.
    }
    
    func applyStye() {
        // Empty. Override to perform custom style customization.
        // Method could be called several times.
    }
    
    func errorClosure(completion: (() -> Void)? ) -> (Error) -> Void {
        return { error in
            // TODO:
            let errorString = "\(type(of: error)).\(String(describing: error))"
            print(errorString)
            completion?()
        }
    }
    
    var errorClosure: (Error) -> Void {
        return errorClosure(completion: nil)
    }
}
