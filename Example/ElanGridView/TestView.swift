//
//  TestView.swift
//  ElanGridView
//
//  Created by Imrane EL HAMIANI on 09/27/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

public class TestView: UIView{
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var columnLabel: UILabel!
    class func instanceFromNib() -> TestView {
        return UINib(nibName: "TestView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TestView
    }
}

