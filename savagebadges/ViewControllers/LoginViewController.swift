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
    var credentialsManager:CredentialsManager?
    static var isUserLoggedIn:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showLoginController(_ sender: UIButton) {
        self.showLogin()
    }
    
    func showLogin(){
        guard let clientInfo = plistValues(bundle: Bundle.main) else {return}
        
        
        if (!LoginViewController.isUserLoggedIn ){
            self.credentials = nil
            self.credentialsManager?.clear()
        }
        var hasVal = self.credentialsManager?.hasValid()
        
        Auth0
            .webAuth()
            .scope("openid profile offline_access")
            .audience("https://savagebadges.auth0.com/userinfo")
            .parameters(["prompt":"login"])
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
                    var isValid = self.credentialsManager?.hasValid()
                    if(!SessionManager.shared.store(credentials: credentials)) {
                        print("Failed to store credentials")
                    } else {
                        print("Stored credentials")
                        LoginViewController.isUserLoggedIn = true;
                        SessionManager.shared.retrieveProfile { error in
                            DispatchQueue.main.async {
                                guard error == nil else {
                                    print("Failed to retrieve profile: \(String(describing: error))")
                                    return self.showLogin()
                                }
                                print("Profile is:  \(SessionManager.shared.profile)")
                                self.performSegue(withIdentifier: "SegueToDashboard", sender: nil)
                            }
                        }

                     }
                }
                
            }
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SegueToDashboard" {
            if let vc = segue.destination as? DashboardViewController {
                let userSub = SessionManager.shared.profile?.sub
                vc.userSub = userSub
            }
        }
     
    }


    func useData(something: Bool){
        print(something)
        print("in useData from logout")
        LoginViewController.isUserLoggedIn = false
        self.credentials = nil
        var clearedCredentials = self.credentialsManager!.clear()
        

    }
    
    @IBAction func Logout(_ sender: Any) {
    
//        Auth0.authentication().revoke(refreshToken: (self.credentials?.refreshToken)!)
        Auth0.webAuth().clearSession(federated: false, callback: {[weak self] (something: Bool) in self?.useData(something: something)})
        
        
        
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
