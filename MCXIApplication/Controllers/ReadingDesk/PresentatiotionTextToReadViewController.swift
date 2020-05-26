//
//  PresentatiotionTextToReadViewController.swift
//  Ready
//
//  Created by Astroworld on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

protocol dropUpProtocolChangeVal : class {
    func dropUpPressed(tagButton : Int)
}

class PresentatiotionTextToReadViewController: UIViewController, UIGestureRecognizerDelegate, dropUpProtocolChangeVal {
    
    
    func dropUpPressed(tagButton: Int) {
        
        switch tagButton {
        case 1:
            deleteTimer()
            let value = Int(dropUpButtonTime.currentTitle!)
            initialTimer = value!
            hideFunction()
            startToRead(gesture: UITapGestureRecognizer())
        case 2:
            
            deleteTimer()
            let value = Int(dropDownButtonTime.currentTitle!)
            if dropUpButtonTime.currentTitle != "N"{
                Pam = (60/Float(value!*100))*Float(Int(dropUpButtonTime.currentTitle!)!)
            }
            else{
                Pam = 60/Float(value!*100)
            }
            hideFunction()
            startToRead(gesture: UITapGestureRecognizer())
        default:
            print("No one selected")
            
        }
    }
    
    
    private var timerView : TimerView = {
        let timerView = TimerView()
        timerView.translatesAutoresizingMaskIntoConstraints = false
        return timerView
    }()
    
    var textSplitted = [String]()
    var textSplittedWithSpace = [String]()
    var indexWord = 0
    var hidden = true
    var Pam = Float()
    var text = String()
    var timer = Timer()
    var reading = true
    var nameFile = String()
    var initialTimer = 2
    var initialIndex = 0
    var endIndex = 0
    private var textTitle : UILabel = {
        let textTitle = UILabel()
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        textTitle.text = " Tap To Start Reading "
        textTitle.textAlignment = .center
        textTitle.font = FontKit.roundedFont(ofSize: 18, weight: .regular)
        textTitle.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        return textTitle
    }()
    
    var textToRead : UILabel = {
        let textToRead = UILabel()
        textToRead.translatesAutoresizingMaskIntoConstraints = false
        textToRead.font = FontKit.roundedFont(ofSize: 24, weight: .regular)
        textToRead.alpha = 0
        textToRead.textAlignment = .center
        textToRead.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        return textToRead
    }()
    
