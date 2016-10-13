//
//  NextViewController.swift
//  RedditWallpapers
//
//  Created by Danny Peng on 9/10/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//
import SwiftyJSON
import UIKit
import Social

class NextViewController: UIViewController {

    @IBAction func ShareToTwitter(sender: AnyObject) {
        let tvc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        tvc.addImage(image)
        presentViewController(tvc, animated: true, completion: nil)
        
    }
    @IBAction func ShareToFacebook(sender: AnyObject) {
        let fvc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        fvc.addImage(image)
        presentViewController(fvc, animated: true, completion: nil)
        
    }
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func Save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
    }

    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = self.image

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
