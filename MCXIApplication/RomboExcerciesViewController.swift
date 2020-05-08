//
//  RomboExcerciesViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 06/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit

class RomboExcerciesViewController : UIViewController{
    @IBOutlet var textView: UITextView!
    
    var indexWord = 1
    var textToShow = """
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus euismod sed diam vitae ultricies. Vivamus in justo nibh. Proin ante elit, laoreet vitae magna id, egestas scelerisque leo. Sed luctus risus a tellus blandit venenatis. Phasellus dictum neque quis urna varius viverra. Integer placerat arcu vitae est pulvinar pulvinar. Etiam tempor nec lacus sit amet fringilla. Fusce sit amet dignissim tellus, sed viverra nunc. Aliquam ut nisi quis felis consequat egestas in id ligula. Curabitur vulputate tellus a tempus fringilla. Etiam vel purus nec mi sodales posuere. Cras ut orci consectetur quam pretium finibus.
 """
    var textSplitted = [String.SubSequence]()
    override func viewDidLoad() {
        var initialTimer = 5
        textSplitted = textToShow.split(separator: " ")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {timer in
            self.textView.text = "\(initialTimer)"
            initialTimer -= 1
            if initialTimer == 0 {
                timer.invalidate()
            }
        })
        let tapNextGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showText))
        view.addGestureRecognizer(tapNextGestureRecognizer);
    }
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    @objc func showText(){
        let start = textSplitted.index(textSplitted.startIndex, offsetBy: indexWord)
        let end = textSplitted.index(textSplitted.endIndex, offsetBy: -(textSplitted.endIndex-indexWord*2-1))
        var range = 0..<1
        if end == 0{
            range = start..<1
        }
        else {
            range = start..<end
        }
        if end > textSplitted.count {
            return
        }
        
        let mySubstring = (textSplitted[range])
        let myArray = Array(mySubstring)
        var myString = String()
        for elements in myArray{
            myString.append(String(elements))
            myString.append(contentsOf: " ")
        }
        self.textView.text = myString
        if indexWord == 1 {
            indexWord += 1
        }
        else {
            indexWord = indexWord*2-1
        }
        
        if indexWord > textSplitted.count {
            return
        }
        
    }
    
    
}
