//
//  MusicVideo.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 22/02/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import Foundation

class MusicVideo {
    
     var rank = 0
    
    // data encapsulation
    private var _name: String
    private var _rigths: String
    private var _price: String
    private var _imageURL: String
    private var _videoURL: String
    private var _artist: String
    private var _iMid: String
    private var _genre: String
    private var _videoLinkToiTunes: String
    private var _releaseDate: String
    
    
    // this variable is created from the UI, optional
    var imageData:NSData?
    
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
    
    var rigths: String {
        return _rigths
    }
    
    var price: String {
        return _price
    }
    
    var artist: String {
        return _artist
    }
    
    var iMid: String {
        return self._iMid
    }
    
    var genre: String {
        return self._genre
    }
    
    var videoLinkToiTunes: String {
        return _videoLinkToiTunes
    }
    
    var releaseDate: String {
        return _releaseDate
    }
    

    // Custom Initializer for MusicVideo Objects
    
    init(data: JSONDictionary) {
        
        
        // VideoName data from json match
        if let videoNameDictionary = data["im:name"] as? JSONDictionary,
            videoName = videoNameDictionary["label"] as? String {
                _name = videoName
        }
        else { // in case we get nothing back from the JSON
            
            _name = ""
            
        }
        
        // rigths
        if let rigthsDictionary = data["rights"] as? JSONDictionary, // { dictionary
            rigthsLabel = rigthsDictionary["label"] as? String {
                _rigths = rigthsLabel
        }
        else { // in case we get nothing back from the JSON
            
            _rigths = ""
            
        }
        
        // price
        if let priceDictionary = data["im:price"] as? JSONDictionary, // { dictionary
            priceLabel = priceDictionary["label"] as? String {
                _price = priceLabel
        }
        else { // in case we get nothing back from the JSON
            
            _price = ""
            
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
        
        // artist
        if let artistDictionary = data["im:artist"] as? JSONDictionary, // { dictionary
            artistName = artistDictionary["label"] as? String {
                _artist = artistName
        }
        else { // in case we get nothing back from the JSON
            
            _artist = ""
            
        }
        
        // imid
        if let iMid = data["id"] as? JSONDictionary, // { dictionary
            idVideo = iMid["label"] as? String {
                _iMid = idVideo
        }
        else { // in case we get nothing back from the JSON
            
            _iMid = ""
            
        }
        
        //genre
        if let genre = data["category"] as? JSONDictionary,
            genreDictionary = genre["attributes"] as? JSONDictionary,
            genreLabel = genreDictionary["label"] as? String {
            _genre = genreLabel
                
        } else {
            
            _genre=""
        }
        
        // link
        if let videoLinkToiTunes = data["link"] as? JSONArray,
            attrDictionary = videoLinkToiTunes[1] as? JSONDictionary, // [1,2,3]
            hrefURL = attrDictionary["href"] as? String {
                _videoLinkToiTunes = hrefURL
                
        }
        else
        {
            _videoLinkToiTunes = ""
        }
        
        // release data
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary, // { dictionary
            date = releaseDate["label"] as? String {
                _releaseDate = date
        }
        else { // in case we get nothing back from the JSON
            
            _releaseDate = ""
            
        }
        
    }

}