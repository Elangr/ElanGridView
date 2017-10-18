//
//  ViewController.swift
//  ElanCard
//
//  Created by Imrane EL HAMIANI on 09/27/2017.
//  Copyright (c) 2017 Imrane EL HAMIANI. All rights reserved.
//

import UIKit
import ElanGridView

class ViewController: UIViewController {
    @IBOutlet weak var elanGridview: ElanGridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in (0..<40){
            elanGridview.addCell(){
                cellView in
                let testView: TestView = TestView.instanceFromNib()
                testView.rowLabel.text = "\(cellView.row)"
                testView.columnLabel.text = "\(cellView.column)"

                cellView.addSubview(testView)
            }
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

