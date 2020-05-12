//
//  SaveAndEditViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 12/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit


class SaveAndEditViewController : UIViewController{
    
    @IBOutlet var textView: UITextField!
    
    @IBOutlet var nomeFileTextField: UITextField!
    
    
    
    @IBAction func SaveFileAction(_ sender: Any) {
        let file = "\(nomeFileTextField.text ?? "Allegato1").txt"
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
