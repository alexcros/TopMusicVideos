//
//  MusicVideo.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 22/02/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import Foundation

class Videos {
    // data encapsulation: update from api backend
    
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    
    // getters
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    init(data: JSONDictionary) {
        // Initialize all properties for avoid errors
        // Create a initializer
        
        // VideoName data from json match "im:var"
        if let name = data["im:name"] as? JSONDictionary, // { dictionary
            vName = name["label"] as? String {
                self._vName = vName
        }
        else {
            // no data back from JSON - element in the JSON unexpected
            _vName = ""
            
        }
        
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            imageLabel = image["label"] as? String {
                _vImageUrl =
                    imageLabel.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")// pass the image from JSON and replace the imageResolution
        }
        else
        {
            _vImageUrl = ""
        }
        
        //VideoURL
        if let video = data["link"] as? JSONArray, // [ array
            vUrl = video[1] as? JSONDictionary, // { Dictionary
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl = ""
        }
        
        
    }


}