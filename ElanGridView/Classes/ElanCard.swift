//
//  ElanCard.swift
//  ElanCard
//
//  Created by Imrane EL HAMIANI on 09/27/2017.
//

import UIKit

public class ElanCard: UIView {
    
    public var cornerRadius: CGFloat = 2
    
    public var shadowOffsetWidth: Int = 0
    public var shadowOffsetHeight: Int = 2
    public var shadowColor: UIColor? = UIColor.black
    public var shadowOpacity: Float = 0.4
    
    public var row: UInt = 0
    public var column: UInt = 0
    
    public var cellSize: CGSize = CGSize.zero
    
    public var paddingLeft: CGFloat = 0.0
    public var paddingRight: CGFloat = 0.0
    public var paddingTop: CGFloat = 0.0
    public var paddingBottom: CGFloat = 0.0
    
    
    private var cardSize = CGSize.zero
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor?.cgColor
        self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowPath = shadowPath.cgPath
        
    }
    
    public override func addSubview(_ view: UIView) {
        
        super.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let viewsDict = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[view]-0-|",
            options: [],
            metrics: nil,
            views: viewsDict))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[view]-0-|",
            options: [],
            metrics: nil,
            views: viewsDict))
    }
    
    public func updateLayout(){
        self.cardSize.width = self.cellSize.width - (self.paddingLeft + self.paddingRight)
        self.cardSize.height = self.cellSize.height - (self.paddingTop + self.paddingBottom)
        var currentFrame: CGRect = CGRect(origin: CGPoint.zero, size: self.cardSize)
        currentFrame.origin.x = self.paddingLeft + CGFloat(self.column) + (CGFloat(self.column) * (self.cellSize.width - 1)) + 1
        currentFrame.origin.y = self.paddingTop + CGFloat(self.row) + (CGFloat(self.row) * (self.cellSize.height - 1)) + 1

        self.frame = currentFrame
    }
}

