//
//  ElanGridView.swift
//  ElanCard
//
//  Created by Imrane EL HAMIANI on 09/27/2017.
//

import UIKit

public typealias GridViewConstructor = (_ contentView: ElanCard) -> Void

 @objc public protocol ElanGridViewDelegate: class{
    @objc optional func onTapCard(_ elanCard: ElanCard)
    @objc optional func onLongPressCard(_ elanCard: ElanCard)
    @objc optional func selectedCards(_ selectedCards: [ElanIndex] )

}

public class ElanGridView: UIScrollView {
    
    @IBInspectable public var cellWidth: CGFloat = 0.0
    @IBInspectable public var cellHeight: CGFloat = 0.0
    @IBInspectable public var paddingLeft: CGFloat = 10.0
    @IBInspectable public var paddingRight: CGFloat = 10.0
    @IBInspectable public var paddingTop: CGFloat = 10.0
    @IBInspectable public var paddingBottom: CGFloat = 10.0
    @IBInspectable public var maxColumns: UInt = 1
    
    @IBInspectable public var allowsMultipleSelection: Bool = false
    @IBInspectable public var selectedColor: UIColor =  UIColor(rgb: 0x0095ff)
    
    private var contentView: UIView? = nil
    
    private var nextRow: Int = 0
    private var nextColumn: Int = 0
    
    private var isSelectionOn: Bool = false
    
    private var selectedCards = [ElanIndex]()
    
    public weak var elanGridViewDelegate: ElanGridViewDelegate?
    
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
        
        cellCard.selectionColor = self.selectedColor
        
        cellCard.indexPath = ElanIndex(row: self.nextRow, column: self.nextColumn)
        
        //Add Tap event
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTapCard(_:)))
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.onLongPressCard(_:)))
        cellCard.addGestureRecognizer(tapGesture)
        cellCard.addGestureRecognizer(longTapGesture)
        
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
    
    @objc func onTapCard(_ sender:UITapGestureRecognizer){
        
        if elanGridViewDelegate != nil {
            let cellCard = sender.view as! ElanCard
            
            if self.allowsMultipleSelection && self.isSelectionOn {
                cellCard.updateSelectionState()
                if cellCard.isSelected {
                    self.selectedCards.append(cellCard.indexPath)
                }else{
                    self.selectedCards =  self.selectedCards.filter { $0 != cellCard.indexPath }
                }
                elanGridViewDelegate?.selectedCards!(self.selectedCards)
            }else {
                elanGridViewDelegate?.onTapCard!(cellCard)
            }
            if self.selectedCards.count == 0 {
                self.isSelectionOn = false
            }
        }
    }
    
    @objc func onLongPressCard(_ sender:UITapGestureRecognizer){
        if sender.state == .ended {
            if elanGridViewDelegate != nil {
                let cellCard = sender.view as! ElanCard
                
                if self.allowsMultipleSelection  && !self.isSelectionOn {
                    
                    self.isSelectionOn = true
                    
                    self.onTapCard(sender)
                    
                } else if self.allowsMultipleSelection  && self.isSelectionOn {
                    
                    self.onTapCard(sender)
                    
                } else {
                    
                    elanGridViewDelegate?.onLongPressCard!(cellCard)
                    
                }
            }
        }
    }
}

