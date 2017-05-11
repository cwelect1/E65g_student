//
//  GridEditorViewController.swift
//  FinalProject
//
//  Created by Weinberg, Corbett on 5/8/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class GridEditorViewController: UIViewController, GridViewDataSource {
    
    var grid: Grid!
    var gridSize: Int = 0
    var pos:[[Int]] = []
    var timer: Timer?
    @IBOutlet weak var gridView: XView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        grid = Grid(gridSize, gridSize)
        
        self.gridView.gridSize = self.grid.size.rows
        let newGrid = grid.setConfig(pos)
        grid = newGrid
        
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
