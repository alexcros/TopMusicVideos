//
//  SettingsTableViewController.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 06/03/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    // MARK: IBOutlet
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedbackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchId: UISwitch!
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var APICount: UILabel!
    
    @IBOutlet weak var sliderCount: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // font changes observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        tableView.alwaysBounceVertical = false
        
        title = "settings"
        
        // switch
        touchId.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        //slider: avoids message "fatal error: unexpectedly found nil while unwrapping an Optional value" if app is deleted when running
      if (NSUserDefaults.standardUserDefaults().objectForKey("APICOUNT") != nil)
        {
            let sliderValue = NSUserDefaults.standardUserDefaults().objectForKey("APICOUNT") as! Int // casting sliderValue from anyObject to INT
            APICount.text = "\(sliderValue)"
            sliderCount.value = Float(sliderValue) // cast int to float
        }
      else // default slider value
      {
            sliderCount.value = 10.0
            APICount.text = ("\(Int(sliderCount.value))")
        }
        
    }
    
   // MARK: - IBActions
    
    
    @IBAction func valueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCount.value), forKey: "APICOUNT")
        APICount.text = ("\(Int(sliderCount.value))")
    }
    
    @IBAction func touchIDSecurity(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchId.on { //true
            defaults.setBool(touchId.on, forKey: "SecSetting")
            print("touchID on")
        }
        else { // false
            defaults.setBool(false, forKey: "SecSetting")
            print("touchID off")
        }
    }
    
    // change dinamically
    func preferredFontChange() {
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // select the row feedback
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            }
            else {
                // no mail account setup on phone
                mailAlert()
                
            }
            // deselect highlighted row at the end
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        }
    }
    
    func mailAlert() {
        
        let alertController : UIAlertController = UIAlertController(title: "Alert", message: "No e-mail account setup for phone", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            // do something
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    // mail setup
    func configureMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController() //instance
        mailComposeVC.mailComposeDelegate = self //method belongs to protocol
        mailComposeVC.setToRecipients(["info@alexcros.com"])
        mailComposeVC.setSubject("TopMusicVideos Feedback")
        mailComposeVC.setMessageBody("Hi Alex,\n\nI would like to share...\n", isHTML: false)
        return mailComposeVC
    }
    // protocol implemented
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue: print("Mail Cancelled")
        case MFMailComposeResultSaved.rawValue: print("Mail saved")
        case MFMailComposeResultSent.rawValue: print("Mail sent")
        case MFMailComposeResultFailed.rawValue: print("Mail failed")
        default:
            print("Mail error unknown")
        }
        // MFMailComposeVC screen away
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: removeObserver: called when object is about to be deallocated
    deinit {
        // font observer
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

}
