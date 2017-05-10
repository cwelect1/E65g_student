//
//  GridEditorViewController.swift
//  FinalProject
//
//  Created by Weinberg, Corbett on 5/8/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class GridEditorViewController: UIViewController, GridViewDataSource {
    
    //var engine: StandardEngine!
    var grid: Grid!
    var timer: Timer?
    @IBOutlet weak var gridView: XView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        grid = Grid(5, 5)
        _ = Grid.gliderInitializer(pos: (0,1))
        //engine = StandardEngine(rows: 5, cols: 5)
        //engine.cols = 5
        //engine.rows = 5
        //engine.grid = Grid(engine.rows, engine.cols)
        //engine.delegate = self
        //gridView.gridDataSource = self
        
        /*let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(
            forName: name,
            object: nil,
            queue: nil) { (n) in
                self.gridView.gridSize = self.engine.grid.size.rows
                self.gridView.gridDataSource = self
                self.gridView.setNeedsDisplay()
        }*/
        
        self.gridView.gridSize = self.grid.size.rows
        self.gridView.gridDataSource = self
        self.gridView.setNeedsDisplay()
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        self.gridView.setNeedsDisplay()
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return grid[row,col] }
        set { grid[row,col] = newValue }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    var fruitValue: String?
    var saveClosure: ((String) -> Void)?
    
    @IBOutlet weak var fruitValueTextField: UITextField!
    
    @IBAction func save(_ sender: UIButton) {
        if let newValue = fruitValueTextField.text,
            let saveClosure = saveClosure {
            saveClosure(newValue)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
