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
// Security
import LocalAuthentication

class MusicVideoDetailViewController: UIViewController {

    var videoArray : MusicVideo!
    
    //var sec:Bool = false
    
    var securitySwitch:Bool = false
    
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
        
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        switch securitySwitch {
        case true: // is ON?
            touchIDCheck()
        default:
            shareMedia()
        }
    
    }
    
    func touchIDCheck(){
        // create alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert )
        alert.addAction(UIAlertAction(title: "continue", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // create the local authentication context
        let context = LAContext()
        var touchIdError : NSError?
        let reasonString = "Touch-id authentication is needed to share info on Social Media"
        
        // touchID in device? check if we can access local device authentication
        //if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIdError) {
            // check what the authentication response was
            //context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) Void -> in
                // reply: execute block login in private thread within the FW
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error:&touchIdError ) {
            
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
        
                if success {
                    // User authenticated using Local Device Authentication Succesfully!
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in self.shareMedia()//always in dispatch_async
                        
                }
                } else {
                        
                        alert.title = "UnSuccesful!"
                        
                        switch LAError(rawValue: policyError!.code)! {
                            
                        case .AppCancel:
                            alert.message = "Authentication was cancelled by application"
                        case .AuthenticationFailed: alert.message = "The user failed to provide valid credentials"
                        case .PasscodeNotSet:
                            alert.message = "Passcode is not set on the device"
                        case .SystemCancel:
                            alert.message = "Authentication was cancelled by the system"
                        case .TouchIDLockout:
                            alert.message = "Too many failed atempts"
                        case .UserCancel:
                            alert.message = "You cancelled the request"
                        case .UserFallback:
                            alert.message = "Pasword not accepted, must use Touch-ID"
                        default:
                            alert.message = "Unable to authenticate!"
                        
                        }
                    
                    // show the alert
                    dispatch_async(dispatch_get_main_queue()) { [unowned self]
                        in self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    
                    }
        })
        
        } else {
            // unable to access local device authentication
            
            // set error title
            alert.title = "Error"
            
            // set the error alert message with more information
            switch LAError(rawValue: touchIdError!.code) {
//                // LAError framework
//            case .TouchIdNotEnrolled:
//                alert.message = "Touch ID is not enrolled!"
//            case .TouchIdNotAvailable:
//                alert.message = "Touch ID is not available in the device!"
//            case .PasscodeNotSet:
//                alert.message = "Passcode has not been set!"
//            case .InvalidContext:
//                alert.message = "The context is invalid!"
            default:
                alert.message = "Local authentication not available"
            }
            
            // show the alert
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
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