    private var playButton : UIButton = {
        let playButton = UIButton(type: .custom)
        //        playButton.setTitle("B", for: .normal)
        //        playButton.setTitleColor(UIColor.white, for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.borderColor = UIColor.black.cgColor
        playButton.layer.borderWidth = 0
        playButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        playButton.layer.cornerRadius = 0.5 * playButton.bounds.size.width
        playButton.clipsToBounds = true
        playButton.alpha = 0.0
        //        playButton.setBackgroundImage(UIImage(named: "ButtonCircle"), for: .normal)
        playButton.setImage(UIImage(named: "Play-1"), for: .normal)
        playButton.addTarget(self, action: #selector(gestioneTimer(button:)), for: .touchUpInside)
        return playButton
    }()
    
    private var backButton : UIButton = {
        let backButton = UIButton(type: .custom)
        //        backButton.setTitle("P", for: .normal)
        //        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.layer.borderWidth = 0
        backButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        backButton.layer.cornerRadius = 0.5 * backButton.bounds.size.width
        backButton.clipsToBounds = true
        backButton.alpha = 0.0
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        //        backButton.setBackgroundImage(UIImage(named: "ButtonCircle"), for: .normal)
        backButton.setImage(UIImage(named: "Previous-1"), for: .normal)
        return backButton
    }()
    
    private var forwardButton : UIButton = {
        let forwardButton = UIButton(type: .custom)
        //        forwardButton.setTitle("F", for: .normal)
        //        forwardButton.setTitleColor(UIColor.white, for: .normal)
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.layer.borderColor = UIColor.black.cgColor
        forwardButton.layer.borderWidth = 0
        forwardButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        forwardButton.layer.cornerRadius = 0.5 * forwardButton.bounds.size.width
        forwardButton.clipsToBounds = true
        forwardButton.alpha = 0.0
        //        forwardButton.setBackgroundImage(UIImage(named: "ButtonCircle"), for: .normal)
        forwardButton.setImage(UIImage(named: "Forward-1"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardAction), for: .touchUpInside)
        return forwardButton
    }()
    
    
    private var dropUpButtonTime : DropUpButton = {
        let dropUpButtonTime = DropUpButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        dropUpButtonTime.setTitle("N", for: .normal)
        dropUpButtonTime.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        dropUpButtonTime.translatesAutoresizingMaskIntoConstraints = false
        dropUpButtonTime.layer.borderColor = UIColor.black.cgColor
        dropUpButtonTime.layer.borderWidth = 2
        dropUpButtonTime.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        dropUpButtonTime.layer.cornerRadius = 0.5 * dropUpButtonTime.bounds.size.width
        dropUpButtonTime.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        dropUpButtonTime.clipsToBounds = true
        dropUpButtonTime.tag = 1
        dropUpButtonTime.alpha = 0.0
        dropUpButtonTime.backgroundColor = .white
        dropUpButtonTime.titleLabel?.font = FontKit.roundedFont(ofSize: 20, weight: .semibold)
        return dropUpButtonTime
    }()
    
    private var dropDownButtonTime : DropUpButton = {
        let dropDownButtonTime = DropUpButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        dropDownButtonTime.setTitle("WPM", for: .normal)
        dropDownButtonTime.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        dropDownButtonTime.translatesAutoresizingMaskIntoConstraints = false
        dropDownButtonTime.layer.borderColor = UIColor.black.cgColor
        dropDownButtonTime.layer.borderWidth = 2
        dropDownButtonTime.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        dropDownButtonTime.layer.cornerRadius = 0.5 * dropDownButtonTime.bounds.size.width
        dropDownButtonTime.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        dropDownButtonTime.clipsToBounds = true
        dropDownButtonTime.tag = 2
        dropDownButtonTime.alpha = 0.0
        dropDownButtonTime.backgroundColor = .white
        dropDownButtonTime.titleLabel?.font = FontKit.roundedFont(ofSize: 20, weight: .semibold)
        return dropDownButtonTime
    }()
    
    
    private var backButtonView : UIButton = {
        let backButtonView = UIButton()
        backButtonView.setTitle("Back", for: .normal)
        backButtonView.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        backButtonView.alpha = 0.0
        return backButtonView
    }()
    
    
    private var keywordButton : UIButton = {
        let keywordButton = UIButton()
        keywordButton.translatesAutoresizingMaskIntoConstraints = false
        keywordButton.setTitle("Keywords", for: .normal)
        keywordButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        keywordButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        //        keywordButton.addTarget(self, action: #selector(showText), for: .touchUpInside)
        keywordButton.titleLabel?.textAlignment = .center
        keywordButton.titleLabel?.textAlignment = .left
        keywordButton.layer.borderWidth = 2
        keywordButton.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        keywordButton.layer.cornerRadius = 25
        keywordButton.backgroundColor = .white
        keywordButton.addTarget(self, action: #selector(addKeyword), for: .touchUpInside)
        keywordButton.alpha = 0.0
        keywordButton.titleLabel?.font = FontKit.roundedFont(ofSize: 20, weight: .semibold)
        return keywordButton
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.landscape)
        setUpGesture()
        setUpConstraintsButton()
        setUpText()
        dropUpButtonTime.delegate = self
        dropDownButtonTime.delegate = self
        view.backgroundColor = .white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.landscape,andRotateTo: .landscapeLeft)
        
    }
    
    
    @objc func addKeyword(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        
        var arrayString = UserDefaults.standard.stringArray(forKey: "\(nameFile)")
        if dropUpButtonTime.currentTitle != "N"{
            if arrayString == nil {
                arrayString = ["\(textSplitted[endIndex-1])"]
            }
            else{
                arrayString?.append(textSplitted[endIndex-1])
                
            }
            print(arrayString)
        }
        else {
            if arrayString == nil {
                arrayString = ["\(textSplitted[indexWord-1])"]
            }
            else{
                arrayString?.append(textSplitted[indexWord-1])
                
            }
        }
        
        
        UserDefaults.standard.set(arrayString, forKey: "\(nameFile)")
        print(nameFile)
        //        print(UserDefaults.standard.stringArray(forKey: "\(nameFile)"))
        
        
        
        
        
        
    }
    
