//
//  PasteAndCopyViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 17/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit

class PasteAndCopyViewController : UIViewController {
    var textView : UITextView = {
        let textView = UITextView()
        textView.frame =  CGRect(x: 0, y: 276, width: 414, height: 620)
        return textView
    }()
    
    var saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .black
        saveButton.frame = CGRect(x: 150, y: 350, width: 100, height: 100)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return saveButton
    }()
    
    
    
    override func viewDidLoad() {
        view.addSubview(textView)
        view.addSubview(saveButton)
    }
    
    
    @objc func saveAction(){
        let lastFilenum = UserDefaults.standard.integer(forKey: "numFile")
        let file = "File\(lastFilenum).txt"
        let text = textView.text
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            // aggiungiamo il file alla directory
            let fileURL = dir.appendingPathComponent(file)
            // Scriviamo il contenuto nel file
            
            do{
                try text?.write(to: fileURL, atomically: false, encoding: .utf8)
            }catch{
                print("cant write...")
            }
        }
        
    }
}

