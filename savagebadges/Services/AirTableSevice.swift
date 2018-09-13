//
//  AirTableSevice.swift
//  savagebadges
//
//  Created by Darrell Vanfleet on 9/11/18.
//  Copyright © 2018 Darrell Vanfleet. All rights reserved.
//

import Foundation

class AirTableSevice: NSObject {
    func getUsers(){
        let headers = [
            "Authorization": "Basic Og==",
            "cache-control": "no-cache",

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
                let decoder = JSONDecoder()
                guard let users = try? decoder.decode(Response.self, from: data)
                    else{
                        print(error)
                        return
                }
                print(users)
   
            }
        })
        
        
        dataTask.resume()
    }
    func getUser(userID: String, completion: @escaping ((Response1) -> Void)) {
        let headers = [
            "Authorization": "Basic Og==",
            "cache-control": "no-cache",
            
            ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.airtable.com/v0/appd658AaGaAXmAeI/User/" + userID + "?api_key=keyeyl7q3HzLXF5A6")! as URL,
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
                let decoder = JSONDecoder()
                guard let user = try? decoder.decode(Response1.self, from: data)
                    else{
                        print(error)
                        return
                }
                print(user)
                completion (user)
            }
        })
        
        
        dataTask.resume()
    }
    
    func getBadges(completion: @escaping ((Response2) -> Void)) {
        let headers = [
            "Authorization": "Basic Og==",
            "cache-control": "no-cache",
            
            ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.airtable.com/v0/appd658AaGaAXmAeI/Badge?api_key=keyeyl7q3HzLXF5A6")! as URL,
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
                let decoder = JSONDecoder()
                guard let badge = try? decoder.decode(Response2.self, from: data)
                    else{
                        print(error)
                        return
                }
                print(badge)
                completion (badge)
            }
        })
        
        
        dataTask.resume()
    }
}
