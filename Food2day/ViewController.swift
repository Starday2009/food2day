//
//  ViewController.swift
//  Food2day
//
//  Created by Oksana Gorbachenko on 6/10/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import UIKit
import GoogleSignIn
class ViewController: UIViewController, GIDSignInUIDelegate {
  
    override func viewDidLoad() {
        super.viewDidLoad()
       setupGoogleButton()
        
        
    }
    
    fileprivate func setupGoogleButton(){
        let signInButton = GIDSignInButton()
        signInButton.frame = CGRect(x: 60, y: 500, width: view.frame.width - 115, height: 50)
        signInButton.center = view.center
        view.addSubview(signInButton)
        
        GIDSignIn.sharedInstance().clientID = "25027437899-03so7uriveoe2ul6h1u0qaktf4c59tns.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

