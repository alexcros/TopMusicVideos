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
    func loadData(urlString:String, completion: [MusicVideo] -> Void) {
        
        // no caching: no persistent changes in disk, cookies, cache or credentials
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        // create session
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) { // task.resume()
            (data, response,error ) -> Void in
        
        if error != nil {
//            dispatch_async(dispatch_get_main_queue()) {
//                completion(result: (error!.localizedDescription))
            
            print(error!.localizedDescription)
            
            
        } else {
                // Added for JSON serialization
                //print(data)
                do {
                    /* Allow fragments - top level objects is not Array or Dictionary.
                    Any type of string or value NSJSONSerialization requires de the
                    Do / Try / Catch Converts the NSDATA into a JSON Object and cast it
                    to a Dictionary */
                    
                    // APIManager logic start
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary, // data to JSONDictionary root
                        feed = json["feed"] as? JSONDictionary,
                        videoArray = feed["entry"] as? JSONArray {
                            
                            var videos = [MusicVideo]()
                            for entry in videoArray {
                                let entry = MusicVideo(data: entry as! JSONDictionary)
                                videos.append(entry)
                            }
                            // APIManager logic end
                            let i = videos.count
                            print("iTunesApiManager retrieve \(i) videos")
                            print(" ")
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(videos)
                                }
                            }
                }
                } catch {
                    
                    print("error in JSONSerialization")
            }
            }
        }
            task.resume()
}
}