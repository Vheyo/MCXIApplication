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
    
    private var textView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
        textView.textColor = .black
        textView.textAlignment = .center
        return textView
    }()
    
    private var backButton : UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        backButton.titleLabel?.textAlignment = .left
        return backButton
    }()
    
    var indexWord = 1
    var textToShow = ["su","luce","scotch","positivo","sei nuovo", "un detersivo","vai alla grande", "i fiori sono gialli", "c'è Batman e Robin", "macchina fotografica", "la guarigione e il reiki", "tu sai che ore sono o no", " scegli la pillola rossa o blu", "manda baci e abbracci a tutti", "acqua,terra,fuoco,vento,aria","internet e computer diventeranno", "l'amicizia è un valore fondamentale", "andare in palestra fa bene alla salute", "se ti impegni fino in fondo e dai tutto", "le vacanze sono sacre e non si toccano", "la ripetizione è la madre di tutte le abilità", "nel film Gladiatore il motto è : Forza e Onore"," M.Jordan è considerato l'atleta per eccellenza","la medicina cinese sembra essere più completa"]
    
    override func viewDidLoad() {
        AppUtility.lockOrientation(.landscape)
        setUpConstraint()
        view.backgroundColor = .white
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
        view.addSubview(backButton)
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        
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
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    
}
