//
//  ShareViewController.swift
//  CopyText
//
//  Created by Salvatore Guerrisi on 03/05/2020.
//

import UIKit
import Social

class ShareViewController: UIViewController {
   
    
    @IBOutlet var input_text: UILabel!
    
    override func   viewDidLoad() {
        if let content = extensionContext!.inputItems[0] as? NSExtensionItem {
            // move your content validation to `func isContentValid() -> Bool`

            let attributedString = content.attributedContentText?.string
            input_text.text = attributedString
        }
    }


    
    
}
