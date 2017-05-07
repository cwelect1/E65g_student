//
//  SimulationView2Controller.swift
//  Assignment4
//
//  Created by Weinberg, Corbett on 5/4/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//


import UIKit

class SimulationViewController: UIViewController , GridViewDataSource, EngineDelegate{
    
    @IBOutlet weak var gridView: XView!
    
    var engine: StandardEngine!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine = StandardEngine.engine
        engine.delegate = self
        gridView.gridDataSource = self
        
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(
            forName: name,
            object: nil,
            queue: nil) { (n) in
                self.gridView.gridSize = self.engine.grid.size.rows
                self.gridView.gridDataSource = self
                self.gridView.setNeedsDisplay()
        }
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        self.gridView.setNeedsDisplay()
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return engine.grid[row,col] }
        set { engine.grid[row,col] = newValue }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func step(_ sender: UIButton) {
        engine.grid = engine.step()
        gridView.setNeedsDisplay()
    }
}
