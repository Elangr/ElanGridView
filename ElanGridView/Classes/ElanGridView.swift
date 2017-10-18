//
//  ElanGridView.swift
//  ElanCard
//
//  Created by Imrane EL HAMIANI on 09/27/2017.
//

import UIKit

public typealias GridViewConstructor = (_ contentView: ElanCard) -> Void

public class ElanGridView: UIScrollView {
    
    @IBInspectable var cellWidth: CGFloat = 0.0
    @IBInspectable var cellHeight: CGFloat = 0.0
    @IBInspectable var paddingLeft: CGFloat = 10.0
    @IBInspectable var paddingRight: CGFloat = 10.0
    @IBInspectable var paddingTop: CGFloat = 10.0
    @IBInspectable var paddingBottom: CGFloat = 10.0
    @IBInspectable var maxColumns: UInt = 1
        
    private var contentView: UIView? = nil
    
    private var nextRow: Int = 0
    private var nextColumn: Int = 0
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public convenience init(){
        self.init(frame: CGRect.zero)
    }

    private func setup(){
        self.contentView = UIView(frame: self.frame)
        self.addSubview(self.contentView!)
    }
    
    override open func layoutSubviews() {
        
        var width: CGFloat
        var height: CGFloat
        
        if self.cellWidth == 0.0 {
            width = self.frame.width
        } else {
            width = self.cellWidth
        }
        
        if self.cellHeight == 0.0 {
            height = self.frame.height
        } else {
            height = self.cellHeight
        }
        
       
        for cellCard: ElanCard in self.contentView?.subviews as! [ElanCard] {
            cellCard.cellSize = CGSize(width: width, height: height)
            cellCard.updateLayout()
        }
        
        
        var contentFrame:CGRect = (self.contentView?.frame)!
        
        if self.nextRow == 0 {
            contentFrame.size.width = width * CGFloat(self.nextColumn + 1)
        } else {
            contentFrame.size.width = width * CGFloat(self.maxColumns )
        }
        
        contentFrame.size.height = height * CGFloat(self.nextRow)
        self.contentView?.frame = contentFrame
        self.contentSize = contentFrame.size
        
        self.contentView?.frame = contentFrame
        self.contentSize = contentFrame.size
    }
    
    
    public func addCell(constructor: GridViewConstructor){
        
        let cellCard = ElanCard()
       
        cellCard.paddingTop = self.paddingTop
        cellCard.paddingBottom = self.paddingBottom
        cellCard.paddingLeft = self.paddingLeft
        cellCard.paddingRight = self.paddingRight
        
        cellCard.row = UInt(self.nextRow)
        cellCard.column = UInt(self.nextColumn)
       
        constructor(cellCard)
        self.contentView?.addSubview(cellCard)
        self.setNeedsLayout()
        
        if self.maxColumns == (self.nextColumn + 1) {
            self.nextColumn = 0
            self.nextRow += 1
        } else {
            self.nextColumn += 1
        }
        
    }
}
