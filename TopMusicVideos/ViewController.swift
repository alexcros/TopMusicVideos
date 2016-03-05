//
//  ViewController.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 21/02/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videos = [MusicVideo]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // tableView.dataSource = self
        
       // tableView.delegate = self
        
        
        // addObserver: call ReachStatusChanged selector:in appDelegate
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        // call function status
        reachabilityStatusChanged()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/es/rss/topmusicvideos/limit=50/json", completion: didLoadData)
        
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
        
        tableView.reloadData()
        
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {// Default is 1 if not implemented
        
        return 1
        
    }
    
    // protocol methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
        
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        
        cell.detailTextLabel?.text = video.name
        
        return cell
    }
    
    
    
    
}

