//
//  SelectBadgeViewController.swift
//  savagebadges
//
//  Created by Darrell Vanfleet on 9/9/18.
//  Copyright © 2018 Darrell Vanfleet. All rights reserved.
//

import UIKit

class SelectBadgeViewController: UIViewController {


    @IBOutlet weak var badge: UIImageView!
    
    @IBOutlet weak var badge3: UIImageView!
    @IBOutlet weak var badge2: UIImageView!
    @IBOutlet weak var labelName2: UILabel!
    
    @IBOutlet weak var labelName3: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelDisc3: UILabel!
    @IBOutlet weak var labelDisc2: UILabel!
    @IBOutlet weak var labelDisc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.GetBadge()
        // Do any additional setup after loading the view.
    }
    func GetBadge() {
        let airTableService = AirTableSevice()
        airTableService.getBadges(completion: {[weak self] (badge: Response2) in self?.useData(badge: badge )})
        print("done")
        
    }
    
    func useData(badge: Response2){
        print(badge)
        print("hi")
        DispatchQueue.main.async {
            self.labelName.text = badge.records[0].fields.Badge_Name
            self.labelName.sizeToFit()
            self.labelDisc.text = badge.records[0].fields.Badge_Description
            self.labelDisc.sizeToFit()
            let url = URL(string: badge.records[0].fields.Image[0].thumbnails.large.url)
            let data = try? Data(contentsOf: url!)
            self.badge.image = UIImage(data: data!)
            
            self.labelName2.text = badge.records[1].fields.Badge_Name
            self.labelName2.sizeToFit()
            self.labelDisc2.text = badge.records[1].fields.Badge_Description
            self.labelDisc2.sizeToFit()
            let url2 = URL(string: badge.records[1].fields.Image[0].thumbnails.large.url)
            let data2 = try? Data(contentsOf: url2!)
            self.badge2.image = UIImage(data: data2!)
            
            self.labelName3.text = badge.records[2].fields.Badge_Name
            self.labelName3.sizeToFit()
            self.labelDisc3.text = badge.records[2].fields.Badge_Description
            self.labelDisc3.sizeToFit()
            let url3 = URL(string: badge.records[2].fields.Image[0].thumbnails.large.url)
            let data3 = try? Data(contentsOf: url3!)
            self.badge3.image = UIImage(data: data3!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
