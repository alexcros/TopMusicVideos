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
        
        let task = session.dataTaskWithURL(url) { // task.resume()
            (data, response,error ) -> Void in
        
        if error != nil {
            dispatch_async(dispatch_get_main_queue()) {
                completion(result: (error!.localizedDescription))
            }
        }else {
                // Added for JSON serialization
                //print(data)
                do {
                    /* Allow fragments - top level objects is not Array or Dictionary.
                    Any type of string or value NSJSONSerialization requires de the
                    Do / Try / Catch Converts the NSDATA into a JSON Object and cast it
                    to a Dictionary */
                    
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)// option for application don't crash
                        // waits for dictionary { not array [
                        as? [String: AnyObject] {
                            
                            print(json) //  console
                            // try diferent priority? DISPATCH_QUEUE_PRIORITY_LOW
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH // QOS
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(result: "JSONSerialization Succesful")
                                }
                            }
                    }
                } catch {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(result: "error in JSONSerialization")
                    }
                }
                
                // End of JSONSerialization
            
            
                }
            }
        task.resume()
}
}