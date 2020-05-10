//
//  ExerciseWithFormViewController.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 08/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class ExerciseWithFormViewController: UIViewController {
    private var start : CFAbsoluteTime!
    private var diff : CFAbsoluteTime!
    var numberCount : Int = 0
    var numText : Int = numeroText
//    domande Array sono le stringhe delle domande
    var domande_Array = [String]()
// posizione risposte esatte
    var risposteEsatte_Array = [Int]()
// risposte array per ogni domanda
    var risposte_Array = [String]()
// numero di risposte esatte fatte dall'utente
    var numberOfAnswerTrue : Int = 0
    var questionIndex : Int = 0
    var answerIndex : Int = 4
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
        radioButtonFirst.tag = 0
        radioButtonFirst.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonFirst
    }()
    
    private var radioButtonSecond : RadioButton = {
        let radioButtonSecond = RadioButton()
        radioButtonSecond.isSelected = false
        radioButtonSecond.tag = 1
        radioButtonSecond.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonSecond
    }()
    
    private var radioButtonThird : RadioButton = {
        let radioButtonThird  = RadioButton()
        radioButtonThird.isSelected = false
        radioButtonThird.tag = 2
        radioButtonThird .translatesAutoresizingMaskIntoConstraints = false
        return radioButtonThird
    }()
    
    private var radioButtonFourth : RadioButton = {
        let radioButtonFourth = RadioButton()
        radioButtonFourth.isSelected = false
        radioButtonFourth.tag = 3
        radioButtonFourth.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonFourth
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAlternateButton()
        setUpTextToRead()
        //        setUpConstraints()
        // Do any additional setup after loading the view.
        let jsonResult = ExerciseWithFormViewController.readJSONFromFile(fileName: "TestiEsercizi") as AnyObject
        numText = numeroText
        do{
            let testo_Array : NSArray = (jsonResult["TestiEsercizi"] as? NSArray)!
            let testo : NSDictionary = testo_Array[numText] as! NSDictionary
            print("num text è \(numText)")
            let textToShow = testo["Testo"] as! NSString
            textToRead.text = textToShow as String
            let domande_NSArray = (testo["Domande"] as? NSArray)!
            for element in domande_NSArray{
                let tmpString = (element as! NSString) as String
                domande_Array.append(tmpString)
            }
            questionLabel.text = domande_Array[0]
            let risposte_NSArray : NSArray = (testo["Risposte"] as? NSArray)!
            for element in risposte_NSArray{
                let tmpString = (element as! NSString) as String
                risposte_Array.append(tmpString)
            }
            
            firstAnswer.text = risposte_Array[0]
            secondAnswer.text = risposte_Array[1]
            thirdAnswer.text = risposte_Array[2]
            fourthAnswer.text = risposte_Array[3]
            
            let risposteEsatte_NSArray : NSArray = (testo["RisposteEsatte"] as? NSArray)!
            for elements in risposteEsatte_NSArray{
                let tmpInt = ((elements as! NSInteger) as Int)
                risposteEsatte_Array.append(tmpInt);
            }
            
        }
        catch {
            print("json reading failed");
        }
        
    }
    
    static func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            } catch {
                // Handle error here
                print("FATAL ERROR")
            }
        }
        return json
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
    func checkAnswer() -> Bool{
        if radioButtonFirst.oneSelected().0 {
            print("uno è selezionato ")
            //        cosicontrolli il bottone premuto
            print(radioButtonFirst.oneSelected().1.tag)
            if radioButtonFirst.oneSelected().1.tag == risposteEsatte_Array[questionIndex]{
                questionIndex += 1;
                 radioButtonFirst.oneSelected().1.isSelected = false
                return true
               
            }
            questionIndex += 1
             radioButtonFirst.oneSelected().1.isSelected = false
        return false
        
        }
        questionIndex += 1
         radioButtonFirst.oneSelected().1.isSelected = false
        return false
    }
        
       
    
    func chargeNextQuestion() -> Int{
        if questionIndex < domande_Array.count{
           
            questionLabel.text = domande_Array[questionIndex]
            firstAnswer.text = risposte_Array[answerIndex]
            secondAnswer.text = risposte_Array[answerIndex+1];
            thirdAnswer.text = risposte_Array[answerIndex+2];
            fourthAnswer.text = risposte_Array[answerIndex+3];
        
            answerIndex += 4
            return questionIndex
        }
        else {
            questionLabel.text = "HAI FINITO L'ESERCIZIO"
            firstAnswer.isHidden = true
            secondAnswer.isHidden = true
            thirdAnswer.isHidden = true
            fourthAnswer.isHidden = true
            radioButtonFirst.isHidden = true
            radioButtonSecond.isHidden = true
            radioButtonThird.isHidden = true
            radioButtonFourth.isHidden = true
            return questionIndex
        }
        
    }
    
    @objc func playMode(_ sender : UIButton){
        if numberCount == 0 {
            start = CFAbsoluteTimeGetCurrent()
            buttonPlay.setTitle("FineToRead", for: .normal)
            numberCount = 1
        }
        else if numberCount == 1 {
            diff = CFAbsoluteTimeGetCurrent() - start
            textToRead.removeFromSuperview()
            buttonPlay.setTitle("Rispondi", for: .normal)
            setUpConstraints()
            numberCount = 2
        }
        else if numberCount == 2 {
            if(checkAnswer() == true){
                numberOfAnswerTrue+=1
               /*INCREMENTO DI UNA VARIABILE PER TENER TRACCIA DI QUANTE RISPOSTE ESATTE*/
            }
            if chargeNextQuestion() >= domande_Array.count{
                buttonPlay.isHidden = true
//                il pam si calcola come numero di parole del testo moltiplicate per 60 / diff
//                c a massimo è 100 quindi 100/risposteEsatteArray.count * numberOfQuestion
//                rendimento PAM*C/100
//                nel calcolo di pam sta il valore 1000 al posto di quello si deve mettere il numero di parole del testo
                let pam = ( 1000 * 60 )/diff
                let comprensione : Double = Double((100*numberOfAnswerTrue)/risposteEsatte_Array.count)
                let rendimento = (pam*comprensione)/100
//                QUello sotto poi non sara più utile era per vedere la stampa dei valori
                firstAnswer.isHidden = false
                secondAnswer.isHidden = false
                thirdAnswer.isHidden = false
                fourthAnswer.isHidden = false
                firstAnswer.text = ("\(diff)")
                secondAnswer.text = ("\(pam)")
                thirdAnswer.text = ("\(comprensione)")
                fourthAnswer.text = ("\(rendimento)")

                
            }
            
            
        }
        
    }
    

}
