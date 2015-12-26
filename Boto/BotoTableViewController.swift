//
//  BotoTableViewController.swift
//  Boto
//
//  Created by Joseph Christian Noel on 6/12/2015.
//  Copyright © 2015 Joseph Christian Noel. All rights reserved.
//

import UIKit

class BotoTableViewController: UITableViewController {
    
    @IBOutlet weak var roxasVoteLabel: UILabel!
    @IBOutlet weak var binayVoteLabel: UILabel!
    @IBOutlet weak var duterteVoteLabel: UILabel!
    @IBOutlet weak var poeVoteLabel: UILabel!
    
    @IBOutlet weak var roxasLoadingIcon: UIActivityIndicatorView!
    @IBOutlet weak var poeLoadingIcon: UIActivityIndicatorView!
    @IBOutlet weak var binayLoadingIcon: UIActivityIndicatorView!
    @IBOutlet weak var duterteLoadingIcon: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        updateStandings()
    }
    
    func updateStandings() {
        let uid = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        let url: NSURL = NSURL(string: "http://localhost:3000/votes/get_standings?uid=" + uid)!
        
        let request: NSURLRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            do {
                if (data == nil) {
                    return
                }
                
                let response: NSDictionary
                try response = NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary;
                
                NSLog("Respone: " + String(response))
                
                if response["status"] != nil && String(response["status"]!) == "success" {
                    dispatch_async(dispatch_get_main_queue(), {
                        let standings = response["standings"] as! Dictionary<String, Int>
                        
                        if standings["duterte"] != nil {
                            self.duterteVoteLabel.text = String(standings["duterte"]!)
                        } else {
                            self.duterteVoteLabel.text = "0"
                        }
                        
                        if standings["binay"] != nil {
                            self.binayVoteLabel.text = String(standings["binay"]!)
                        } else {
                            self.binayVoteLabel.text = "0"
                        }
                        
                        if standings["roxas"] != nil {
                            self.roxasVoteLabel.text = String(standings["roxas"]!)
                        } else {
                            self.roxasVoteLabel.text = "0"
                        }
                        
                        if standings["poe"] != nil {
                            self.poeVoteLabel.text = String(standings["poe"]!)
                        } else {
                            self.poeVoteLabel.text = "0"
                        }
                        
                        var row = -1
                        switch response["my_vote"] as! String {
                        case "row":
                            row = 0
                        case "poe":
                            row = 1
                        case "binay":
                            row = 2
                        case "duterte":
                            row = 3
                        default:
                            NSLog("No my_vote")
                            return
                        }
                        
                        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0))
                        cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                        
                        self.tableView.reloadData();
                    });
                    
                } else {
                    NSLog("failure")
                }
                
            } catch {
                NSLog("catch")
            }
            
            
            
        });
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return 1
    //}

    //override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 0
    //}
    
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        for var s = 0; s < tableView.numberOfSections; s++ {
            for var r = 0; r < tableView.numberOfRowsInSection(s); r++ {
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: r, inSection: s))
                cell!.accessoryType = .None
            }
        }
        
        var vote: String?
        
        switch indexPath.row {
        case 0:
            roxasLoadingIcon.hidden = false
            roxasLoadingIcon.startAnimating()
            vote = "roxas"
        case 1:
            poeLoadingIcon.hidden = false
            poeLoadingIcon.startAnimating()
            vote = "poe"
        case 2:
            binayLoadingIcon.hidden = false
            binayLoadingIcon.startAnimating()
            vote = "binay"
        case 3:
            duterteLoadingIcon.hidden = false
            duterteLoadingIcon.startAnimating()
            vote = "duterte"
        default:
            NSLog("Error indexPath: " + String(indexPath.row))
            return
        }
        
        let uid = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        var request: NSMutableURLRequest? = nil
        
        do {
            let url: NSURL = NSURL(string: "http://localhost:3000/votes/vote")!
            request = NSMutableURLRequest(URL: url)
            request!.HTTPMethod = "POST"
     
            let params = ["uid":uid, "vote":vote!] as Dictionary<String, String>
            try request!.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: [])
            request!.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request!.addValue("application/json", forHTTPHeaderField: "Accept")
        } catch {
            NSLog("Error")
            return
        }
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request!, completionHandler: {(data, response, error) in
            do {
                if (data == nil) {
                    return
                }
                
                NSLog("foo")
                let response: NSDictionary
                NSLog("bar " + String(data))
                try response = NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary;
                NSLog("baz")
                if response["status"] != nil && String(response["status"]!) == "success" {
                    dispatch_async(dispatch_get_main_queue(), {
                        switch vote! {
                        case "roxas":
                            self.roxasLoadingIcon.stopAnimating()
                        case "poe":
                            self.poeLoadingIcon.stopAnimating()
                        case "binay":
                            self.binayLoadingIcon.stopAnimating()
                        case "duterte":
                            self.duterteLoadingIcon.stopAnimating()
                        default:
                            NSLog("Error indexPath: " + String(indexPath.row))
                            return
                        }
                    
                        let cell = tableView.cellForRowAtIndexPath(indexPath)
                        cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                        
                        self.updateStandings()
                    });
                    
                }
            } catch {
                NSLog("whAT")
            }
            
            
        })
            
        task.resume()
    }
}
