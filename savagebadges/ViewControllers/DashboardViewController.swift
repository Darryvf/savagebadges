//
//  DashboardViewController.swift
//  savagebadges
//
//  Created by Darrell Vanfleet on 9/9/18.
//  Copyright © 2018 Darrell Vanfleet. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var userSub:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.GetUser()
        // Do any additional setup after loading the view.
    }
    func GetUser() {
        let airTableService = AirTableSevice()
        airTableService.getUsers(accountNumber: self.userSub, completion: {[weak self] (users: Response) in self?.useData(users: users)})
        print("done")
        
    }
    
    func useData(users: Response){
        print(users)
        print("hi")
        DispatchQueue.main.async {
            self.firstName.text = users.records[0].fields.FirstName
            self.lastName.text = users.records[0].fields.LastName
            let url = SessionManager.shared.profile?.picture
            let data = try? Data(contentsOf: url!)
            self.profileImage.image = UIImage(data: data!)
        }
        
    }
    
    func useData(user: Response1){
        print(user)
        print("hi")
        DispatchQueue.main.async {
            self.firstName.text = user.fields.FirstName
            self.lastName.text = user.fields.LastName
            let url = URL(string: user.fields.Image[0].thumbnails.large.url)
            let data = try? Data(contentsOf: url!)
            self.profileImage.image = UIImage(data: data!)
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToLoginPage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        //self.performSegue(withIdentifier: "SegueToLoginViewController", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
