//
//  ViewController.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 21/02/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/es/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
        
        
    }
    // shows API binary data
    func didLoadData(result:String) {
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            
            }
        //configure alert and show
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
  

}

