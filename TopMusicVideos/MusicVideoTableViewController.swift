//
//  MusicVideoTableViewController.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 05/03/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit

class MusicVideoTableViewController: UITableViewController {

    
    var videos = [MusicVideo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        //displayLabel.text = "No Internet"
            
        case WIFI : view.backgroundColor = UIColor.greenColor()
        //displayLabel.text = "WIFI OK"
            
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        //displayLabel.text = "Cellular OK"
            
        default : return
            
        }
    }
    // removeObserver: called when object is about to be deallocated
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count 
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // cfg cell
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        
        cell.detailTextLabel?.text = video.name

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
