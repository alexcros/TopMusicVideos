//
//  MusicVideoTableViewController.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 05/03/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit

class MusicVideoTableViewController: UITableViewController /*,UISearchResultsUpdating */{

    
    var videos = [MusicVideo]()
    // search
    var filterSearch = [MusicVideo]()
    
    let resultSearchController = UISearchController(searchResultsController: nil) // nil: view the results in the same VC
    
    var limitVideos = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addObserver: call ReachStatusChanged selector:in appDelegate
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        // call function status
        reachabilityStatusChanged()
        
    }
    
    func preferredFontChange() {
        
        print("The preferred font has changed")
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
        // NC color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blueColor()]
        // NC title
        title = ("The spanish TOP \(limitVideos) Music Videos")
        
        //setup search controller
        resultSearchController.searchResultsUpdater = self // delegate
        
        definesPresentationContext = true // search not remind in the screen when change view
        
        resultSearchController.dimsBackgroundDuringPresentation = false // true: only search / false: search and you can select a video
        
        resultSearchController.searchBar.placeholder = "Search for Artist, name or rank"
        
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        /*
        case Default // currently UISearchBarStyleProminent
        case Prominent // used my Mail, Messages and Contacts
        case Minimal // used by Calendar, Notes and Music
        */
        
        // add searchBar to the tableView
        tableView.tableHeaderView = resultSearchController.searchBar
        
        
        
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
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    @IBAction func refreshMusicVideos(sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
        
        if resultSearchController.active {
            refreshControl?.attributedTitle = NSAttributedString(string: "No refresh allowed in search")
        }
        else
        {
             runAPI()
        }
        
    }
    
    
    func getAPICount() {
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICOUNT") != nil)
        {
            let sliderValue = NSUserDefaults.standardUserDefaults().objectForKey("APICOUNT") as! Int
            
            limitVideos = sliderValue
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDate = formatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    func runAPI() {
        
        getAPICount()
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/es/rss/topmusicvideos/limit=\(limitVideos)/json", completion: didLoadData)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if resultSearchController.active { //search active
            return filterSearch.count
        }
        // return the number of rows
        return videos.count 
    }
    
    // cell identifier
    private struct storyboard {
        static let cell = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cell, forIndexPath: indexPath) as! MusicVideoTableViewCell // my custom cell

        if resultSearchController.active { // search active
            cell.video = filterSearch[indexPath.row]
        }
        else
        {
            // MusicVideoTableViewCell
            cell.video = videos[indexPath.row]
        }
        
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

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier // musicDetail segue
        {   // set indexpath for wherever row selected
            if let indexpath = tableView.indexPathForSelectedRow {
                let video : MusicVideo
                
                if resultSearchController.active {
                    
                    video = filterSearch[indexpath.row] // search active
                    
                    
                } else {
                    
                    video = videos[indexpath.row] // set indexpath to array video

                }
            
                let detailViewController = segue.destinationViewController as! MusicVideoDetailViewController // segue to...
                detailViewController.videoArray = video
            }
        }
    }
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        searchController.searchBar.text!.lowercaseString //text to lowerCase
//        filterSearch(searchController.searchBar.text!) // take the info
//        
//    }
    func filterSearch(searchText: String){
        filterSearch = videos.filter { videos in // logic filter array
            return videos.artist.lowercaseString.containsString(searchText.lowercaseString) || videos.name.lowercaseString.containsString(searchText.lowercaseString) || "\(videos.rank)".lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
}
}