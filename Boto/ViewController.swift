//
//  ViewController.swift
//  Boto
//
//  Created by Joseph Christian Noel on 5/12/2015.
//  Copyright © 2015 Joseph Christian Noel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var roxasVoteLabel: UILabel!
    @IBOutlet weak var poeVoteLabel: UILabel!
    @IBOutlet weak var binayVoteLabel: UILabel!
    @IBOutlet weak var duterteVoteLabel: UILabel!
    
    @IBOutlet weak var roxasImageView: UIImageView!
    @IBOutlet weak var poeImageView: UIImageView!
    @IBOutlet weak var binayImageView: UIImageView!
    @IBOutlet weak var duterteImageView: UIImageView!
    
    @IBOutlet weak var roxasBackgroundView: UIView!
    @IBOutlet weak var poeBackgroundView: UIView!
    @IBOutlet weak var binayBackgroundView: UIView!
    @IBOutlet weak var duterteBackgroundView: UIView!
    
    @IBOutlet var roxasGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func voteRoxas(sender: AnyObject) {
        roxasBackgroundView.alpha = 0.2
        poeBackgroundView.alpha = 0
        binayBackgroundView.alpha = 0
        duterteBackgroundView.alpha = 0
    }
    
    @IBAction func voteRoxas2(sender: AnyObject) {
        roxasBackgroundView.alpha = 0.2
        poeBackgroundView.alpha = 0
        binayBackgroundView.alpha = 0
        duterteBackgroundView.alpha = 0
    }
    
    @IBAction func votePoe(sender: AnyObject) {
        roxasBackgroundView.alpha = 0
        poeBackgroundView.alpha = 0.2
        binayBackgroundView.alpha = 0
        duterteBackgroundView.alpha = 0
    }
    
    @IBAction func voteBinay(sender: AnyObject) {
        roxasBackgroundView.alpha = 0
        poeBackgroundView.alpha = 0
        binayBackgroundView.alpha = 0.2
        duterteBackgroundView.alpha = 0
    }
    
    @IBAction func voteDuterte(sender: AnyObject) {
        roxasBackgroundView.alpha = 0
        poeBackgroundView.alpha = 0
        binayBackgroundView.alpha = 0
        duterteBackgroundView.alpha = 0.2
    }
}

