//
//  ViewController.swift
//  Food2day
//
//  Created by Oksana Gorbachenko on 6/10/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import UIKit
import GoogleSignIn
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        GGLContext.sharedInstance().configureWithError(&Error)
        GIDSignIn.sharedInstance().clientID = "25027437899-03so7uriveoe2ul6h1u0qaktf4c59tns.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()
        let signInButton = GIDSignInButton()
        signInButton.center = view.center
        
        view.addSubview(signInButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

