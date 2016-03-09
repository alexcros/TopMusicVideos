//
//  MusicVideoDetailViewController.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 06/03/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit
// for AVPlayer
import AVKit
import AVFoundation

class MusicVideoDetailViewController: UIViewController {

    var videoArray : MusicVideo!
    
    var sec:Bool = false
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var genre: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var rights: UILabel!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sec = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        title = videoArray.artist
        	
        // outlets assignment
        name.text = videoArray.name
        price.text = videoArray.price
        rights.text = videoArray.rigths
        genre.text = videoArray.genre
        
        if videoArray.imageData != nil {
            videoImage.image = UIImage(data: videoArray.imageData!)
        
        } else {
            videoImage.image = UIImage(named: "noPhotoAvailable")
        }
    }
    
    func shareMedia() {
        
        let activity1 = "Have you had the opportunity to see this Video?"
        let activity2 = ("-\(videoArray.name) by \(videoArray.artist)-")
        //let activity3 = "Watch it and tell me what you think!"
        let activity4 = videoArray.videoLinkToiTunes
        let activity5 = "https://github.com/alexcros/TopMusicVideos"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity4, activity5], applicationActivities: nil)
        
        //activityViewController.excludedActivityTypes = [UIActivityTypeMail]
        
        // activityViewController.excludedActivityTypes = [
        // UIActivityTypePostToTwitter,
        // UIActivityTypePostToFacebook,
        // UIActivityTypeMessage,
        // UIActivityTypeMail,
        // UIActivityTypePrint,
        // UIActivityTypeCopyToPasteBoard,
        // UIActivityTypeAssignToContact,
        // UIActivityTypeSaveToCameraRoll,
        // UIActivityTypeAddToReadingList,
        // UIActivityTypePostToFlickr,
        // UIActivityTypePostToVimeo,
        // UIActivityTypePostToTencentWeibo
        
        //]
        
        // block
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityTypeMail {
                print("email selected")
            }
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }

    // share with security
    @IBAction func shareSocialMedia(sender: UIBarButtonItem) {
    
        shareMedia()
    
    }
    
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        
        // url from videoArray
        let url = NSURL(string: videoArray.videoURL)!
        
        let player = AVPlayer(URL: url)
        
        let playerInViewController = AVPlayerViewController()
        
        playerInViewController.player = player
        
        self.presentViewController(playerInViewController, animated: true) {
            
            playerInViewController.player?.play()
        }
        
        
        
        
        
        
        
        
        
        
        
    }
  

    
    
    
    
    
}
