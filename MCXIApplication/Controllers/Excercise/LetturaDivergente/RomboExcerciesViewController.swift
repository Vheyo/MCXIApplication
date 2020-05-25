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
        textView.font = FontKit.roundedFont(ofSize: 24, weight: .semibold)
        textView.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        textView.isEditable = false
        textView.isSelectable = false
        textView.textAlignment = .center
        return textView
    }()
    
    private var backButton : UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17,weight: .regular)
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return backButton
    }()
    
    private var playButton : UIButton = {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Increase", for: .normal)
        playButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        playButton.titleLabel?.font = FontKit.roundedFont(ofSize: 20, weight: .semibold)
        playButton.addTarget(self, action: #selector(showText), for: .touchUpInside)
        playButton.titleLabel?.textAlignment = .center
        playButton.layer.borderWidth = 2
        playButton.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        playButton.layer.cornerRadius = 25
        playButton.backgroundColor = .white
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
    
    private var niceLabel : UILabel = {
        let niceLabel = UILabel()
        niceLabel.translatesAutoresizingMaskIntoConstraints = false
        niceLabel.text = "Nice"
        niceLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        niceLabel.textAlignment = .center
        niceLabel.alpha = 0
        niceLabel.font = FontKit.roundedFont(ofSize: 56, weight: .bold)
        return niceLabel
    }()
    
    private var replyButton : UIButton = {
        let replyButton = UIButton()
        replyButton.translatesAutoresizingMaskIntoConstraints = false
        replyButton.setTitle("Retry", for: .normal)
        replyButton.setTitleColor(.white, for: .normal)
        replyButton.titleLabel?.font = FontKit.roundedFont(ofSize: 22, weight: .bold)
        replyButton.addTarget(self, action: #selector(replyEx), for: .touchUpInside)
        replyButton.titleLabel?.textAlignment = .center
        replyButton.layer.cornerRadius = 25
        replyButton.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        replyButton.alpha = 0
        return replyButton
    }()
    
    
    var shadowIncrease : ShadowView!
    var shadowReply : ShadowView!
    
    var indexWord = 1
    var textToShow = ["on","lens","scotch","positive","are known", "of detersive","the cool detail", "a fact does things", "will Batman a baker", "behavior governments", "so healings and the reiki", "know what time is it or no", "the choice of red or blue pill", "sends kisses and hugs to Fyn", "air, earth, fire, wind, air, land, ok","internet and computers will have", "friendship is a fundamental valour", "is going to gym is so healthy for you", "if you hardly commit and you give a test", "holidays are a must, you don’t miss them", "repeating and repeating is mother of needs", "Force and Honour is the Gladiator’s film motto","M.B. Jordan is considered the best athlete ever","chinese medicine looks like the most complete one"]
    
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
        view.addSubview(niceLabel)
        view.addSubview(replyButton)
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
            
            niceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            niceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            niceLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            niceLabel.heightAnchor.constraint(equalToConstant: 60),
            
            playButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            playButton.widthAnchor.constraint(equalToConstant: 130),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            
            replyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            replyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            replyButton.widthAnchor.constraint(equalToConstant: 130),
            replyButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
        
        shadowIncrease = playButton.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 3, shadowOpacity: 0.3, offsetY: 3, offsetX: 0)
        replyButton.layer.masksToBounds = true
        replyButton.setGradientBackground(colorOne: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), colorTwo: #colorLiteral(red: 0.3725490196, green: 0.2274509804, blue: 0.8274509804, alpha: 1), frame : CGRect(x: 0, y: 0, width: 150, height: 50))
    }
    
    var isOk : Bool = true
    @objc func showText(){
        textView.text = textToShow[indexWord]
        if indexWord < textToShow.count - 1{
            lineVertical.isHidden = false
            textView.isHidden = false
            playButton.isHidden = false
            if shadowReply != nil {
                if isOk {
                    shadowIncrease = playButton.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 3, shadowOpacity: 0.3, offsetY: 3, offsetX: 0)
                    isOk = false
                }
            }
            
            indexWord += 1
        }else {
            lineVertical.isHidden = true
            textView.isHidden = true
            playButton.isHidden = true
            shadowIncrease.removeFromSuperview()
            UIView.animate(withDuration: 0.5, animations: {
                self.replyButton.alpha = 1
                self.niceLabel.alpha = 1
            }) { (complete) in
                if complete{
                    self.shadowReply = self.replyButton.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3, shadowOpacity: 0.3, offsetY: 3, offsetX: 0)
                }
            }
            
            
            isOk = true
        }
    }
    
    @objc func replyEx(){
        indexWord = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.replyButton.alpha = 0
            self.niceLabel.alpha = 0
            self.shadowReply.removeFromSuperview()
        }) { (complete) in
            if complete {
                self.showText()
            }
        }
        
    }
    
    
    @objc func dismissView(){
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
