//
//  SubContentViewController.swift
//  PSZFONLINE
//
//  Created by Péter Bártfai on 2016. 09. 17..
//  Copyright © 2016. Péter Bártfai. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubContentViewController: UIViewController {
    var json : JSON = JSON.null
    
    @IBOutlet weak var post_title: UILabel!
    @IBOutlet weak var featured_image: UIImageView!
    @IBOutlet weak var post_content: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Make sure post title is a string
        guard let title = self.json["title"]["rendered"].string else{
            self.post_title!.text = "Loading..."
            return
        }
        
        // An action must always proceed the guard conditional
        self.post_title!.text = title
        
        //Make sure post date is a string
        
        if let content = self.json["content"]["rendered"].string {
            self.post_content!.loadHTMLString(content, baseURL:nil)
            return
        }
        

        
        /*
         * Set up Featured Image
         * Using guard, there's no need for nested if statements
         * to unwrap and check optionals
         */
        
        guard let image = self.json["featured_image_thumbnail_url"].string ,
            image != "null"
            else{
                
                print("Image didn't load")
                return
        }
        
        if let url = URL(string:image){
            var data: Data?
            
            data = try? Data(contentsOf: url)
            
            if data != nil {
                
                self.featured_image?.image = UIImage(data:data!)
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
