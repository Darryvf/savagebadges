//
//  LoginViewController.swift
//  Savage Badges
//
//  Created by Darrell Vanfleet on 9/8/18.
//  Copyright © 2018 Darrell Vanfleet. All rights reserved.
//

import UIKit
import Auth0


class LoginViewController: UIViewController {
    var credentials:Credentials?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showLoginController(_ sender: UIButton) {
        guard let clientInfo = plistValues(bundle: Bundle.main) else {return}
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://savagebadges.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    guard let accessToken = credentials.accessToken, let idToken = credentials.idToken else { return }
                    self.credentials = credentials
                    print("Credentials: \(credentials)")
                    print("Credentials access token: \(credentials.accessToken)")
                }
            }
    }
    
    @IBAction func GetUsers(_ sender: Any) {
        let airTableService = AirTableSevice()
        airTableService.getUsers()
        print("done")
        
    }
    @IBAction func Logout(_ sender: Any) {
        self.credentials = nil
    }

    func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
        guard
            let path = bundle.path(forResource: "Auth0", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path) as? [String: Any]
            else {
                print("Missing Auth0.plist file with 'ClientId' and 'Domain' entries in main bundle!")
                return nil
        }
        
        guard
            let clientId = values["ClientId"] as? String,
            let domain = values["Domain"] as? String
            else {
                print("Auth0.plist file at \(path) is missing 'ClientId' and/or 'Domain' entries!")
                print("File currently has the following entries: \(values)")
                return nil
        }
        return (clientId: clientId, domain: domain)
    }

}
