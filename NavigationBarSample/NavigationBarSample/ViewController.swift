//
//  ViewController.swift
//  NavigationBarSample
//
//  Created by JoyHwong on 24/03/2017.
//  Copyright © 2017 JoyHwong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func save(_ sender: AnyObject) {
        self.label.text = "Click Save"
    }

    @IBAction func add(_ sender: AnyObject) {
        self.label.text = "Click Add"
    }
    
}

