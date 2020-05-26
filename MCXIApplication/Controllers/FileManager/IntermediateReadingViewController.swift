//
//  IntermediateViewController.swift
//  Ready
//
//  Created by Astroworld on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit
class IntermediateReadingViewController: UIViewController{
    var nameFile = String()
    
    var textToRead : UITextView = {
        let textToRead = UITextView()
        textToRead.translatesAutoresizingMaskIntoConstraints = false
        textToRead.showsVerticalScrollIndicator = false
        return textToRead
    }()
    
    private var buttonPlay : UIButton = {
        let buttonPlay = UIButton()
        buttonPlay.setTitle("Play", for: .normal)
        buttonPlay.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        buttonPlay.setTitleColor(.white, for: .normal)
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.titleLabel?.font = FontKit.roundedFont(ofSize: 22, weight: .semibold)
        buttonPlay.layer.cornerRadius = 35
        buttonPlay.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        return buttonPlay
    }()
    
    private var saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.titleLabel?.font = FontKit.roundedFont(ofSize: 22, weight: .semibold)
        saveButton.layer.cornerRadius = 35
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return saveButton
    }()
    
    private var backButton : UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        backButton.titleLabel?.textAlignment = .left
        return backButton
    }()
    
    private var userAnswer : UITextField = {
        var userAnswer = UITextField()
        userAnswer.translatesAutoresizingMaskIntoConstraints = false
        userAnswer.keyboardType = .default
        userAnswer.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        userAnswer.layer.borderWidth = 2
        userAnswer.layer.cornerRadius = 20
        userAnswer.isHidden = false
        userAnswer.textAlignment = .center
        userAnswer.placeholder = "Rename the File"
        userAnswer.addTarget(self, action: #selector(userWrite), for: .editingDidBegin)
        userAnswer.addTarget(self, action: #selector(userFinishWrite), for: .editingDidEnd)
        return userAnswer
    }()
    
    
    override func viewDidLoad() {
        setUpTextToRead()
        view.backgroundColor = .white
        setUpTextField()
        
        let attributeString = NSMutableAttributedString(string: textToRead.text)
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = 8
        
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, textToRead.text.count))
        
        textToRead.attributedText = attributeString
        textToRead.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
        textToRead.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        textToRead.textAlignment = .center
        setUpGestureForKeyboard()
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func userWrite(){
        UIView.animate(withDuration: 0.5) {
            self.userAnswer.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        }
    }
    
    @objc func userFinishWrite(){
        if userAnswer.isEmpty {
            UIView.animate(withDuration: 0.5) {
                self.userAnswer.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            }
        }
    }
    
    func setUpGestureForKeyboard(){
        let tap = UITapGestureRecognizer(target : view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
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
        self.view.addSubview(backButton)
        self.view.addSubview(userAnswer)
        self.view.addSubview(textToRead)
        self.view.addSubview(buttonPlay)
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            buttonPlay.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
            buttonPlay.heightAnchor.constraint(equalToConstant: 70),
            buttonPlay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            buttonPlay.widthAnchor.constraint(equalToConstant: 130),
            
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            saveButton.heightAnchor.constraint(equalToConstant: 70),
            saveButton.centerYAnchor.constraint(equalTo: buttonPlay.centerYAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 130),
            
            userAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userAnswer.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            userAnswer.heightAnchor.constraint(equalToConstant: 80),
            userAnswer.widthAnchor.constraint(equalToConstant: 300),
            
            textToRead.topAnchor.constraint(equalTo: userAnswer.bottomAnchor, constant: 20),
            textToRead.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textToRead.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            textToRead.bottomAnchor.constraint(equalTo: buttonPlay.topAnchor, constant: -40),
        ])
        
        saveButton.setGradientBackground(colorOne: #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), colorTwo: #colorLiteral(red: 0.3725490196, green: 0.2274509804, blue: 0.8274509804, alpha: 1), frame : CGRect(x: 0, y: 0, width: 130, height: 70))
        buttonPlay.setGradientBackground(colorOne: #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), colorTwo: #colorLiteral(red: 0.3725490196, green: 0.2274509804, blue: 0.8274509804, alpha: 1), frame : CGRect(x: 0, y: 0, width: 130, height: 70))
        
        saveButton.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3.5, shadowOpacity: 0.4, offsetY: 3.5, offsetX: 0)
        buttonPlay.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3.5, shadowOpacity: 0.4, offsetY: 3.5, offsetX: 0)
        
        saveButton.layer.masksToBounds = true
        buttonPlay.layer.masksToBounds = true
    }
    
    @objc func dismissView(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func playAction(){
        let vc = PresentatiotionTextToReadViewController()
        vc.text = textToRead.text
        vc.view.backgroundColor = .white
        vc.nameFile = nameFile
        present(vc,animated: true)
    }
    
    
    @objc func saveAction(){
      
        let file = "\(nameFile).txt"
        print("\(nameFile).txt")
        let text = textToRead.text
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            // aggiungiamo il file alla directory
            removeFile()
            
            let fileURL = dir.appendingPathComponent(file)
            // Scriviamo il contenuto nel file
            
            do{
                try text?.write(to: fileURL, atomically: false, encoding: .utf8)
                
            }catch{
                print("cant write...")
            }
        }
        var nameFileArray = UserDefaults.standard.stringArray(forKey: "FileName")
        if !userAnswer.isEmpty {
            if nameFileArray?.isEmpty ?? true {
                nameFileArray?.append(userAnswer.text!)
            }
            else{
                
            var i = 0
            for element in nameFileArray!{
                if element == "\(nameFile).txt"{
                    nameFileArray?[i] = userAnswer.text!
                    print(nameFileArray)
                    print("cambiato con successo")
                }
                i += 1
            }
                
            UserDefaults.standard.set(nameFileArray, forKey: "FileName")
                
               
            }
        }
        
        
        dismissView()
        
    }
    
    
    
    func removeFile(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
                let removeFile = dir.appendingPathComponent("\(nameFile).txt")
                let fileManager = FileManager.default
                do{
                    try fileManager.removeItem(at: removeFile)
                }catch{
                    print("cant remove file...")
                }
            }
        }
    }