    func activateTimer(){
        reading = true
        if dropUpButtonTime.currentTitle != "N"{
            self.initialTimer = indexWord+Int(dropUpButtonTime.currentTitle!)!
            self.initialIndex = indexWord
            self.endIndex = indexWord+Int(dropUpButtonTime.currentTitle!)!
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(Pam), repeats: true, block: { timer in
                
                var range = 0...1
                
                if self.endIndex >= self.textSplitted.count-1{
                    if self.initialIndex > self.textSplitted.count-1{
                        range = (self.textSplitted.count-2...self.textSplitted.count-1)
                    } else {
                        range = self.initialIndex...self.textSplitted.count-1
                    }
                }
                else if self.initialIndex == self.endIndex{
                    print("SONO UGUALI")
                    range = self.initialIndex-1...self.endIndex
                }
                else {
                    range = self.initialIndex...self.endIndex
                }
                
                
                let textToShowSlice = self.textSplitted[range]
                var textToShow = String()
                for element in textToShowSlice {
                    textToShow.append(element)
                    textToShow.append(" ")
                }
                
                
                let myMutableString = NSMutableAttributedString(string: textToShow as String, attributes: [NSAttributedString.Key.font:FontKit.roundedFont(ofSize: 24, weight: .semibold)])
                var (startingIndex, lenghtIndex) = String(textToShow).findMiddle()
                
                
                
                //MARK: FOR VALENTINO <3<3<3<3<3<3
                
                
                
                if(textToShow.middle.contains(" ") || textToShow.middle.contains(",") || textToShow.middle.contains(".") || textToShow.middle.contains(", ") || textToShow.middle.contains(" ,")) {
                    startingIndex += 1;
                }
                
                print("[\(textToShow)]")
                print("[\(textToShow.middle)]")
                
                print(range)
                print(startingIndex)
                print(lenghtIndex)
                if startingIndex >= textToShow.count-1 {
                    startingIndex = 1
                    lenghtIndex = -1
                }
                //**********************************
                
                
                //Ho commentato il colore per renderlo più facilmente testabile
                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 104/255, green: 72/255, blue: 239/255, alpha: 1.0), range: NSRange(location: (startingIndex),length: lenghtIndex+1))
                
                self.textToRead.attributedText = myMutableString
                self.initialTimer = self.initialTimer+Int(self.dropUpButtonTime.currentTitle!)!
                self.initialIndex = self.initialIndex+Int(self.dropUpButtonTime.currentTitle!)!
                self.endIndex = self.endIndex+Int(self.dropUpButtonTime.currentTitle!)!
            })
            
            
            
        }
        else {
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(Pam), repeats: true, block: { timer in
                let myMutableString = NSMutableAttributedString(string: self.textSplitted[self.indexWord] as String, attributes: [NSAttributedString.Key.font:FontKit.roundedFont(ofSize: 24, weight: .semibold)])
                var (startingIndex, lenghtIndex) = String(self.textSplitted[self.indexWord]).findMiddle()
                if startingIndex < 0 {
                    startingIndex = 1
                    lenghtIndex = -1
                              }
                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 104/255, green: 72/255, blue: 239/255, alpha: 1.0), range: NSRange(location: (startingIndex),length: lenghtIndex+1))
                self.textToRead.attributedText = myMutableString
                if self.indexWord < self.textSplitted.count - 1 {
                    self.indexWord += 1
                }
            })
        }
    }
    
    func deleteTimer(){
        timer.invalidate()
        print("non sto leggendo")
        reading = false
    }
    
    @objc func gestioneTimer(button : UIButton){
        if reading == true {
            print(reading)
            deleteTimer()
        }
        else if reading == false {
            print(reading)
            startToRead(gesture: UITapGestureRecognizer())
            hideFunction()
        }
        
    }
    
    
    
    @objc func backAction(){
        
        
        if self.indexWord > 0 {
            indexWord -= 1
        }
        self.textToRead.text = textSplitted[indexWord]
        
        
        
        
        
        
        
    }
    
    @objc func forwardAction(){
        
        if self.indexWord < self.textSplitted.count - 1 {
            indexWord += 1
        }
        self.textToRead.text = textSplitted[indexWord]
        
        
        
        
        
        
    }
    
    
    func setUpText(){
        let myText = text.components(separatedBy:  [" ", "\n"])
        
        for element in myText {
            textSplitted.append(String(element))
            textSplittedWithSpace.append(String(element))
            textSplittedWithSpace.append(" ")
        }
        Pam = (60/120)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait,andRotateTo: .portrait)
    }
    
    func setUpGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startToRead))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print(touch.view == gestureRecognizer.view)
        return touch.view == gestureRecognizer.view
    }
    
    @objc func startToRead(gesture:UITapGestureRecognizer){
        view.removeGestureRecognizer(gesture)
        textTitle.alpha = 0
        var timervalue = 3
        self.timerView.labelTime.text = "\(timervalue)"
        setUpConstraintsTimeView()
        self.textToRead.alpha = 0.0
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        dropUpButtonTime.isEnabled = false
        dropDownButtonTime.isEnabled = false
        playButton.isEnabled = false
        keywordButton.isEnabled = false
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {timer in
            self.timerView.labelTime.text = "\(timervalue-1)"
            timervalue -= 1
            if timervalue < 0 {
                timer.invalidate()
                let hideGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideFunction))
                hideGesture.cancelsTouchesInView = false
                hideGesture.delegate = self
                self.view.addGestureRecognizer(hideGesture)
                self.textToRead.alpha = 1.0
                self.backButton.isEnabled = true
                self.forwardButton.isEnabled = true
                self.dropUpButtonTime.isEnabled = true
                self.dropDownButtonTime.isEnabled = true
                self.playButton.isEnabled = true
                self.keywordButton.isEnabled = true
                self.activateTimer()
                self.timerView.removeFromSuperview()
            }
        })
    }
    
    func setUpConstraintsTimeView(){
        view.addSubview(timerView)
        
        NSLayoutConstraint.activate([
            
            timerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            timerView.heightAnchor.constraint(equalToConstant: 100),
            timerView.widthAnchor.constraint(equalToConstant: 100),
            
        ])
        
        
        timerView.addShadowView2()
    }
    
    var shadowDropUpButtonTime : ShadowView!
    var shadowDropDownButtonTime : ShadowView!
    var shadowKeywordButton : ShadowView!
    
    
    @objc func hideFunction(){
        //        if hidden == false && (!dropDownButtonTime.isOpen && !dropUpButtonTime.isOpen) {
        if !hidden {
            if (!dropDownButtonTime.isOpen && !dropUpButtonTime.isOpen) {
                UIView.animate(withDuration: 0.1, animations: {
                    self.backButtonView.alpha = 0.0
                    self.dropUpButtonTime.alpha = 0.0
                    self.dropDownButtonTime.alpha = 0.0
                    self.textTitle.alpha = 0.0
                    self.playButton.alpha = 0.0
                    self.forwardButton.alpha = 0.0
                    self.backButton.alpha = 0.0
                    self.keywordButton.alpha = 0.0
                    self.shadowDropUpButtonTime.removeFromSuperview()
                    self.shadowDropDownButtonTime.removeFromSuperview()
                    self.shadowKeywordButton.removeFromSuperview()
                    
                    
                }, completion: {_ in self.hidden = true})
            }
            
        }
        else{
            UIView.animate(withDuration: 0.1, animations: {
                self.backButtonView.alpha = 1.0
                self.dropUpButtonTime.alpha = 1.0
                self.dropDownButtonTime.alpha = 1.0
                //                self.textTitle.alpha = 1.0
                self.playButton.alpha = 1.0
                self.forwardButton.alpha = 1.0
                self.backButton.alpha = 1.0
                self.keywordButton.alpha = 1.0
                self.shadowDropUpButtonTime = self.dropUpButtonTime.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 3, shadowOpacity: 0.3, offsetY: 3, offsetX: 0)
                self.shadowDropDownButtonTime = self.dropDownButtonTime.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 3, shadowOpacity: 0.3, offsetY: 3, offsetX: 0)
                self.shadowKeywordButton = self.keywordButton.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 3, shadowOpacity: 0.3, offsetY: 3, offsetX: 0)
                
                
                self.deleteTimer()
            },completion: {_ in self.hidden = false})
        }
        
        
        
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
        self.view.addSubview(keywordButton)
        
        backButtonView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            textTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            textTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            textTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textTitle.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            textToRead.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textToRead.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textToRead.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textToRead.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            backButtonView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            backButtonView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButtonView.heightAnchor.constraint(equalToConstant: 50),
            backButtonView.widthAnchor.constraint(equalToConstant: 70),
            
            dropDownButtonTime.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 20),
            dropDownButtonTime.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dropDownButtonTime.heightAnchor.constraint(equalToConstant: 60),
            dropDownButtonTime.widthAnchor.constraint(equalToConstant: 60),
            
            playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -20),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            
            
            backButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -20),
            backButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            
            forwardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -20),
            forwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20),
            forwardButton.heightAnchor.constraint(equalToConstant: 60),
            forwardButton.widthAnchor.constraint(equalToConstant: 60),
            
            dropUpButtonTime.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -20),
            dropUpButtonTime.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dropUpButtonTime.heightAnchor.constraint(equalToConstant: 60),
            dropUpButtonTime.widthAnchor.constraint(equalToConstant: 60),
            
            keywordButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            keywordButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            keywordButton.widthAnchor.constraint(equalToConstant: 130),
            keywordButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    @objc func dismissView(){
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}



