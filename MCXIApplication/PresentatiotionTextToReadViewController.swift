//
//  PresentatiotionTextToReadViewController.swift
//  pagingProva
//
//  Created by Francesco Tito on 13/05/2020.
//  Copyright © 2020 Francesco Tito. All rights reserved.
//

import UIKit

class PresentatiotionTextToReadViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var textTitle : UILabel = {
        let textTitle = UILabel()
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        textTitle.text = " Tap To Start To Read "
        textTitle.textAlignment = .center
        return textTitle
    }()
    
    var textToRead : UILabel = {
        let textToRead = UILabel()
        textToRead.translatesAutoresizingMaskIntoConstraints = false
        textToRead.text = "Mi so rotto il cazzo merda troia del cazzo"
        textToRead.alpha = 0
        return textToRead
    }()
    
    private var playButton : UIButton = {
        let playButton = UIButton(type: .custom)
        playButton.setTitle("B", for: .normal)
        playButton.setTitleColor(UIColor.black, for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.borderColor = UIColor.black.cgColor
        playButton.layer.borderWidth = 1
        playButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        playButton.layer.cornerRadius = 0.5 * playButton.bounds.size.width
        playButton.clipsToBounds = true
        return playButton
    }()
    
    private var backButton : UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.setTitle("P", for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.layer.borderWidth = 1
        backButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        backButton.layer.cornerRadius = 0.5 * backButton.bounds.size.width
        backButton.clipsToBounds = true
        return backButton
    }()
    
    private var forwardButton : UIButton = {
        let forwardButton = UIButton(type: .custom)
        forwardButton.setTitle("F", for: .normal)
        forwardButton.setTitleColor(UIColor.black, for: .normal)
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.layer.borderColor = UIColor.black.cgColor
        forwardButton.layer.borderWidth = 1
        forwardButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        forwardButton.layer.cornerRadius = 0.5 * forwardButton.bounds.size.width
        forwardButton.clipsToBounds = true
        return forwardButton
    }()
    
    
    private var dropUpButtonTime : DropUpButton = {
        let dropUpButtonTime = DropUpButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        dropUpButtonTime.setTitle("T", for: .normal)
        dropUpButtonTime.setTitleColor(UIColor.black, for: .normal)
        dropUpButtonTime.translatesAutoresizingMaskIntoConstraints = false
        dropUpButtonTime.layer.borderColor = UIColor.black.cgColor
        dropUpButtonTime.layer.borderWidth = 1
        dropUpButtonTime.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        dropUpButtonTime.layer.cornerRadius = 0.5 * dropUpButtonTime.bounds.size.width
        dropUpButtonTime.clipsToBounds = true
        dropUpButtonTime.tag = 1
        return dropUpButtonTime
    }()
    
    private var dropDownButtonTime : DropUpButton = {
        let dropDownButtonTime = DropUpButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        dropDownButtonTime.setTitle("PAM", for: .normal)
        dropDownButtonTime.setTitleColor(UIColor.black, for: .normal)
        dropDownButtonTime.translatesAutoresizingMaskIntoConstraints = false
        dropDownButtonTime.layer.borderColor = UIColor.black.cgColor
        dropDownButtonTime.layer.borderWidth = 1
        dropDownButtonTime.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        dropDownButtonTime.layer.cornerRadius = 0.5 * dropDownButtonTime.bounds.size.width
        dropDownButtonTime.clipsToBounds = true
        dropDownButtonTime.tag = 2
        return dropDownButtonTime
    }()
    
    
    private var backButtonView : UIButton = {
        let backButtonView = UIButton()
        backButtonView.setTitle("Back", for: .normal)
        backButtonView.setTitleColor(UIColor.black, for: .normal)
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        return backButtonView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.landscape)
        setUpGesture()
        setUpConstraintsButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }

    func setUpGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startToRead))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func startToRead(){
        textToRead.alpha = 1
        textTitle.alpha = 0
    }
    

    func setUpConstraintsButton(){
        self.view.addSubview(playButton)
        self.view.addSubview(forwardButton)
        self.view.addSubview(backButton)
        self.view.addSubview(backButtonView)
        self.view.addSubview(dropUpButtonTime)
        self.view.addSubview(dropDownButtonTime)
        self.view.addSubview(textTitle)
        self.view.addSubview(textToRead)
        
        backButtonView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            textTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            textTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            textTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            textTitle.heightAnchor.constraint(equalToConstant: 30),
            
            textToRead.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textToRead.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textToRead.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textToRead.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            backButtonView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            backButtonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
            backButtonView.heightAnchor.constraint(equalToConstant: 50),
            backButtonView.widthAnchor.constraint(equalToConstant: 70),
            
            dropDownButtonTime.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 20),
            dropDownButtonTime.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            dropDownButtonTime.heightAnchor.constraint(equalToConstant: 50),
            dropDownButtonTime.widthAnchor.constraint(equalToConstant: 50),
            
            playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -30),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            
            
            backButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -30),
            backButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            
            forwardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -30),
            forwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20),
            forwardButton.heightAnchor.constraint(equalToConstant: 50),
            forwardButton.widthAnchor.constraint(equalToConstant: 50),
            
            dropUpButtonTime.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -30),
            dropUpButtonTime.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
            dropUpButtonTime.heightAnchor.constraint(equalToConstant: 50),
            dropUpButtonTime.widthAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.isKind(of: DropUpViewCollectionViewCell.self){
            print("ciao bela")
            return false
        }
        if touch.isKind(of: DropUpView.self){
            print("cia cici")
            return false
        }
        return true
    }
    
}
