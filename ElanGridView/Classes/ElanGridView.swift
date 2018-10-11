//
//  ElanGridView.swift
//  ElanCard
//
//  Created by Imrane EL HAMIANI on 09/27/2017.
//

import UIKit

public typealias NewElanCardConstructor = (_ card: ElanCard) -> Void

/// ElangGridView Event Delegate
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
    
    public weak var elanGridViewDelegate: ElanGridViewDelegate?

    private var contentView: UIView? = nil
    private var nextRow: Int = 0
    private var nextColumn: Int = 0
    private var isSelectionOn: Bool = false
    private var selectedCards = [ElanIndex]()
    
    
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
        
        // update cell layout
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
    }
    
    /// Find card by id
    /// - parameter cardId: The card id to find
    /// - returns: ElanCard instance otherwise nil if the card is not found 
    public func getCardById(_ cardId: String) -> ElanCard!{
        for cellCard: UIView in (self.contentView?.subviews)! {
            if(cellCard.isKind(of: ElanCard.self)){
                let currentCardId = (cellCard as! ElanCard).cardId
                if (currentCardId == cardId){
                    return cellCard as? ElanCard
                }
            }
        }
        return nil
    }
    
    /// Create a new Card
     /// - parameter newElanCardConstructor: A closure which is called with newElanCardConstructor, an instance of ElanCard
    public func addCell(newElanCardConstructor: NewElanCardConstructor){
        
        let cellCard = ElanCard()
       
        cellCard.paddingTop = self.paddingTop
        cellCard.paddingBottom = self.paddingBottom
        cellCard.paddingLeft = self.paddingLeft
        cellCard.paddingRight = self.paddingRight
        
        cellCard.selectionColor = self.selectedColor
        
        cellCard.indexPath = ElanIndex(row: self.nextRow, column: self.nextColumn)
        cellCard.cardId = "\(self.nextRow)-\(self.nextColumn)"
        
        //Add Tap event
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTapCard(_:)))
       //Add Long tap event
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.onLongPressCard(_:)))
        
        cellCard.addGestureRecognizer(tapGesture)
        cellCard.addGestureRecognizer(longTapGesture)
        
        self.contentView?.addSubview(cellCard)
        self.setNeedsLayout()
        
        //Update nextColumn and nextRow indexes
        if self.maxColumns == (self.nextColumn + 1) {
            self.nextColumn = 0
            self.nextRow += 1
        } else {
            self.nextColumn += 1
        }
        
        newElanCardConstructor(cellCard)
    }
    
    // Single Tap event
    @objc func onTapCard(_ sender:UITapGestureRecognizer){
        
        if elanGridViewDelegate != nil {
            let cellCard = sender.view as! ElanCard
            
            if (self.allowsMultipleSelection && self.isSelectionOn) {
                cellCard.updateSelectionState()
                
                if (cellCard.isSelected) {
                    self.selectedCards.append(cellCard.indexPath)
                }else{
                    self.selectedCards =  self.selectedCards.filter { $0 != cellCard.indexPath }
                }
                
                if let slectedCardsMethod = elanGridViewDelegate?.selectedCards {
                    slectedCardsMethod(self.selectedCards)
                }
            } else {
                if let tapCardMethod = elanGridViewDelegate?.onTapCard {
                    tapCardMethod(cellCard)
                }
            }
            
            if self.selectedCards.count == 0 {
                self.isSelectionOn = false
            }
        }
    }
    
    // Long press event
    @objc func onLongPressCard(_ sender:UITapGestureRecognizer){
        if (sender.state == .ended) {
            if (elanGridViewDelegate != nil) {
                let cellCard = sender.view as! ElanCard
                
                if (self.allowsMultipleSelection  && !self.isSelectionOn) {
                    self.isSelectionOn = true
                    self.onTapCard(sender)
                } else if (self.allowsMultipleSelection  && self.isSelectionOn) {
                    self.onTapCard(sender)
                } else {
                    
                    if let longPressMethod = elanGridViewDelegate?.onLongPressCard {
                        longPressMethod(cellCard)
                    }
                    
                }
            }
        }
    }
}