extension String{
    func findMiddle() -> (Int, Int) {
        let count = self.count;
        var start = 0;
        var end = 0;
        
        switch count{
        case 1:
            return (0,0);
        case 2:
            return (0, 1);
        default:
            if((self.count % 2) == 0){
                //Se pari
                start = (self.count/2 - 1)
                end = 1
            }
            else{
                start = self.count/2
                end = 0
            }
        }
        return (start, end)
    }
}

extension StringProtocol {
    var middle: SubSequence {
        if isEmpty { return "" }
        if count == 1 { return  self[startIndex...startIndex] }
        let middleIndex = index(startIndex, offsetBy: count/2)
        let previous = index(before: middleIndex)
        return count % 2 == 0 ? self[previous...middleIndex] : self[middleIndex...middleIndex]
    }
}

extension UILabel{
    
    func alwaysCenterCharacters(subStirng: String, viewToCenter: UIView){
        self.frame.origin = viewToCenter.center
        let range: NSRange = (self.text! as NSString).range(of: String(subStirng))
        let prefix = (self.text! as NSString).substring(to: range.location)//"Good,Morning".substring(to: range.location)
        let size: CGSize = prefix.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)])
        let p = CGPoint(x: size.width , y: 0)
        print("p.x: \(p.x)")
        print("p.y: \(p.y)")
        
        self.frame = CGRect(x: self.frame.minX - p.x, y: self.frame.minY - p.y, width: self.frame.width, height: self.frame.height)
    }
}
