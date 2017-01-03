//
//  NetworkOperation.swift
//  VideoPlayer
//
//  Created by Neven on 3/29/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    // download session
    lazy var config: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.config)
    let queryURL: URL
    
    init(url: URL) {
        queryURL = url
    }
    
    func downloadJSONList(_ completion: @escaping ([String: AnyObject]) -> Void) {
        
        let request: URLRequest = URLRequest(url: queryURL)
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as! [String: AnyObject]
                        completion(jsonDictionary)
                    } catch {
                        print("Not a valid HTTP response!")
                    }
                default:
                    print("Get response not successful. HTTP status code: \(httpResponse.statusCode)")
                }
            } else {
                print("Error: Not a valid HTTP response")
            }
            
        }) 
        
        dataTask.resume()
        
    }
    
    
    
}










