//
//  ExerciseWithFormViewController.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 08/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class ExerciseWithFormViewController: UIViewController {
    
    var numberCount : Int = 0

    private var formQA : UIView = {
        let formQA = UIView()
        formQA.translatesAutoresizingMaskIntoConstraints = false
        formQA.backgroundColor = .white
        return formQA
    }()
    
    private var textToRead : UITextView = {
        let textToRead = UITextView()
        textToRead.translatesAutoresizingMaskIntoConstraints = false
        textToRead.text = "Leggi il dialogo e rispondi correttamente alle domande. Luca e Giovanni sono due amici che s'incontrano in strada per caso: Luca: Ciao GiovanniGiovanni: Ciao Luca, come stai?Luca: Bene grazie, anche se ho un po' di mal di schiena. E tu come stai?Giovanni: Bene. Ah mi dispiace per il tuo mal di schiena. Stai prendendo delle medicine?"
        textToRead.isEditable = false
        return textToRead
    }()
    
    private var buttonPlay : UIButton = {
        let buttonPlay = UIButton()
        buttonPlay.setTitle("StartToRead", for: .normal)
        buttonPlay.backgroundColor = .gray
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.addTarget(self, action: #selector(playMode), for: .touchUpInside)
        return buttonPlay
    }()
    
    private var questionLabel : UILabel = {
        let questionLabel = UILabel()
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = "Qui devi mettere la domanda del testo ? "
        return questionLabel
    }()
    
    private var firstAnswer : UILabel = {
        let firstAnswer = UILabel()
        firstAnswer.translatesAutoresizingMaskIntoConstraints = false
        firstAnswer.text = "Qui devi mettere ladssadasfdfdsfdsdsa prima risposta"
        firstAnswer.numberOfLines = 0
        return firstAnswer
    }()
    
    private var secondAnswer : UILabel = {
        let secondAnswer = UILabel()
        secondAnswer.translatesAutoresizingMaskIntoConstraints = false
        secondAnswer.text = "Qui devi mettere la seconda risposta "
        secondAnswer.numberOfLines = 0
        return secondAnswer
    }()
    
    private var thirdAnswer : UILabel = {
        let thirdAnswer = UILabel()
        thirdAnswer.translatesAutoresizingMaskIntoConstraints = false
        thirdAnswer.text = "Qui devi mettere la terza risposta"
        thirdAnswer.numberOfLines = 0
        return thirdAnswer
    }()
    
    private var fourthAnswer : UILabel = {
        let fourthAnswer = UILabel()
        fourthAnswer.translatesAutoresizingMaskIntoConstraints = false
        fourthAnswer.text = "Qui devi mettere la quarta risposta"
        fourthAnswer.numberOfLines = 0
        return fourthAnswer
    }()
    
    private var radioButtonFirst : RadioButton = {
        let radioButtonFirst = RadioButton()
        radioButtonFirst.isSelected = false
        radioButtonFirst.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonFirst
    }()
    
    private var radioButtonSecond : RadioButton = {
        let radioButtonSecond = RadioButton()
        radioButtonSecond.isSelected = false
        radioButtonSecond.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonSecond
    }()
    
    private var radioButtonThird : RadioButton = {
        let radioButtonThird  = RadioButton()
        radioButtonThird.isSelected = false
        radioButtonThird .translatesAutoresizingMaskIntoConstraints = false
        return radioButtonThird
    }()
    
    private var radioButtonFourth : RadioButton = {
        let radioButtonFourth = RadioButton()
        radioButtonFourth.isSelected = false
        radioButtonFourth.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonFourth
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAlternateButton()
        setUpTextToRead()
//        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setUpAlternateButton(){
        radioButtonFirst.alternateButton = [radioButtonSecond,radioButtonThird,radioButtonFourth]
        radioButtonSecond.alternateButton = [radioButtonFirst,radioButtonThird,radioButtonFourth]
        radioButtonThird.alternateButton = [radioButtonSecond,radioButtonFirst,radioButtonFourth]
        radioButtonFourth.alternateButton = [radioButtonSecond,radioButtonThird,radioButtonFirst]
    }
    
    func setUpTextToRead(){
        self.view.addSubview(textToRead)
        self.view.addSubview(buttonPlay)
        NSLayoutConstraint.activate([
            textToRead.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textToRead.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textToRead.heightAnchor.constraint(equalToConstant: 400),
            textToRead.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            textToRead.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            
            buttonPlay.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            buttonPlay.heightAnchor.constraint(equalToConstant: 100),
            buttonPlay.widthAnchor.constraint(equalToConstant: 200),
            buttonPlay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -120)
        ])
    }
    
    func setUpConstraints(){
        self.view.addSubview(formQA)
        formQA.addSubview(questionLabel)
        formQA.addSubview(firstAnswer)
        formQA.addSubview(secondAnswer)
        formQA.addSubview(thirdAnswer)
        formQA.addSubview(fourthAnswer)
        formQA.addSubview(radioButtonFirst)
        formQA.addSubview(radioButtonSecond)
        formQA.addSubview(radioButtonThird)
        formQA.addSubview(radioButtonFourth)
        
        NSLayoutConstraint.activate([
        
        
            formQA.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            formQA.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            formQA.heightAnchor.constraint(equalToConstant: 400),
            formQA.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            formQA.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            questionLabel.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 10),
            questionLabel.trailingAnchor.constraint(equalTo: formQA.trailingAnchor,constant: -16),
            questionLabel.topAnchor.constraint(equalTo: formQA.topAnchor,constant: 10),
            
            radioButtonFirst.topAnchor.constraint(equalTo: questionLabel.bottomAnchor,constant: 16),
            radioButtonFirst.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 10),
            radioButtonFirst.heightAnchor.constraint(equalToConstant: 40),
            radioButtonFirst.widthAnchor.constraint(equalToConstant: 40),
            
            radioButtonSecond.topAnchor.constraint(equalTo: radioButtonFirst.bottomAnchor,constant: 16),
            radioButtonSecond.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 10),
            radioButtonSecond.heightAnchor.constraint(equalToConstant: 40),
            radioButtonSecond.widthAnchor.constraint(equalToConstant: 40),
            
            radioButtonThird.topAnchor.constraint(equalTo: radioButtonSecond.bottomAnchor,constant: 16),
            radioButtonThird.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 10),
            radioButtonThird.heightAnchor.constraint(equalToConstant: 40),
            radioButtonThird.widthAnchor.constraint(equalToConstant: 40),
            
            radioButtonFourth.topAnchor.constraint(equalTo: radioButtonThird.bottomAnchor,constant: 16),
            radioButtonFourth.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 10),
            radioButtonFourth.heightAnchor.constraint(equalToConstant: 40),
            radioButtonFourth.widthAnchor.constraint(equalToConstant: 40),
        
            firstAnswer.centerYAnchor.constraint(equalTo: radioButtonFirst.centerYAnchor),
            firstAnswer.leadingAnchor.constraint(equalTo: radioButtonFirst.trailingAnchor,constant:  10),
            firstAnswer.trailingAnchor.constraint(equalTo: formQA.trailingAnchor,constant: -16),
            
            secondAnswer.centerYAnchor.constraint(equalTo: radioButtonSecond.centerYAnchor),
            secondAnswer.leadingAnchor.constraint(equalTo: radioButtonSecond.trailingAnchor,constant:  10),
            secondAnswer.trailingAnchor.constraint(equalTo: formQA.trailingAnchor,constant: -16),
            
            thirdAnswer.centerYAnchor.constraint(equalTo: radioButtonThird.centerYAnchor),
            thirdAnswer.leadingAnchor.constraint(equalTo: radioButtonThird.trailingAnchor,constant:  10),
            thirdAnswer.trailingAnchor.constraint(equalTo: formQA.trailingAnchor,constant: -16),
            
            fourthAnswer.centerYAnchor.constraint(equalTo: radioButtonFourth.centerYAnchor),
            fourthAnswer.leadingAnchor.constraint(equalTo: radioButtonFourth.trailingAnchor,constant:  10),
            fourthAnswer.trailingAnchor.constraint(equalTo: formQA.trailingAnchor,constant: -16),
        
        ])
    }
    
    
    @objc func playMode(_ sender : UIButton){
        if numberCount == 0 {
            buttonPlay.setTitle("FineToRead", for: .normal)
            numberCount = 1
        } else if numberCount == 1 {
            textToRead.removeFromSuperview()
            buttonPlay.setTitle("Rispondi", for: .normal)
            setUpConstraints()
        }
        
    }

}
