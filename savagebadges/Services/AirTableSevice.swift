//
//  AirTableSevice.swift
//  savagebadges
//
//  Created by Darrell Vanfleet on 9/11/18.
//  Copyright © 2018 Darrell Vanfleet. All rights reserved.
//

import Foundation

class AirTableSevice: NSObject {
    func getUsers() {
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "34e24daf-ee72-d6ae-048e-5d9eeabd150b"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.airtable.com/v0/appd658AaGaAXmAeI/User?api_key=keyeyl7q3HzLXF5A6")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                guard let data = data else { return }
                //Implement JSON decoding and parsing
                do {
                    let json = try? JSONSerialization.jsonObject(with: data, options:[])
                    print(json)
                    //Decode retrived data with JSONDecoder and assing type of Article object
//                    let usersData = try JSONDecoder().decode([User].self, from: data)
//                    print(usersData)
                    //Get back to the main queue
                    DispatchQueue.main.async {
                        //print(articlesData)
//                        self.articles = articlesData
//                        self.collectionView?.reloadData()
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
   
            }
        })
        
        
        dataTask.resume()
    }
}
