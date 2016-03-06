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
        thumbnailImage.image = UIImage(named: "noPhotoAvailable")
    }
    
}
