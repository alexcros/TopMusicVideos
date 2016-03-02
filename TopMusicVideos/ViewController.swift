//
//  ViewController.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 21/02/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [MusicVideo]()
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addObserver: call ReachStatusChanged selector:in appDelegate
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        // call function status
        reachabilityStatusChanged()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/es/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }
    // shows API binary data
    func didLoadData(videos: [MusicVideo]) {// bring back videos
        
        print(reachabilityStatus)
        
        self.videos = videos
        
//        for item in videos {
//            print("name = \(item.name)")
//        }
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.name)")
        }
        
//        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
//        
//        let okAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
//            
//            }
//        //configure alert and show
//        alert.addAction(okAction)
//        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
            
            case NOACCESS : view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        
            case WIFI : view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "WIFI OK"
        
            case WWAN : view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Cellular OK"
        
            default : return
            
        }
    }
    // removeObserver: called when object is about to be deallocated
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

}

