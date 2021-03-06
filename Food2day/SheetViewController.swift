//
//  SheetViewController.swift
//  Food2day
//
//  Created by Oksana Gorbachenko on 6/10/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class SheetViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    
    private let service = GTLRSheetsService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        
        signInButton.center = view.center
        
        // Add the sign-in button.
        view.addSubview(signInButton)
        
        // Add a UITextView to display output.
        output.frame = view.bounds
        output.isEditable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        output.isHidden = true
        view.addSubview(output);
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            listMajors()
        }
    }
    
    // Display (in the UITextView) the names and majors of students in a sample
    // spreadsheet:
//    https://docs.google.com/spreadsheets/d/1T_pl77kO1hlM6_T7G-nXKvk5jRSxqVoAJVLdX0by61U/edit#gid=1044038961
    func listMajors() {
        output.text = "Getting sheet data..."
        let spreadsheetId = "1T_pl77kO1hlM6_T7G-nXKvk5jRSxqVoAJVLdX0by61U"
        let range = "A1:M34"
//        =QUERY(A1:M34, "SELECT B, D,E,F,G,H,I,J,K,L,M where A = 'Боб Макаду'")
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet
            .query(withSpreadsheetId: spreadsheetId, range:range)
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
        )
    }
    
    // Process the response and display output
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                 finishedWithObject result : GTLRSheets_ValueRange,
                                 error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var majorsString = ""
        let rows = result.values!
        
        if rows.isEmpty {
            output.text = "No data found."
            return
        }
        
        majorsString += "Name, Food:\n"
        for row in rows {
            print(row)
            let name = row[0]
            let food = row[1]
            let food1 = row[2]
            let food2 = row[3]
            let food3 = row[4]
            let food4 = row[5]
            let food5 = row[6]
            let food6 = row[7]
            
            
            majorsString += "\(name), \(food), \(food1), \(food2), \(food3).\(food4), \(food5), \(food6)\n"
        }
        
        output.text = majorsString
    }
    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
