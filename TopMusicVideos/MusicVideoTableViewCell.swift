//
//  MusicVideoTableViewCell.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 05/03/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var thumbnailImage: UIImageView!
   
    @IBOutlet weak var rank: UILabel!

    @IBOutlet weak var musicTitle: UILabel!
    
    var video : MusicVideo? {
        didSet {
            updateCell()
            
        }
    }
    
    func updateCell(){
        musicTitle.text = video?.name
        rank.text = ("\(video!.rank)")
       // thumbnailImage.image = UIImage(named: "noPhotoAvailable")
        
        if video!.imageData != nil {
        
            print("Get data from array...")
            thumbnailImage.image = UIImage(data: video!.imageData!)
        
        } else {
            
            getVideoImage(video!, imageView: thumbnailImage) // IBOutlet
        }
    }
    
    func getVideoImage (video: MusicVideo, imageView: UIImageView) {
        // background thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: video.imageURL)!)
        
            var image : UIImage?
            
            if data != nil { // first time put on array
                    video.imageData = data
                    image = UIImage(data: data!) // override noPhotoImage
            }
            // move back to main queue, URL image overrided
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
