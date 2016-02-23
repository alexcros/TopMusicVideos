//
//  MusicVideo.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 22/02/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import Foundation

class MusicVideos {
    
    // data encapsulation: update from api backend
    
    private var _name: String
    private var _imageURL: String
    private var _videoURL: String
    
    // getters
    
    var name: String {
        return _name
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var videoURL: String {
        return _videoURL
    }

    // Initializer for MusicVideo Objects
    
    init(data: JSONDictionary) {
        
        
        // VideoName data from json match "im:var" Initialize all properties for avoid errors
        if let videoNameDictionary = data["im:name"] as? JSONDictionary, // { dictionary
            videoName = videoNameDictionary["label"] as? String {
                _name = videoName
        }
        else { // in case we get nothing back from the JSON
            
            _name = ""
            
        }
        
        // Thumbnails
        if let imageArray = data["im:image"] as? JSONArray,
            imageDictionaryThumbnail = imageArray[2] as? JSONDictionary, // [1,2,3]
            imageLabel = imageDictionaryThumbnail["label"] as? String {
                _imageURL =
                    imageLabel.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")// pass the image from JSON and replace the imageResolution
        }
        else
        {
            _imageURL = ""
        }
        
        // VideoURL
        if let videoArray = data["link"] as? JSONArray, // [ array
            urlDictionary = videoArray[1] as? JSONDictionary, // { Dictionary
            attributeDictionary = urlDictionary["attributes"] as? JSONDictionary,
            videoHref = attributeDictionary["href"] as? String {
                _videoURL = videoHref
        }
        else
        {
            _videoURL = "" // in case we get nothing back from the JSON
        }
        
        
    }


}