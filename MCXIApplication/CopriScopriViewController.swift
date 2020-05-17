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
    var generateWordOk : Bool = false
    
    private var timerView : TimerView = {
        let timerView = TimerView()
        timerView.translatesAutoresizingMaskIntoConstraints = false
        return timerView
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
    
    private var whatRead : UILabel = {
        let whatRead = UILabel()
        whatRead.translatesAutoresizingMaskIntoConstraints = false
        whatRead.text = "Cosa hai letto ?"
        whatRead.isHidden = true
        whatRead.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        whatRead.textAlignment = .center
        whatRead.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        return whatRead
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
    
    private var newWordLabel : UILabel = {
        let newWordlabel = UILabel()
        newWordlabel.text = " "
        newWordlabel.isHidden = true
        newWordlabel.translatesAutoresizingMaskIntoConstraints=false
        newWordlabel.textAlignment = .center
        newWordlabel.font = UIFont.systemFont(ofSize: 38, weight: .regular)
        return newWordlabel
    }()
    
    
    private var userAnswer : UITextField = {
        var userAnswer = UITextField()
        userAnswer.translatesAutoresizingMaskIntoConstraints = false
        userAnswer.keyboardType = .default
        userAnswer.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        userAnswer.layer.borderWidth = 2
        userAnswer.layer.cornerRadius = 20
        userAnswer.isHidden = true
        userAnswer.textAlignment = .center
//        userAnswer.autocapitalizationType = .none
        return userAnswer
    }()
    
    private var newWordButton : UIButton = {
        let newWord = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        newWord.backgroundColor = .gray
        newWord.setTitle("Word", for: .normal)
        newWord.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        newWord.setTitleColor(.white, for: .normal)
        newWord.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        newWord.translatesAutoresizingMaskIntoConstraints = false
        newWord.layer.cornerRadius = 0.5 * newWord.bounds.width
        newWord.layer.shadowColor = UIColor.black.cgColor
        newWord.layer.shadowOpacity = 0.3
        newWord.layer.shadowOffset = .init(width: 1, height: 1)
        newWord.layer.shadowRadius = 5
        newWord.addTarget(self, action: #selector(generateWord), for: .touchUpInside)
        return newWord
    }()
    
    
    private var labelProssima : UILabel = {
        let labelProssima = UILabel()
        labelProssima.text = "Prossima parola in"
        labelProssima.font = FontKit.roundedFont(ofSize: 20, weight: .semibold)
        labelProssima.translatesAutoresizingMaskIntoConstraints = false
        labelProssima.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        labelProssima.textAlignment = .center
        return labelProssima
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpConstraints()
        setUpGestureForKeyboard()
        generateWord()
        timerView.onTap = {
            self.timerView.removeFromSuperview()
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.generateWord()
            })
        }
        // Do any additional setup after loading the view.
    }
    
    func setUpGestureForKeyboard(){
        let tap = UITapGestureRecognizer(target : view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setUpConstraintsTimeView(){
        view.addSubview(timerView)
        
        NSLayoutConstraint.activate([
  
            timerView.topAnchor.constraint(equalTo: labelProssima.bottomAnchor,constant: 150),
            timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerView.heightAnchor.constraint(equalToConstant: 100),
            timerView.widthAnchor.constraint(equalToConstant: 100),
   
        ])
        timerView.addShadowView2()
    }
    
    func setUpConstraints(){
        view.addSubview(lineVertical)
        view.addSubview(newWordButton)
        view.addSubview(newWordLabel)
        view.addSubview(userAnswer)
        view.addSubview(backButton)
        view.addSubview(whatRead)
        view.addSubview(labelProssima)
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
    
            lineVertical.topAnchor.constraint(equalTo: view.topAnchor),
            lineVertical.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            lineVertical.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineVertical.widthAnchor.constraint(equalToConstant: 1),
            
            
            newWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newWordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            newWordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            newWordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            whatRead.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            whatRead.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            whatRead.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            whatRead.bottomAnchor.constraint(equalTo: userAnswer.topAnchor, constant: -60),
            
            
         
            userAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userAnswer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userAnswer.heightAnchor.constraint(equalToConstant: 80),
            userAnswer.widthAnchor.constraint(equalToConstant: 300),
            
            labelProssima.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelProssima.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelProssima.heightAnchor.constraint(equalToConstant: 80),
            labelProssima.widthAnchor.constraint(equalToConstant: 300),
            
            
            newWordButton.topAnchor.constraint(equalTo: userAnswer.bottomAnchor,constant: 150),
            newWordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newWordButton.heightAnchor.constraint(equalToConstant: 100),
            newWordButton.widthAnchor.constraint(equalToConstant: 100),
            

            
        ])
    }
    
        
    @objc func generateWord(){
        
        if !generateWordOk {
            let string = randomString(length: Int(numberOfCharacthers)! )
            newWordLabel.text = string
            newWordLabel.isHidden = false
            self.userAnswer.isHidden = true
            lineVertical.isHidden = false
            newWordButton.isHidden = true
            self.whatRead.isHidden = true
            timerView.isHidden = true
            labelProssima.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now()+TimeInterval(Int(timeShow)!)/1000, execute: {
                self.newWordLabel.isHidden = true
                self.userAnswer.isHidden = false
                self.newWordButton.isHidden = false
                self.lineVertical.isHidden = true
                self.whatRead.isHidden = false
                self.whatRead.text = "Cosa hai Letto ?"
            })
            generateWordOk = true
        }else {
            if userAnswer.isEmpty {
//                addPopUp(text: "Inserisci una Risposta")
            }else {
                if userAnswer.text == newWordLabel.text{
                    // Inserisci un popUp che scrive corretto
//                    addPopUp(text: "Risposta Corretta")
                    self.userAnswer.isHidden = true
                    self.newWordButton.isHidden = true
                    self.whatRead.text = "Nice Work !"
                    self.userAnswer.text = ""
                    labelProssima.isHidden = false
                    setUpConstraintsTimeView()
                    timerView.goTimer()
                    generateWordOk = false
                    timerView.isHidden = false
                }else {
                    // Inserisci un popUp che scrive corretto
                    //                    addPopUp(text: "Risposta Sbagliata")
                    self.userAnswer.isHidden = true
                    self.newWordButton.isHidden = true
                    self.whatRead.text = "Try Next Time !"
                    self.userAnswer.text = ""
                    setUpConstraintsTimeView()
                    labelProssima.isHidden = false
                    generateWordOk = false
                    timerView.goTimer()
                    timerView.isHidden = false
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
    
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension UIViewController {
    func addPopUp(text : String){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            let popOverVC = PopUpViewController()
            popOverVC.suggestLabel.text = text
            self.view.addSubview(popOverVC)
        }
        
    }
}

//extension UIViewController {
//    func addPopUp(text : String){
//        let popOverVC = PopUpViewController()
//        self.addChild(popOverVC)
//        popOverVC.view.frame = self.view.frame
//        self.view.addSubview(popOverVC.view)
//        popOverVC.suggestLabel.text = text
//        popOverVC.didMove(toParent: self)
//    }
//}
