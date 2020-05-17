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
    var textToShow = ["su","luce","scotch","positivo","sei nuovo", "un detersivo","vai alla grande", "i fiori sono gialli", "c'è Batman e Robin", "macchina fotografica", "la guarigione e il reiki", "tu sai che ore sono o no", " scegli la pillola rossa o blu", "manda baci e abbracci a tutti", "acqua,terra,fuoco,vento,aria","internet e computer diventeranno", "l'amicizia è un valore fondamentale", "andare in palestra fa bene alla salute", "se ti impegni fino in fondo e dai tutto", "le vacanze sono sacre e non si toccano", "la ripetizione è la madre di tutte le abilità", "nel film Gladiatore il motto è : Forza e Onore"," M.Jordan è considerato l'atleta per eccellenza","la medicina cinese sembra essere più completa"]
    
    override func viewDidLoad() {
        AppUtility.lockOrientation(.landscape)
        var initialTimer = 5
        setUpConstraint()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {timer in
            self.textView.text = "\(initialTimer)"
            initialTimer -= 1
            if initialTimer == -1 {
                timer.invalidate()
                self.showText()
            }
        })
        view.backgroundColor = .white
        textView.textColor = .black
        let tapNextGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showText))
        view.addGestureRecognizer(tapNextGestureRecognizer);
    }
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    
    func setUpConstraint(){
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            textView.heightAnchor.constraint(equalToConstant: 50)
            
        
        
        
        ])
    }
    
    @objc func showText(){
        textView.text = textToShow[indexWord]
        if indexWord < textToShow.count - 1{
            indexWord += 1
        }
    }
    
    
}
