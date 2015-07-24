//
//  ViewController.swift
//  eQuate
//
//  Created by Avery Bentz on 2015-07-22.
//  Copyright (c) 2015 Avery Bentz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var myURLTextField: UITextField!
    @IBOutlet var WebView: UIWebView!
    
    //URL path that will get passed to WebView
    var URLPath = ""
    var mySavedURL = ""
    var myURL = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Prevent crash by setting URL to permanent value if it is blank before load
        if (NSUserDefaults.standardUserDefaults().objectForKey("savedURL") == nil){
            //Set URL
            myURL = "http://equatepos.com"
            NSUserDefaults.standardUserDefaults().setObject(myURL, forKey: "savedURL")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        let stringKey = NSUserDefaults.standardUserDefaults()
        mySavedURL = stringKey.stringForKey("savedURL")!
        
        //Change URLPath to savedURLLabel
        URLPath = mySavedURL
        
        //Update WebView
        self.loadAddressURL()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveURL(sender: AnyObject) {
        //If myURLTextField is not blank reset myURL
        if (myURLTextField.text != ""){
                //Create var that will hold the URL that the user provides via myURLTextField
                myURL = myURLTextField.text
            
                //Save URL to NSUserDefaults
            NSUserDefaults.standardUserDefaults().setObject(myURL, forKey: "savedURL")
            NSUserDefaults.standardUserDefaults().synchronize()
        
            //Change URLPath to existing URL
            URLPath = myURL
        
            //Refresh WebView
            self.loadAddressURL()
        }
        
            //If myURLTextField is blank, set default myURL to google.ca
        else{
            myURL = "http://equatepos.com"
        }
        
    }
    
    //Method that will load URL to WebView
    func loadAddressURL(){
        let requestURL = NSURL(string: URLPath)
        let request = NSURLRequest(URL: requestURL!)
        //Load request to WebView
        WebView.loadRequest(request)
        
    }
    
    //Back button clicked
    @IBAction func navigateBack(sender: AnyObject) {
        self.WebView.goBack()
    }
    
    //Print Me button clicked
    @IBAction func printMe(sender: AnyObject) {
        // 1
        let printController = UIPrintInteractionController.sharedPrintController()!
        // 2
        let printInfo = UIPrintInfo(dictionary:nil)!
        printInfo.outputType = UIPrintInfoOutputType.General
        printInfo.jobName = "print Job"
        printController.printInfo = printInfo
        
        // 3
        let formatter = UIMarkupTextPrintFormatter()
        formatter.contentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
        printController.printFormatter = WebView.viewPrintFormatter()
        
        // 4
        printController.presentAnimated(true, completionHandler: nil)
        
    }
}


