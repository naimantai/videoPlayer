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
<<<<<<< HEAD
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
=======
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    init(url: NSURL) {
        queryURL = url
    }
    
    func downloadJSONList(completion: [String: AnyObject] -> Void) {
        
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! [String: AnyObject]
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
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
            
<<<<<<< HEAD
        }) 
=======
        }
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        
        dataTask.resume()
        
    }
    
    
    
}










