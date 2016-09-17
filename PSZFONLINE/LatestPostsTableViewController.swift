//
//  LatestPostsTableViewController.swift
//  PSZFONLINE
//
//  Created by Péter Bártfai on 2016. 09. 17..
//  Copyright © 2016. Péter Bártfai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LatestPostsTableViewController: UITableViewController {
    var json : JSON = JSON.null

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hírek"
        
        get_posts(getposts: "http://pszfonline.hu/wp-json/wp/v2/posts/")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch self.json.type
        {
        case Type.array:
            return self.json.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //swift 3.0
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LatestPostsTableViewCell
        populateFields(cell: cell, index: indexPath.row)
    
        return cell
    }

    func populateFields(cell: LatestPostsTableViewCell, index: Int){
        
        //Make sure post title is a string
        guard let title = self.json[index]["title"]["rendered"].string else{
            cell.post_title!.text = "Loading..."
            return
        }
        
        // An action must always proceed the guard conditional
        cell.post_title!.text = title
        
        //Make sure post date is a string
        guard let date = self.json[index]["excerpt"]["rendered"].string else{
            cell.post_description!.text = "--"
            return
        }
        
        cell.post_description!.text = date
        
        /*
         * Set up Featured Image
         * Using guard, there's no need for nested if statements
         * to unwrap and check optionals
         */
        
        guard let image = self.json[index]["featured_image_thumbnail_url"].string ,
            image != "null"
            else{
                
                print("Image didn't load")
                return
        }

        if let url = URL(string:image){
            var data: Data?
            
            data = try? Data(contentsOf: url)
            
            if data != nil {
                
                cell.featured_image?.image = UIImage(data:data!)
                
            }
            
        }
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "subContentViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "SubContentViewController") as! SubContentViewController
        
        subContentsVC.json = self.json[indexPath.row];
        
        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }

    func get_posts(getposts : String){
        Alamofire.request(getposts).responseJSON { response in
            if let data = response.result.value {
                self.json = JSON(data)
                self.tableView.reloadData()
                
            }
            
            
        }
    }


}
