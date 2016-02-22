//
//  APIManager.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 22/02/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import Foundation

class APIManager {
    // urlString from VC and completion
    func loadData(urlString:String, completion: (result:String) -> Void) {
        
        // no caching: no persistent changes in disk, cookies, cache or credentials
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        // create session
        //let session = NSURLSession.sharedSession() //singleton d pattern, just one session caching
        let url = NSURL(string: urlString)!
        
        // run in a suspended state to background thread: asynchronous call
        let task = session.dataTaskWithURL(url) {
        (data, response, error) -> Void in// binary data, http response, errors?
        
        // moving to the main thread
        dispatch_async(dispatch_get_main_queue()) {
        if error != nil {
            // localizedDescription messages: Internet connection appears to be offline, etc
            completion(result: (error!.localizedDescription))
        } else {
        completion(result: "NSURLSession succesful")
        print(data)
        }
        }
        
        }
    task.resume()
    }
}