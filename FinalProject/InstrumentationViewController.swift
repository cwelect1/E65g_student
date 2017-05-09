//
//  InstrumentationViewController.swift
//  FinalProject
//
//  Created by Weinberg, Corbett on 5/8/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//
//  ************ No Attribution required for the icons ***************
//
//
/*
 Notes for me and you...
 A few things I'd love feedback on if you'd be so kind, even though some of it is kind of explained in discussion.
 - My grid doesn't change size if I change the row/col size on the instrumentation panel before 1st visiting Simulation.
 - How do I fix that?
 - How do I vary between Landscape and portrait for (wR hR)? I tried keeping my gridView at .9 x height or width (neither worked)
 - Mentioned in discussion - Statistics don't update until I hit the Sim tab first.
 - If I update refreshRate wile refresh is on (by sliding the slider), it goes whack y and refreshes too fast.
 - I'm getting a Build time error (IB Designables - Failed to render and update auto layout status for SimulationView...
 In the crash file it indicates...
 "fatal error: unexpectedly found nil while unwrapping an Optional value
 1   edu.harvard.Assignment4       	0x00000002169a744f _TFFFC11Assignment45XView9drawOvalsFVSC6CGRectT_U_FSiT_U_FSiT_ + 303 (XView.swift:55)
 "
 Figured this sucker out... I had "gridDataSource" set to force unwrap instead of checking if it was nil. My storyboard wouldn't appear because of this (or it appeared, but Simulator was blank).
 
 */

import UIKit
import Foundation
var sectionHeaders = [
    "One", "Two", "Three", "Four", "Five", "Six"
]

var data = [
    [
        "Apple",
        "Banana",
        "Cherry",
        "Date",
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry",
        "Date"
    ],
    [
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry",
        "Date",
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry",
        "Date",
        "Kiwi",
        "Apple",
        "Banana"
    ],
    [
        "Cherry",
        "Date",
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry",
        "Date",
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry",
        "Date",
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry",
        "Date",
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry"
    ],
    [
        "Date",
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry",
        "Date",
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry",
        "Date",
        "Kiwi",
        "Apple",
        "Banana",
        "Cherry",
        "Date",
        "Kiwi",
        "Blueberry"
    ]
]

class InstrumentationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let finalProjectURL = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"
    var refreshRate: Double = 5.0
    var jsonArray : NSArray = []
    @IBOutlet weak var refreshLabel: UILabel!
    @IBOutlet weak var rowsTextBox: UITextField!
    @IBOutlet weak var colsTextBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        self.fetchshit()
    }
    
    @IBAction func rowsStepper(_ sender: UIStepper) {
        
        rowsTextBox.text = Int(sender.value).description
        StandardEngine.engine.rows = Int(sender.value)
    }
    @IBAction func colsStepper(_ sender: UIStepper) {
        
        colsTextBox.text = Int(sender.value).description
        StandardEngine.engine.cols = Int(sender.value)
    }
    
    @IBAction func sldRate(_ sender: UISlider) {
        let currentValue = Double(sender.value)/10;
        let roundedValue = round(currentValue / 0.1) * 0.1;
        refreshLabel.text = "(\(roundedValue) sec)"
        refreshRate = roundedValue
    }
    
    @IBOutlet weak var lblRate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func refreshOnOff(_ sender: UISwitch) {
        if sender.isOn {
            StandardEngine.engine.refreshRate = refreshRate
        } else {
            StandardEngine.engine.refreshRate = 0.0
        }
    }
    
    @IBAction func fetch(_ sender: UIButton) {
        let fetcher = Fetcher()
        fetcher.fetchJSON(url: URL(string:finalProjectURL)!) { (json: Any?, message: String?) in
            guard message == nil else {
                print(message ?? "nil")
                return
            }
            guard let json = json else {
                print("no json")
                return
            }
            print(json)
            self.jsonArray = json as! NSArray
            let jsonDictionary = self.jsonArray[0] as! NSDictionary
            let jsonTitle = jsonDictionary["title"] as! String
            let jsonContents = jsonDictionary["contents"] as! [[Int]]
            print (jsonTitle, jsonContents)
            OperationQueue.main.addOperation {
                //self.textView.text = resultString
            }
        }
    }
    func fetchshit() {
        let fetcher = Fetcher()
        fetcher.fetchJSON(url: URL(string:finalProjectURL)!) { (json: Any?, message: String?) in
            guard message == nil else {
                print(message ?? "nil")
                return
            }
            guard let json = json else {
                print("no json")
                return
            }
            print(json)
            self.jsonArray = json as! NSArray
            let jsonDictionary = self.jsonArray[0] as! NSDictionary
            let jsonTitle = jsonDictionary["title"] as! String
            let jsonContents = jsonDictionary["contents"] as! [[Int]]
            print (jsonTitle, jsonContents)
            OperationQueue.main.addOperation {
                //self.textView.text = resultString
            }
        }
    }
 
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return data[section].count
        return (jsonArray[section] as AnyObject).count
    }
    /*
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "basic"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let label = cell.contentView.subviews.first as! UILabel
        label.text = data[indexPath.section][indexPath.item]
        
        return cell
    }
    */
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "basic"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let label = cell.contentView.subviews.first as! UILabel
        //label.text = data[indexPath.section][indexPath.item]
        let jsonDictionary = jsonArray[indexPath.section] as! NSDictionary
        let jsonTitle = jsonDictionary["title"] as! String
        label.text = jsonTitle
        
        return cell
    }
    /*
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
 */
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var newData = data[0]
            newData.remove(at: indexPath.row)
            data[indexPath.row] = newData
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        if let indexPath = indexPath {
            let fruitValue = data[indexPath.section][indexPath.row]
            if let vc = segue.destination as? GridEditorViewController {
                vc.fruitValue = fruitValue
                vc.saveClosure = { newValue in
                    data[indexPath.section][indexPath.row] = newValue
                    self.tableView.reloadData()
                }
            }
        }
    }
}
