//
//  MusicVideoDetailViewController.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 06/03/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit

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

    

  

}
