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
    @IBAction func onClickTestEvent(_ sender: Any) {
        let alertController = UIAlertController(title: "Test", message: "On tap button inside Card", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        UIApplication.shared.windows[0].rootViewController?.present(alertController, animated: false)

    }
}

