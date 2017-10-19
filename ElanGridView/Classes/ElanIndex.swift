//
//  IndexPath+ElanGridView.swift
//  ElanGridView
//
//  Created by Imrane EL HAMIANI on 10/19/17.
//

import Foundation


public class ElanIndex: NSObject {
    
    public var row: Int = 0
    
    public var column: Int = 0
    
    public var tag: Any?

    public static var zero: ElanIndex {
        get{
            return ElanIndex(row: 0, column: 0)
        }
    }

    convenience init(row: Int, column: Int) {
        self.init()
        self.row = row
        self.column = column
    }
    
    public override var description: String{
        return " {row: \(self.row), column: \(self.column), id: \(self.tag)}"
    }
}

extension ElanIndex: Comparable {
    public static func <(lhs: ElanIndex, rhs: ElanIndex) -> Bool {
        return lhs.column < rhs.column && lhs.row < rhs.row
    }
    
    public static func ==(lhs: ElanIndex, rhs: ElanIndex) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
    }
}

