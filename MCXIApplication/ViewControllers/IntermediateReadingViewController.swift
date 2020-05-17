//
//  IntermediateViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 15/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit
class IntermediateReadingViewController: UIViewController{
    var textView = UITextView()
    var playButton : UIButton = {
        let playButton = UIButton()
        playButton.setTitle("play", for: .normal)
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        
        return playButton
    }()
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        textView.frame = CGRect(x: 0, y: 276, width: 414, height: 620)
        playButton.frame = CGRect(x: 150, y: 350, width: 100, height: 100)
        view.backgroundColor = .white
        textView.textColor = .black
        view.addSubview(textView)
        view.addSubview(playButton)
    }
    
    @objc func playAction(){
        let vc = PresentatiotionTextToReadViewController()
        vc.text = textView.text
        vc.view.backgroundColor = .white
        
        present(vc,animated: true)
    }
}
