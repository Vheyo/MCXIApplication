//
//  ReadingDeskViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import  UIKit

class ReadingDeskViewController: UIViewController {
    
    private var titleTextLabel : UILabel = {
        let titleTextLabel = UILabel()
        titleTextLabel.text = "Il nome del file"
        titleTextLabel.textAlignment = .center
        titleTextLabel.numberOfLines = 0
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleTextLabel
    }()
    
    private var textViewContainer : UIView = {
        let textViewContainer = UIView()
        textViewContainer.translatesAutoresizingMaskIntoConstraints = false
        textViewContainer.layer.cornerRadius = 12
        textViewContainer.layer.borderColor = UIColor.black.cgColor
        textViewContainer.layer.borderWidth = 1
        return textViewContainer
    }()
    
    private var someTextLabel : UILabel = {
        let someTextLabel = UILabel()
        someTextLabel.text = "Some Text"
        someTextLabel.textAlignment = .center
        someTextLabel.numberOfLines = 0
        someTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return someTextLabel
    }()
    
    
    private var playButton : UIButton = {
        let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.black.cgColor
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private var timeTextRead : UIButton = {
        let timeTextRead = UIButton()
        timeTextRead.setTitle("Tempo di lettura", for: .normal)
        timeTextRead.setTitleColor(.black, for: .normal)
        timeTextRead.layer.borderWidth = 1
        timeTextRead.layer.borderColor = UIColor.black.cgColor
        timeTextRead.translatesAutoresizingMaskIntoConstraints = false
        return timeTextRead
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpConstraints()
    }
    
    func setUpNavigationBar(){
        self.title = "Reading Desk"
        let button1 = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addFile))
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    func setUpConstraints(){
        self.view.addSubview(titleTextLabel)
        self.view.addSubview(textViewContainer)
        textViewContainer.addSubview(someTextLabel)
        self.view.addSubview(playButton)
        self.view.addSubview(timeTextRead)
        
        NSLayoutConstraint.activate([
            titleTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textViewContainer.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant:  16),
            textViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textViewContainer.heightAnchor.constraint(equalToConstant: 300),
            
            someTextLabel.centerYAnchor.constraint(equalTo: textViewContainer.centerYAnchor),
            someTextLabel.centerXAnchor.constraint(equalTo: textViewContainer.centerXAnchor),
            
            
            playButton.topAnchor.constraint(equalTo: textViewContainer.bottomAnchor, constant: 16),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            timeTextRead.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 16),
            timeTextRead.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeTextRead.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
            
            
        ])
    }
    
    
    @objc func addFile(){
        print("ciao bella io ti conosco tu fumi cannella")
    }
    

}
