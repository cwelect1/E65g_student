//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Corbett Weinberg on 4/17/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var aliveLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(
            forName: name,
            object: nil,
            queue: nil) {(n) in
                let engObj = n.userInfo?["engine"] as? Grid
                let counts:[String:String] = (engObj?.getCounts())!
                //let counts:[String:String] = StandardEngine.engine.grid.getCounts()
                self.emptyLabel.text = counts["empty"]
                self.bornLabel.text = counts["born"]
                self.aliveLabel.text = counts["alive"]
                self.diedLabel.text = counts["died"]
                self.diedLabel.setNeedsDisplay()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

