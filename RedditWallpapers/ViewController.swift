//
//  ViewController.swift
//  RedditWallpapers
//
//  Created by Danny Peng on 9/10/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SwiftyJSON
import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//Next Button
//    Description: Would have allowed user to see the next set of images but is imcomplete so it is a nifty button that scrolls you back to the top!
    
    @IBAction func Next(sender: AnyObject) {
        self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: .Top, animated: true)
//          print(self.address.count)
//        if imageArray.count >= 49 {
//            getImagesReddit()
//             print(self.address.count)
//        for i in 0...24 {
//            imageArray.removeLast()
//        }
//        }
    
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray = [UIImage(named:"reddit"), UIImage(named: "reddit2"), UIImage(named: "reddit3")]

    var nextButton = UIButton()
    
    var address = [NSURL()]
    
    var uid = String()
    
    var counter = ["", "", "", "", "", "", "", "" ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]//, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    
    // This is the base url we work with that connects us to 
    // other pages so we preserve it here and append to it when
    // we need to retrieve a new set of json.
    var connectingURL = "https://www.reddit.com/r/wallpapers/.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //PlaceHolders are set here for 25 coming images. First
        // four serve to inform the user of various disclaimers.
        for o in 3...29 {
            imageArray.insert(UIImage(named: "reddit-1"), atIndex: o)
        }
        getUID()
        getImagesReddit()
    }
    //Method: getImagesReddit()
    //Description: This method handles the json code and incorportates the use of SwiftyJSON. This method also calls download images which actually downloads them into an image array for our Collection View. I attempted to do a recursive call on this function to get image stream but this caused it to crash due to memory. My thoughts are now to save the urls with this recursive call and then when next is hit then in an array of url addresses I would load them up. That part is incomplete.
    func getImagesReddit() {
        let url = NSURL(string: connectingURL)
        var flag = false
        var nextSet = 25
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(NSURLRequest(URL: url!)) { (data, response, error) in
            if(error == nil) {
                let swiftyJSON = JSON(data: data!)
                for i in 0...24 {
                    
                    let entryArray = swiftyJSON["data"]["children"].arrayValue
                    let secondArray = entryArray[i]
                    let thirdArray = secondArray["data"]["preview"]["images"].arrayValue
                    
                    if thirdArray.count != 0 {
                        
                        let url = thirdArray[0]["source"]["url"].string!
                        
                        let picArray = url
                        let imageURL = NSURL(string: picArray)
                        
                        self.downloadImages(imageURL!)
                        
                        /* if let imageData = NSData(contentsOfURL: imageURL!){
                         print(imageURL)
                         
                         self.address.append(imageURL!)
                         self.imageArray.append(UIImage(data: imageData)!)
                         */
                        if flag == false {
                            self.connectingURL.appendContentsOf(self.extendJSON(nextSet, iDAfter: self.uid))
                            print(self.connectingURL)
                            flag = true
//                            if self.nextload == true{
//                                self.getImagesReddit()
//                            }
                        }
                        var offset = self.imageArray.count - 4
                        if offset == nextSet {
                            print(self.connectingURL)
                            self.getImagesReddit()
                            
//                            for i in offset...offset + 25 {
//                                self.counter.append(String(i))
//                                print("THIS WORKED\(self.counter.count)")
//                            }
                        }
                    }
                    else {
    self.imageArray.insert(UIImage(named:"ImageUnavailable" ), atIndex: i)
                    }
                }
            }
        }
        task.resume()
    }
//    Method: downloadImages()
//    Description: Takes in the url and download the image and stores it into the image array that will be shown in the collection view.
    func downloadImages(imageURL: NSURL) {
        
        if let imageData = NSData(contentsOfURL: imageURL){
            print(imageURL)
            
            self.address.append(imageURL)
            //self.imageArray.append(UIImage(data: imageData)!)
            self.imageArray.insert(UIImage(data: imageData)!, atIndex: 0 )
        }
    }
    

//    Method: getUID()
//    Description: Within the JSON, there contains a key called after that contains a unique value. This method gets that unique value so it can later be appended into the url to get more images.
    func getUID(){
        let url = NSURL(string: connectingURL)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(NSURLRequest(URL: url!)) { (data, response, error) in
            if(error == nil) {
                let swiftyJSON = JSON(data: data!)
                
                let entryArray = swiftyJSON["data"]["after"].string!
                
                self.uid = entryArray
            }
        }
        task.resume()
    }
    
//    Method: extendJSON()
//    Description: This method builds the extension for the url to get the next page. This is coupled with the unique value from getUID and return to be appended.
    
    func extendJSON(index: Int, iDAfter: String) -> String {
        self.getUID()
        var newJSON = "?count="
        newJSON.appendContentsOf(String(index))
        newJSON.appendContentsOf("&after=")
        newJSON.appendContentsOf(uid)
        return newJSON
    }
    
    //The below functions belong to the collection view delegate and set up our collection view. 
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.counter.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            "cell", forIndexPath: indexPath) as! CollectionViewCell
        print(imageArray.count)
        print("This is a saved url count \(self.address.count)")
        
        cell.imageView?.image = self.imageArray[indexPath.row]
        cell.titleLabel?.text = self.counter[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage" {
            let indexPaths = self.collectionView.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! NextViewController
            
            vc.image = self.imageArray[indexPath.row]!
            vc.title = self.counter[indexPath.row]
        }
    }
}

