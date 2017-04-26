//
//  EngineProtocol.swift
//  Assignment4
//
//  Created by Weinberg, Corbett on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//
import Foundation

public protocol EngineProtocol {
    var delegate: EngineDelegate? { get set }
    var grid: GridProtocol { get }
    var refreshRate: Double { get set }
    var refreshTimer: Timer? {get set}
    var rows: Int {get set}
    var cols: Int {get set}
    func step() -> GridProtocol
    //init(rows: Int, cols: Int)
}

/*
 a var delegate of type EngineDelegate
 a var grid of type GridProtocol (gettable only)
 a var refreshRate of type Double defaulting to zero
 a var refreshTimer of type NSTimer
 two vars rows and cols with no defaults
 an initializer taking rows and cols
 a func step()-> an object of type GridProtocol*/
