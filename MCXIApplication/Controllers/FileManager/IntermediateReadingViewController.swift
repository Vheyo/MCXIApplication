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
     var textToRead : UITextView = {
           let textToRead = UITextView()
           textToRead.translatesAutoresizingMaskIntoConstraints = false
           textToRead.textAlignment = .center
           textToRead.showsVerticalScrollIndicator = false
           textToRead.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
           
           return textToRead
       }()
       
     private var buttonPlay : UIButton = {
            let buttonPlay = UIButton()
            buttonPlay.setTitle("Play", for: .normal)
            buttonPlay.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
            buttonPlay.setTitleColor(.white, for: .normal)
            buttonPlay.translatesAutoresizingMaskIntoConstraints = false
            buttonPlay.titleLabel?.font = FontKit.roundedFont(ofSize: 18, weight: .semibold)
            buttonPlay.layer.cornerRadius = 16
            buttonPlay.addTarget(self, action: #selector(playAction), for: .touchUpInside)
            return buttonPlay
        }()
    
    private var saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.titleLabel?.font = FontKit.roundedFont(ofSize: 18, weight: .semibold)
        saveButton.layer.cornerRadius = 16
        return saveButton
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
          
       
       
       
       override func viewDidLoad() {
           setUpTextToRead()
        view.backgroundColor = .white
        setUpTextField()
       }
    
    @objc func dismissKeyboard(){
           self.view.endEditing(true)
       }
       
       func setUpTextField(){
           let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
           
           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           
           let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
           toolbar.setItems([flexSpace,doneButton], animated: false)
           toolbar.sizeToFit()
           
           textToRead.inputAccessoryView = toolbar
       }
    
    
    
    
    func setUpTextToRead(){
           self.view.addSubview(textToRead)
           self.view.addSubview(buttonPlay)
           self.view.addSubview(backButton)
           NSLayoutConstraint.activate([
               
               backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                           
               buttonPlay.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
               buttonPlay.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
               buttonPlay.heightAnchor.constraint(equalToConstant: 70),
               buttonPlay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
               
               
               
               textToRead.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
               textToRead.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
               textToRead.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
               textToRead.bottomAnchor.constraint(equalTo: buttonPlay.topAnchor, constant: -40),
           ])
       }
       
    @objc func dismissView(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func playAction(){
        let vc = PresentatiotionTextToReadViewController()
        vc.text = textToRead.text
        vc.view.backgroundColor = .white
        
        present(vc,animated: true)
    }
}
