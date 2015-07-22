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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let stringKey = NSUserDefaults.standardUserDefaults()
        if let mySavedURL = stringKey.stringForKey("savedURL"){
            
        }
        
        //Change URLPath to savedURLLabel
        URLPath = mySavedURL
        
        //Update WebView
        self.loadAddressURL()
        
        /*
        //Set URL
        //URL that will open in Chrome
        var openInChromeURL:NSURL = NSURL(string: "chromes://google.ca" + (savedURLLabel.text)!)!
        //URL that will open in Safari
        var openInSafariURL:NSURL = NSURL(string: "https://" + (savedURLLabel.text)!)!
        
        /*//Check if chrome is installed
        if(UIApplication.sharedApplication().canOpenURL(openInChromeURL)){
        UIApplication.sharedApplication().openURL(openInChromeURL)
        }
        else{
        UIApplication.sharedApplication().openURL(openInSafariURL)
        @IBOutlet weak var WebView: UIWebView!
        @IBOutlet weak var myWebView: UIWebView!
        }*/
        //Open in Chrome
        UIApplication.sharedApplication().openURL(openInChromeURL)
        @IBOutlet var WebView: UIWebView!
        
        
        //Check if you can open URL in chrome
        var MyOpenInChromeController:OpenInChromeController = OpenInChromeController()
        if (OpenInChromeController.isChromeInstalled(MyOpenInChromeController)() == true){
        println("Can open with chrome")
        MyOpenInChromeController.openInChrome(NSURL(string:(savedURLLabel.text)!))
        }
        else{
        println("Will not open with chrome")
        }
        */
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveURL(sender: AnyObject) {
        //Create var that will hold the URL that the user provides via myURLTextField
        let myURL = myURLTextField.text
        //Save URL to NSUserDefaults
        NSUserDefaults.standardUserDefaults().setObject(myURL, forKey: "savedURL")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        //Change URLPath to existing URL
        URLPath = myURL
        
        /*
        //Refresh label text via reloadME
        //self.reloadMe()
        */
        //Refresh WebView
        self.loadAddressURL()
        
    }
    
    /*
    //Method that will get calld to reload savedURLLabel
    func reloadMe(){
    
    let stringKey = NSUserDefaults.standardUserDefaults()
    savedURLLabel.text = stringKey.stringForKey("savedURL")
    }
    */
    
    //Method that will load URL to WebView
    func loadAddressURL(){
        let requestURL = NSURL(string: URLPath)
        let request = NSURLRequest(URL: requestURL!)
        //Load request to WebView
        WebView.loadRequest(request)
        
    }
    
    @IBAction func navigateBack(sender: AnyObject) {
        self.WebView.goBack()
    }
    
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


