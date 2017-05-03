//
//  SimulationViewController.swift
//  Assignment4
//
//  Created by Van Simmons on 1/15/17.
//  Modified by Corbett Weinberg 4/17/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController , GridViewDataSource, EngineDelegate{

    @IBOutlet weak var gridView: XView!
    //@IBOutlet weak var sizeStepper: UIStepper!
    @IBAction func resetButton(_ sender: UIButton) {
        
    }
    
    var engine: StandardEngine!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = gridView.gridSize
        engine = StandardEngine(rows: size, cols: size)
        engine.delegate = self
        gridView.gridDataSource = self
        
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(
            forName: name,
            object: nil,
            queue: nil) { (n) in
                self.gridView.gridSize = self.engine.grid.size.rows
                //self.gridView.gridSize = StandardEngine.engine.grid.size.rows
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
    
    @IBAction func stepNext(_ sender: Any) {
        //let rows = StandardEngine.engine.rows
        //engine.grid = Grid(Int(rows), Int(rows))
        engine.grid = engine.step()
        gridView.setNeedsDisplay()
    }
 
    //MARK: Stepper Event Handling
    @IBAction func step(_ sender: UIStepper) {
        engine.grid = Grid(Int(sender.value), Int(sender.value))
        gridView.gridSize = Int(sender.value)
        gridView.setNeedsDisplay()
    }
}

