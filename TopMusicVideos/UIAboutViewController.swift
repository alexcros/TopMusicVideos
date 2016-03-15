//
//  UIAboutViewController.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 15/03/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit

class UIAboutViewController: UIViewController {

    @IBOutlet weak var aboutWebview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "about me"
        
        let url = NSURL(string: "http://alexcros.com")
        let requestObj = NSURLRequest(URL: url!)
        aboutWebview.loadRequest(requestObj)
        
        print("Webview loaded")
    }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


