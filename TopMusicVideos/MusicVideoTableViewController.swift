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
            
        case NOACCESS :
            //view.backgroundColor = UIColor.redColor()
            // If we don't have access, come back to main queue
            dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title:"No Internet", message: "Please, make sure you are connected to the internet", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                action -> Void in
                print("Cancel")
            }
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                action -> () in
                print("Delete")
            }
            let okAction = UIAlertAction(title: "Ok", style: .Default) {
                action -> () in
                print("Ok")
                
                //alert.dismissViewControllerAnimated(true, completion:nil)
            }
            
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            alert.addAction(okAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            }
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count == 0 {
                 runAPI()
            } else {
                print ("API no refreshed")
            }
            
        }
    }
    // removeObserver: called when object is about to be deallocated
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func runAPI() {
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/es/rss/topmusicvideos/limit=50/json", completion: didLoadData)
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
    
    // cell identifier
    private struct storyboard {
        static let cell = "cell"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cell, forIndexPath: indexPath) as! MusicVideoTableViewCell // my custom cell

        // MusicVideoTableViewCell
        cell.video = videos[indexPath.row]
        

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
