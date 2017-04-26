//
//  StandardEngine.swift
//  Assignment4
//
//  Created by Weinberg, Corbett on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import Foundation

public class StandardEngine : EngineProtocol {
    static var engine: StandardEngine = StandardEngine(rows: 10, cols: 10)
    
    public var delegate: EngineDelegate?
    public var grid: GridProtocol
    public var refreshRate: Double
    public var refreshTimer: Timer?
    public var rows: Int
    public var cols: Int
    public func step() -> GridProtocol{
        return self.grid
    }
    
    init(rows: Int, cols: Int) {
        
        self.grid = Grid(rows, cols, cellInitializer: (row: 1, col: 1))
        //self.grid = Grid(rows, cols)
    }
}

/*
 which  implements the EngineProtocol method, implementing the Game Of Life rules as in Assignment 3.  
 
 Create a singleton of StandardEngine in a lazy manner.  
    That creates a grid of size 10x10 by default.  
 Whenever the grid is created or changed, notify the delegate with the delegate method 
 and publish the grid object using an NSNotification.
 */
