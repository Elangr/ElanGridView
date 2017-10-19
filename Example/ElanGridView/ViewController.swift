//
//  ViewController.swift
//  ElanCard
//
//  Created by Imrane EL HAMIANI on 09/27/2017.
//  Copyright (c) 2017 Imrane EL HAMIANI. All rights reserved.
//

import UIKit
import ElanGridView

class ViewController: UIViewController, ElanGridViewDelegate {
  
    
    @IBOutlet weak var elanGridview: ElanGridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elanGridview.elanGridViewDelegate = self
        for i in (0..<40){
            elanGridview.addCell(){
                cellView in
                let testView: TestView = TestView.instanceFromNib()
                cellView.indexPath.tag = "hello \(i)"
                testView.rowLabel.text = "\(cellView.indexPath.row)"
                testView.columnLabel.text = "\(cellView.indexPath.column)"

                cellView.addSubview(testView)
            }
        }
        
       
    }

    func onTapCard(_ elanCard: ElanCard) {
        let alertController = UIAlertController(title: "Test tap", message: "Hello this is card \ncolumn: \(elanCard.indexPath.column) \nrow :\(elanCard.indexPath.row)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: false)
    }
    
    func onLongPressCard(_ elanCard: ElanCard) {
        let alertController = UIAlertController(title: "Test Long press", message: "Hello this is card \ncolumn: \(elanCard.indexPath.column) \nrow :\(elanCard.indexPath.row)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: false)
    }
    
    func selectedCards(_ selectedCards: [ElanIndex]) {
        print("\(selectedCards)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

