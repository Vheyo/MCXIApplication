//
//  ExerciseWithFormViewController.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 08/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class ExerciseWithFormViewController: UIViewController {
    private var start : CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
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
    var numeroParole = Int()
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height+400)
        
    private var formQA : UIView = {
        let formQA = UIView()
        formQA.translatesAutoresizingMaskIntoConstraints = false
        formQA.backgroundColor = .white
        return formQA
    }()
    
    private var backButton : UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17,weight: .regular)
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        backButton.titleLabel?.textAlignment = .left
        return backButton
    }()
    
    private var textToRead : UITextView = {
        let textToRead = UITextView()
        textToRead.translatesAutoresizingMaskIntoConstraints = false
        textToRead.text = "Leggi il dialogo e rispondi correttamente alle domande. Luca e Giovanni sono due amici che s'incontrano in strada per caso: Luca: Ciao GiovanniGiovanni: Ciao Luca, come stai?Luca: Bene grazie, anche se ho un po' di mal di schiena. E tu come stai?Giovanni: Bene. Ah mi dispiace per il tuo mal di schiena. Stai prendendo delle medicine?"
        textToRead.isEditable = false
        textToRead.isSelectable = false
        textToRead.textAlignment = .center
        textToRead.showsVerticalScrollIndicator = false
        return textToRead
    }()
    
    private var buttonPlay : UIButton = {
        let buttonPlay = UIButton()
        buttonPlay.setTitle("Done", for: .normal)
        buttonPlay.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        buttonPlay.setTitleColor(.white, for: .normal)
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.titleLabel?.font = FontKit.roundedFont(ofSize: 18, weight: .semibold)
        buttonPlay.layer.cornerRadius = 30
        buttonPlay.addTarget(self, action: #selector(playMode), for: .touchUpInside)
        return buttonPlay
    }()
    
    private var questionLabel : UILabel = {
        let questionLabel = UILabel()
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = "Qui devi mettere la domanda del testo ? "
        questionLabel.font = FontKit.roundedFont(ofSize: 36, weight: .black)
        questionLabel.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        questionLabel.textAlignment = .left
        questionLabel.numberOfLines = 0
        return questionLabel
    }()
    
    private var firstAnswer : UILabel = {
        let firstAnswer = UILabel()
        firstAnswer.translatesAutoresizingMaskIntoConstraints = false
        firstAnswer.text = "Qui devi mettere ladssadasfdfdsfdsdsa prima risposta"
        firstAnswer.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
        firstAnswer.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        firstAnswer.textAlignment = .left
        firstAnswer.numberOfLines = 0
        return firstAnswer
    }()
    
    private var secondAnswer : UILabel = {
        let secondAnswer = UILabel()
        secondAnswer.translatesAutoresizingMaskIntoConstraints = false
        secondAnswer.text = "Qui devi mettere la seconda risposta "
        secondAnswer.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
        secondAnswer.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        secondAnswer.textAlignment = .left
        secondAnswer.numberOfLines = 0
        return secondAnswer
    }()
    
    private var thirdAnswer : UILabel = {
        let thirdAnswer = UILabel()
        thirdAnswer.translatesAutoresizingMaskIntoConstraints = false
        thirdAnswer.text = "Qui devi mettere la terza risposta"
        thirdAnswer.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
        thirdAnswer.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        thirdAnswer.textAlignment = .left
        thirdAnswer.numberOfLines = 0
        return thirdAnswer
    }()
    
    private var fourthAnswer : UILabel = {
        let fourthAnswer = UILabel()
        fourthAnswer.translatesAutoresizingMaskIntoConstraints = false
        fourthAnswer.text = "Qui devi mettere la quarta risposta"
        fourthAnswer.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
        fourthAnswer.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        fourthAnswer.textAlignment = .left
        fourthAnswer.numberOfLines = 0
        return fourthAnswer
    }()
    
    private var radioButtonFirst : containerOfRadioButton = {
        let radioButtonFirst = containerOfRadioButton()
        radioButtonFirst.radioButton.isSelected = false
        radioButtonFirst.radioButton.tag = 0
        radioButtonFirst.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonFirst
    }()
    
    private var radioButtonSecond : containerOfRadioButton = {
        let radioButtonSecond = containerOfRadioButton()
        radioButtonSecond.radioButton.isSelected = false
        radioButtonSecond.radioButton.tag = 1
        radioButtonSecond.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonSecond
    }()
    
    private var radioButtonThird : containerOfRadioButton = {
        let radioButtonThird  = containerOfRadioButton()
        radioButtonThird.radioButton.isSelected = false
        radioButtonThird.radioButton.tag = 2
        radioButtonThird .translatesAutoresizingMaskIntoConstraints = false
        return radioButtonThird
    }()
    
    private var radioButtonFourth : containerOfRadioButton = {
        let radioButtonFourth = containerOfRadioButton()
        radioButtonFourth.radioButton.isSelected = false
        radioButtonFourth.radioButton.tag = 3
        radioButtonFourth.translatesAutoresizingMaskIntoConstraints = false
        return radioButtonFourth
    }()
    
    
    private var tempoLabel : UILabel = {
        let tempoLabel = UILabel()
        tempoLabel.translatesAutoresizingMaskIntoConstraints = false
        tempoLabel.font = FontKit.roundedFont(ofSize: 24, weight: .bold)
        tempoLabel.textAlignment = .center
        tempoLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        tempoLabel.text = "Time"
        return tempoLabel
    }()
    
    private var pamLabel : UILabel = {
        let pamLabel = UILabel()
        pamLabel.translatesAutoresizingMaskIntoConstraints = false
        pamLabel.font = FontKit.roundedFont(ofSize: 24, weight: .bold)
        pamLabel.textAlignment = .center
        pamLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        pamLabel.text = "WPM"
        return pamLabel
    }()
    
    private var crLabel : UILabel = {
        let crLabel = UILabel()
        crLabel.translatesAutoresizingMaskIntoConstraints = false
        crLabel.font = FontKit.roundedFont(ofSize: 24, weight: .bold)
        crLabel.textAlignment = .center
        crLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        crLabel.text = "Comprensione"
        return crLabel
    }()
    
    private var rendimentoLabel : UILabel = {
        let rendimentoLabel = UILabel()
        rendimentoLabel.translatesAutoresizingMaskIntoConstraints = false
        rendimentoLabel.font = FontKit.roundedFont(ofSize: 24, weight: .bold)
        rendimentoLabel.textAlignment = .center
        rendimentoLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        rendimentoLabel.text = "Rendimento"
        return rendimentoLabel
    }()
    
    private var tempoResultLabel : UILabel = {
        let tempoResultLabel = UILabel()
        tempoResultLabel.translatesAutoresizingMaskIntoConstraints = false
        tempoResultLabel.font = FontKit.roundedFont(ofSize: 20, weight: .medium)
        tempoResultLabel.textAlignment = .center
        tempoResultLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        return tempoResultLabel
    }()
    
    private var pamResultLabel : UILabel = {
        let pamResultLabel = UILabel()
        pamResultLabel.translatesAutoresizingMaskIntoConstraints = false
        pamResultLabel.font = FontKit.roundedFont(ofSize: 20, weight: .medium)
        pamResultLabel.textAlignment = .center
        pamResultLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        return pamResultLabel
    }()
    
    private var crResultLabel : UILabel = {
        let crResultLabel = UILabel()
        crResultLabel.translatesAutoresizingMaskIntoConstraints = false
        crResultLabel.font = FontKit.roundedFont(ofSize: 20, weight: .medium)
        crResultLabel.textAlignment = .center
        crResultLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        return crResultLabel
    }()
    
    private var rendimentoResultLabel : UILabel = {
        let rendimentoResultLabel = UILabel()
        rendimentoResultLabel.translatesAutoresizingMaskIntoConstraints = false
        rendimentoResultLabel.font = FontKit.roundedFont(ofSize: 20, weight: .medium)
        rendimentoResultLabel.textAlignment = .center
        rendimentoResultLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        rendimentoResultLabel.text = "Rendimento"
        return rendimentoResultLabel
    }()
    
    private let verticalStack1 : UIStackView = {
        let verticalStack1 = UIStackView()
        verticalStack1.axis = .vertical
        verticalStack1.translatesAutoresizingMaskIntoConstraints = false
        verticalStack1.distribution = .fillEqually
        return verticalStack1
    }()
    
    private let verticalStack2 : UIStackView = {
        let verticalStack2 = UIStackView()
        verticalStack2.axis = .vertical
        verticalStack2.translatesAutoresizingMaskIntoConstraints = false
        verticalStack2.distribution = .fillEqually
        return verticalStack2
    }()
    
    
    private let verticalStack3 : UIStackView = {
        let verticalStack3 = UIStackView()
        verticalStack3.axis = .vertical
        verticalStack3.translatesAutoresizingMaskIntoConstraints = false
        verticalStack3.distribution = .fillEqually
        return verticalStack3
    }()
    
    
    private let verticalStack4 : UIStackView = {
        let verticalStack4 = UIStackView()
        verticalStack4.axis = .vertical
        verticalStack4.translatesAutoresizingMaskIntoConstraints = false
        verticalStack4.distribution = .fillEqually
        return verticalStack4
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAlternateButton()
        setUpTextToRead()
        radioButtonFirst.onTap = {
            UIView.animate(withDuration: 0.2) {
                self.buttonPlay.alpha = 1
                self.buttonPlay.isEnabled = true
                if self.shadow == nil {
                    self.shadow = self.buttonPlay.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3.5, shadowOpacity: 0.4, offsetY: 3.5, offsetX: 0)
                }
                
                
            }
            
        }
        radioButtonSecond.onTap = {
            UIView.animate(withDuration: 0.5) {
                self.buttonPlay.alpha = 1
                self.buttonPlay.isEnabled = true
                self.buttonPlay.alpha = 1
                self.buttonPlay.isEnabled = true
                if self.shadow == nil {
                    self.shadow = self.buttonPlay.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3.5, shadowOpacity: 0.4, offsetY: 3.5, offsetX: 0)
                }
                
                
            }
            
        }
        radioButtonThird.onTap = {
            UIView.animate(withDuration: 0.5) {
                self.buttonPlay.alpha = 1
                self.buttonPlay.isEnabled = true
                self.buttonPlay.alpha = 1
                self.buttonPlay.isEnabled = true
                if self.shadow == nil {
                    self.shadow = self.buttonPlay.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3.5, shadowOpacity: 0.4, offsetY: 3.5, offsetX: 0)
                }
                

                
            }
        }
        radioButtonFourth.onTap = {
            UIView.animate(withDuration: 0.5) {
                self.buttonPlay.alpha = 1
                self.buttonPlay.isEnabled = true
                self.buttonPlay.alpha = 1
                self.buttonPlay.isEnabled = true
                if self.shadow == nil {
                     self.shadow = self.buttonPlay.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3.5, shadowOpacity: 0.4, offsetY: 3.5, offsetX: 0)
                }
               
            }
            
        }
    
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
            numeroParole = testo["NumeroParole"] as! Int
            
            firstAnswer.text = risposte_Array[0]
            secondAnswer.text = risposte_Array[1]
            thirdAnswer.text = risposte_Array[2]
            fourthAnswer.text = risposte_Array[3]
            
            let risposteEsatte_NSArray : NSArray = (testo["RisposteEsatte"] as? NSArray)!
            for elements in risposteEsatte_NSArray{
                let tmpInt = ((elements as! NSInteger) as Int)
                risposteEsatte_Array.append(tmpInt);
            }
            
            let attributeString = NSMutableAttributedString(string: textToRead.text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = 8
            
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, textToRead.text.count))
            
            textToRead.attributedText = attributeString
            textToRead.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
            textToRead.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
            textToRead.textAlignment = .center
            
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
        radioButtonFirst.radioButton.alternateButton = [radioButtonSecond.radioButton,radioButtonThird.radioButton,radioButtonFourth.radioButton]
        radioButtonSecond.radioButton.alternateButton = [radioButtonFirst.radioButton,radioButtonThird.radioButton,radioButtonFourth.radioButton]
        radioButtonThird.radioButton.alternateButton = [radioButtonSecond.radioButton,radioButtonFirst.radioButton,radioButtonFourth.radioButton]
        radioButtonFourth.radioButton.alternateButton = [radioButtonSecond.radioButton,radioButtonThird.radioButton,radioButtonFirst.radioButton]
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
        
        buttonPlay.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        buttonPlay.layer.masksToBounds = true
        buttonPlay.setGradientBackground(colorOne: #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), colorTwo: #colorLiteral(red: 0.3490196078, green: 0.3333333333, blue: 0.8274509804, alpha: 1), frame : CGRect(x: 0, y: 0, width: view.frame.width-120, height: 70), livello : 0)
        shadow = buttonPlay.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3.5, shadowOpacity: 0.4, offsetY: 3.5, offsetX: 0)
    }
    
    var shadow : ShadowView!
    
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
            
            
            formQA.topAnchor.constraint(equalTo: backButton.bottomAnchor,constant: 10),
            formQA.bottomAnchor.constraint(equalTo: buttonPlay.topAnchor, constant: -20),
            formQA.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            formQA.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            
            questionLabel.topAnchor.constraint(equalTo: formQA.topAnchor,constant: 30 ),
            questionLabel.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 30),
            questionLabel.trailingAnchor.constraint(equalTo: formQA.trailingAnchor,constant: -30),
            questionLabel.heightAnchor.constraint(equalToConstant: 200),
            
            
            radioButtonFirst.topAnchor.constraint(equalTo: questionLabel.bottomAnchor,constant: 30),
            radioButtonFirst.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 40),
            radioButtonFirst.heightAnchor.constraint(equalToConstant: 40),
            radioButtonFirst.widthAnchor.constraint(equalToConstant: 40),
            
            radioButtonSecond.topAnchor.constraint(equalTo: radioButtonFirst.bottomAnchor,constant: 30),
            radioButtonSecond.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 40),
            radioButtonSecond.heightAnchor.constraint(equalToConstant: 40),
            radioButtonSecond.widthAnchor.constraint(equalToConstant: 40),
            
            radioButtonThird.topAnchor.constraint(equalTo: radioButtonSecond.bottomAnchor,constant: 30),
            radioButtonThird.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 40),
            radioButtonThird.heightAnchor.constraint(equalToConstant: 40),
            radioButtonThird.widthAnchor.constraint(equalToConstant: 40),
            
            radioButtonFourth.topAnchor.constraint(equalTo: radioButtonThird.bottomAnchor,constant: 30),
            radioButtonFourth.leadingAnchor.constraint(equalTo: formQA.leadingAnchor,constant: 40),
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
        if radioButtonFirst.radioButton.oneSelected().0 {
            print("uno è selezionato ")
            //        cosicontrolli il bottone premuto
            print(radioButtonFirst.radioButton.oneSelected().1.tag)
            if radioButtonFirst.radioButton.oneSelected().1.tag == risposteEsatte_Array[questionIndex]{
                questionIndex += 1;
                 radioButtonFirst.radioButton.oneSelected().1.isSelected = false
                return true
               
            }
            questionIndex += 1
             radioButtonFirst.radioButton.oneSelected().1.isSelected = false
        return false
        
        }
        questionIndex += 1
         radioButtonFirst.radioButton.oneSelected().1.isSelected = false
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
            questionLabel.text = "Your Result!"
            questionLabel.textAlignment = .center
            firstAnswer.removeFromSuperview()
            secondAnswer.removeFromSuperview()
            thirdAnswer.removeFromSuperview()
            fourthAnswer.removeFromSuperview()
            radioButtonFirst.removeFromSuperview()
            radioButtonSecond.removeFromSuperview()
            radioButtonThird.removeFromSuperview()
            radioButtonFourth.removeFromSuperview()
            return questionIndex
        }
        
    }
    
    @objc func playMode(_ sender : UIButton){
        if numberCount == 0 {
            buttonPlay.alpha = 0.3
            shadow.removeFromSuperview()
            shadow = nil
            buttonPlay.isEnabled = false
            diff = CFAbsoluteTimeGetCurrent() - start
            textToRead.removeFromSuperview()
            buttonPlay.setTitle("Answer", for: .normal)
            setUpConstraints()
            numberCount = 2
        }
        else if numberCount == 2 {
            buttonPlay.alpha = 0.3
            shadow.removeFromSuperview()
            shadow = nil
            buttonPlay.isEnabled = false
            if(checkAnswer() == true){
                numberOfAnswerTrue+=1
            }
            if chargeNextQuestion() >= domande_Array.count{
                buttonPlay.isHidden = true
//                il pam si calcola come numero di parole del testo moltiplicate per 60 / diff
//                c a massimo è 100 quindi 100/risposteEsatteArray.count * numberOfQuestion
//                rendimento PAM*C/100
//                nel calcolo di pam sta il valore 1000 al posto di quello si deve mettere il numero di parole del testo
                let pam = ( Double(numeroParole) * 60 )/diff
                let comprensione : Double = Double((100*numberOfAnswerTrue)/risposteEsatte_Array.count)
                let rendimento = (pam*comprensione)/100
                
                
                tempoResultLabel.text = ("\(diff.rounded(.toNearestOrAwayFromZero))s")
                pamResultLabel.text =  ("\(pam.rounded(.toNearestOrAwayFromZero))")
                crResultLabel.text = ("\(comprensione.rounded(.toNearestOrAwayFromZero))")
                rendimentoResultLabel.text = ("\(rendimento.rounded(.toNearestOrAwayFromZero))")
                
                
                setUpConstraintsResult()
                
            }
            
        }
        
    }
    
    
    func setUpConstraintsResult(){
        view.addSubview(verticalStack1)
        view.addSubview(verticalStack2)
        view.addSubview(verticalStack3)
        view.addSubview(verticalStack4)
        
        verticalStack1.addArrangedSubview(tempoLabel)
        verticalStack1.addArrangedSubview(tempoResultLabel)
        verticalStack2.addArrangedSubview(pamLabel)
        verticalStack2.addArrangedSubview(pamResultLabel)
        verticalStack3.addArrangedSubview(crLabel)
        verticalStack3.addArrangedSubview(crResultLabel)
        verticalStack4.addArrangedSubview(rendimentoLabel)
        verticalStack4.addArrangedSubview(rendimentoResultLabel)
        
        
        
        NSLayoutConstraint.activate([
        
            verticalStack1.topAnchor.constraint(equalTo: questionLabel.bottomAnchor),
            verticalStack1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            verticalStack1.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            
            verticalStack2.topAnchor.constraint(equalTo: verticalStack1.bottomAnchor,constant: 30),
            verticalStack2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            verticalStack2.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            
            verticalStack3.topAnchor.constraint(equalTo: verticalStack2.bottomAnchor,constant: 30),
            verticalStack3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            verticalStack3.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            
            verticalStack4.topAnchor.constraint(equalTo: verticalStack3.bottomAnchor,constant: 30),
            verticalStack4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            verticalStack4.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            verticalStack4.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        
        ])
        
        
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    

}
