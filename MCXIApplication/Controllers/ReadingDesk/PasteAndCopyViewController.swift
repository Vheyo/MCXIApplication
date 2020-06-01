//
//  PasteAndCopyViewController.swift
//  Ready
//
//  Created by Astroworld on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit

class PasteAndCopyViewController : UIViewController, UITextViewDelegate {
   var textToRead : UITextView = {
          let textToRead = UITextView()
          textToRead.translatesAutoresizingMaskIntoConstraints = false
          textToRead.textAlignment = .center
          textToRead.showsVerticalScrollIndicator = false
          textToRead.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
            textToRead.text = "Insert Text Here"
            textToRead.textColor = UIColor.lightGray
          return textToRead
      }()
      
    private var buttonPlay : UIButton = {
           let buttonPlay = UIButton()
           buttonPlay.setTitle("Save", for: .normal)
           buttonPlay.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
           buttonPlay.setTitleColor(.white, for: .normal)
           buttonPlay.translatesAutoresizingMaskIntoConstraints = false
           buttonPlay.titleLabel?.font = FontKit.roundedFont(ofSize: 22, weight: .semibold)
           buttonPlay.layer.cornerRadius = 30
           buttonPlay.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
           return buttonPlay
       }()
      
      private var backButton : UIButton = {
             let backButton = UIButton()
             backButton.translatesAutoresizingMaskIntoConstraints = false
             backButton.setTitle("Back", for: .normal)
             backButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17,weight: .regular)
             backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
             backButton.titleLabel?.textAlignment = .left
             return backButton
         }()
         
      func textViewDidBeginEditing(_ textView: UITextView) {
          if textView.textColor == UIColor.lightGray {
              textView.text = nil
              textView.textColor = UIColor.black
          }
      }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
      
      
      override func viewDidLoad() {
          setUpTextToRead()
       view.backgroundColor = .white
        self.textToRead.delegate = self
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
        buttonPlay.layer.masksToBounds = true
        buttonPlay.setGradientBackground(colorOne: #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), colorTwo: #colorLiteral(red: 0.3725490196, green: 0.2274509804, blue: 0.8274509804, alpha: 1), frame : CGRect(x: 0, y: 0, width: view.frame.width-120, height: 70))
        buttonPlay.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3.5, shadowOpacity: 0.4, offsetY: 3.5, offsetX: 0)
    }
    
    @objc func saveAction(){
        let lastFilenum = UserDefaults.standard.integer(forKey: "numFile")+1
        let file = "File\(lastFilenum).txt"
        let text = textToRead.text
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            // aggiungiamo il file alla directory
            let fileURL = dir.appendingPathComponent(file)
            // Scriviamo il contenuto nel file
            
            do{
                try text?.write(to: fileURL, atomically: false, encoding: .utf8)
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "numFile")+1, forKey: "numFile")
            }catch{
                print("cant write...")
            }
            
            var stringArray = UserDefaults.standard.stringArray(forKey: "FileName")
            
            if stringArray == nil{
                 stringArray = [file]
            }
            else {
                stringArray?.append(file)
            }
           
            print(stringArray)
            UserDefaults.standard.set(stringArray, forKey: "FileName")
        }
        dismissView()
        
    }
    
    
    
  
    
    
    @objc func dismissView(){
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ready2Dismiss"), object: nil)
        })
    }
}

