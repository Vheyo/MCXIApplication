//
//  CopriScopriViewController.swift
//  CopriScopri
//
//  Created by Francesco Tito on 03/05/2020.
//  Copyright © 2020 Francesco Tito. All rights reserved.
//

import UIKit

class CopriScopriViewController: UIViewController {
    
    var timeShow : String = "400"
    var numberOfCharacthers : String = "6"
    var numberSelected: Bool = false
    var maiuscSelected: Bool = false
    var minSelected : Bool = false
    var generateWordOk : Bool = false {
        didSet {
            if generateWordOk {
                newWordButton.setTitle("Rispondi", for: .normal)
            }else {
                userAnswer.placeholder = "Inserisci valore"
                userAnswer.text = ""
                newWordButton.setTitle("NewWord", for: .normal)
            }
            
        }
    }
    
    private var lineVertical : UIView = {
        let lineVertical = UIView()
        lineVertical.backgroundColor = .black
        lineVertical.layer.borderWidth = 2
        lineVertical.layer.borderColor = UIColor.black.cgColor
        lineVertical.translatesAutoresizingMaskIntoConstraints = false
        lineVertical.isHidden = true
        return lineVertical
    }()
    
    private var newWordButton : UIButton = {
        let newWord = UIButton()
        newWord.backgroundColor = .gray
        newWord.setTitle("NewWord", for: .normal)
        newWord.setTitleColor(UIColor.black, for: .normal)
        newWord.translatesAutoresizingMaskIntoConstraints = false
        newWord.addTarget(self, action: #selector(generateWord), for: .touchUpInside)
        return newWord
    }()
    
    private var newWordLabel : UILabel = {
        let newWordlabel = UILabel()
        newWordlabel.text = " "
        newWordlabel.isHidden = true
        newWordlabel.translatesAutoresizingMaskIntoConstraints=false
        newWordlabel.textAlignment = .center
        return newWordlabel
    }()
    
    private var userAnswer : UITextField = {
        var userAnswer = UITextField()
        userAnswer.translatesAutoresizingMaskIntoConstraints = false
        userAnswer.keyboardType = .default
        userAnswer.placeholder = "Inserisci valore"
        userAnswer.borderStyle = .roundedRect
        userAnswer.isHidden = true
//        userAnswer.autocapitalizationType = .none
        return userAnswer
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpConstraints()
        setUpGestureForKeyboard()

        // Do any additional setup after loading the view.
    }
    
    func setUpGestureForKeyboard(){
        let tap = UITapGestureRecognizer(target : view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setUpConstraints(){
        view.addSubview(lineVertical)
        view.addSubview(newWordButton)
        view.addSubview(newWordLabel)
        view.addSubview(userAnswer)
        
        NSLayoutConstraint.activate([
            lineVertical.topAnchor.constraint(equalTo: view.topAnchor),
            lineVertical.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            lineVertical.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineVertical.widthAnchor.constraint(equalToConstant: 1),
            
            newWordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newWordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            newWordButton.widthAnchor.constraint(equalToConstant: 100),
            
            newWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newWordLabel.widthAnchor.constraint(equalToConstant: 200),
            newWordLabel.bottomAnchor.constraint(equalTo: newWordButton.topAnchor, constant: -40),
            
            userAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userAnswer.widthAnchor.constraint(equalToConstant: 200),
            userAnswer.bottomAnchor.constraint(equalTo: newWordButton.topAnchor, constant: -40)
            
        ])
    }
    @objc func generateWord(){
        
        if !generateWordOk {
            let string = randomString(length: Int(numberOfCharacthers)! )
            newWordLabel.text = string
            newWordLabel.isHidden = false
            self.userAnswer.isHidden = true
            lineVertical.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()+TimeInterval(Int(timeShow)!)/1000, execute: {
                self.newWordLabel.isHidden = true
                self.userAnswer.isHidden = false
                self.lineVertical.isHidden = true
            })
            generateWordOk = true
        }else {
            if userAnswer.isEmpty {
                addPopUp(text: "Inserisci una Risposta")
            }else {
                if userAnswer.text == newWordLabel.text{
                    // Inserisci un popUp che scrive corretto
                    addPopUp(text: "Risposta Corretta")
                    generateWordOk = false
                }else {
                    // Inserisci un popUp che scrive corretto
                    addPopUp(text: "Risposta Sbagliata")
                    generateWordOk = false
                }
            }
        }
        
    }
    

    func randomString(length: Int) -> String {
        var letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        if numberSelected && !maiuscSelected && !minSelected {
            letters = "0123456789"
        }else if !numberSelected && maiuscSelected && !minSelected {
            letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }else if !numberSelected && !maiuscSelected && minSelected {
            letters = "abcdefghijklmnopqrstuvwxyz"
        }else if numberSelected && maiuscSelected && !minSelected {
            letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        }else if numberSelected && !maiuscSelected && minSelected {
            letters = "abcdefghijklmnopqrstuvwxyz0123456789"
        }else if !numberSelected && maiuscSelected && minSelected {
            letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
        
        let arr = (0..<length).map{ _ in letters.randomElement()! }
        return String(arr)
    }
    
}

extension UIViewController {
    func addPopUp(text : String){
        let popOverVC = PopUpViewController()
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.suggestLabel.text = text
        popOverVC.didMove(toParent: self)
    }
}
