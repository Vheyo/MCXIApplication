//
//  IntermediateFromPdfViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 15/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit

class IntermediateFromPdfViewController : UIViewController {
    var text = String()
    var file = String()
    var fileURL = URL(fileURLWithPath: "")
    var textView = UITextView()
    
    let saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        saveButton.frame = CGRect(x: 150, y: 250, width: 100, height: 100)
        saveButton.backgroundColor = .black
        return saveButton
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        textView.frame = CGRect(x: 0, y: 276, width: 414, height: 620)
        textView.text = text
        view.addSubview(textView)
        view.addSubview(saveButton)
    }
    
    @objc func saveAction(){
        do{
         try text.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print("cant write...")
        }
        dismiss(animated: true, completion: {
            print("dismissed")
        })
    }
}
