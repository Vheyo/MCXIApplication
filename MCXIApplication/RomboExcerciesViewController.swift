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
        textView.font = FontKit.roundedFont(ofSize: 24, weight: .regular)
        textView.textColor = .black
        textView.isEditable = false
        textView.isSelectable = false
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
        return backButton
    }()
    
    private var playButton : UIButton = {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Go On", for: .normal)
        playButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        playButton.addTarget(self, action: #selector(showText), for: .touchUpInside)
        playButton.titleLabel?.textAlignment = .center
        playButton.titleLabel?.textAlignment = .left
        playButton.layer.borderWidth = 2
        playButton.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        playButton.layer.cornerRadius = 25
        return playButton
    }()
    
    private var lineVertical : UIView = {
        let lineVertical = UIView()
        lineVertical.backgroundColor = .black
        lineVertical.layer.borderWidth = 1
        lineVertical.layer.borderColor = UIColor.gray.cgColor
        lineVertical.translatesAutoresizingMaskIntoConstraints = false
        lineVertical.isHidden = true
        return lineVertical
    }()
    
    var indexWord = 1
    var textToShow = ["su","luce","scotch","positivo","sei nuovo", "un detersivo","vai alla grande", "i fiori sono gialli", "c'è Batman e Robin", "macchina fotografica", "la guarigione e il reiki", "tu sai che ore sono o no", " scegli la pillola rossa o blu", "manda baci e abbracci a tutti", "acqua,terra,fuoco,vento,aria","internet e computer diventeranno", "l'amicizia è un valore fondamentale", "andare in palestra fa bene alla salute", "se ti impegni fino in fondo e dai tutto", "le vacanze sono sacre e non si toccano", "la ripetizione è la madre di tutte le abilità", "nel film Gladiatore il motto è : Forza e Onore"," M.Jordan è considerato l'atleta per eccellenza","la medicina cinese sembra essere più completa"]
    
    override func viewDidLoad() {
        AppUtility.lockOrientation(.landscape)
        setUpConstraint()
        view.backgroundColor = .white
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
        view.addSubview(playButton)
        view.addSubview(lineVertical)
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            lineVertical.topAnchor.constraint(equalTo: view.topAnchor),
             lineVertical.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             lineVertical.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             lineVertical.widthAnchor.constraint(equalToConstant: 1),
        
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            textView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textView.heightAnchor.constraint(equalToConstant: 50),
            
            playButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            playButton.widthAnchor.constraint(equalToConstant: 130),
            playButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
    @objc func showText(){
        lineVertical.isHidden = false
        textView.text = textToShow[indexWord]
        if indexWord < textToShow.count - 1{
            indexWord += 1
        }
    }
    
    @objc func dismissView(){
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
