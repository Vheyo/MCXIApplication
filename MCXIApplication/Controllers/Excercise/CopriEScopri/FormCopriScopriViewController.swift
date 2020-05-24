//
//  FormCopriScopriViewController.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 08/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class FormCopriScopriViewController: UIViewController {
    
  
    private let backButton : UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "Xviolet"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    private let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Choose at least one"
        descriptionLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = FontKit.roundedFont(ofSize: 27, weight: .bold)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private let descriptionLabelNumber : UILabel = {
        let descriptionLabelNumber = UILabel()
        descriptionLabelNumber.text = "number of characters"
        descriptionLabelNumber.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        descriptionLabelNumber.textAlignment = .center
        descriptionLabelNumber.font = FontKit.roundedFont(ofSize: 27, weight: .bold)
        descriptionLabelNumber.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabelNumber
    }()
    
    
    private let verticalStack : UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.backgroundColor = .red
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.distribution = .fillEqually
        return verticalStack
    }()
    
    private var buttonNumber : CheckBox = {
        let buttonNumber = CheckBox()
        buttonNumber.setTitle("Numbers", for: .normal)
        buttonNumber.tag = 1
        buttonNumber.addTarget(self, action: #selector(changeButtonStart), for: .touchUpInside)
        buttonNumber.titleLabel!.font = FontKit.roundedFont(ofSize: 22, weight: .semibold)
        return buttonNumber
    }()
    
    private var buttonLettereMaisc : CheckBox = {
        let buttonLettereMaisc = CheckBox()
        buttonLettereMaisc.setTitle("Upper case letters", for: .normal)
        buttonLettereMaisc.tag = 2
        buttonLettereMaisc.addTarget(self, action: #selector(changeButtonStart), for: .touchUpInside)
        buttonLettereMaisc.titleLabel!.font = FontKit.roundedFont(ofSize: 22, weight: .semibold)
        return buttonLettereMaisc
    }()
    
    private var buttonLettereMin : CheckBox = {
        let buttonLettereMin = CheckBox()
        buttonLettereMin.setTitle("Lower case letters", for: .normal)
        buttonLettereMin.tag = 3
        buttonLettereMin.addTarget(self, action: #selector(changeButtonStart), for: .touchUpInside)
        buttonLettereMin.titleLabel!.font = FontKit.roundedFont(ofSize: 22, weight: .semibold)
        return buttonLettereMin
    }()
    

    private var decreaseNumberOfWord : UIButton = {
        let decreaseNumberOfWord = UIButton()
        decreaseNumberOfWord.translatesAutoresizingMaskIntoConstraints = false
        decreaseNumberOfWord.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        decreaseNumberOfWord.setTitle("-", for: .normal)
        decreaseNumberOfWord.setTitleColor(.white, for: .normal)
        decreaseNumberOfWord.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        decreaseNumberOfWord.addTarget(self, action: #selector(decreaseWordAction), for: .touchUpInside)
        return decreaseNumberOfWord
    }()
    
    private var numberOfWordLabel : UILabel = {
        let numberOfWordLabel = UILabel()
        numberOfWordLabel.text = "6"
        numberOfWordLabel.textAlignment = .center
        numberOfWordLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        numberOfWordLabel.font = FontKit.roundedFont(ofSize: 17, weight: .light)
        numberOfWordLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberOfWordLabel
    }()
    
    private var increaseNumberOfWord : UIButton = {
        let increaseNumberOfWord = UIButton()
        increaseNumberOfWord.translatesAutoresizingMaskIntoConstraints = false
        increaseNumberOfWord.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        increaseNumberOfWord.setTitle("+", for: .normal)
        increaseNumberOfWord.setTitleColor(.white, for: .normal)
        increaseNumberOfWord.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        increaseNumberOfWord.addTarget(self, action: #selector(increaseWordAction), for: .touchUpInside)
        return increaseNumberOfWord
    }()
    
    private var stackHorizontalNumber : UIStackView = {
        let stackHorizontalNumber = UIStackView()
        stackHorizontalNumber.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontalNumber.axis = .horizontal
        stackHorizontalNumber.spacing = 27
        stackHorizontalNumber.distribution = .fillEqually
        return stackHorizontalNumber
    }()
    
    private var decreaseTime : UIButton = {
        let decreaseTime = UIButton()
        decreaseTime.translatesAutoresizingMaskIntoConstraints = false
        decreaseTime.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        decreaseTime.setTitle("-", for: .normal)
        decreaseTime.setTitleColor(.white, for: .normal)
        decreaseTime.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        decreaseTime.addTarget(self, action: #selector(decreaseTimeAction), for: .touchUpInside)
        return decreaseTime
    }()
    
    var timeLabel : UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "400 ms"
        timeLabel.textAlignment = .center
        timeLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        timeLabel.font = FontKit.roundedFont(ofSize: 17, weight: .light)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    private var increaseTime : UIButton = {
        let increaseTime = UIButton()
        increaseTime.translatesAutoresizingMaskIntoConstraints = false
        increaseTime.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        increaseTime.setTitle("+", for: .normal)
        increaseTime.setTitleColor(.white, for: .normal)
        increaseTime.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        increaseTime.addTarget(self, action: #selector(increaseTimeAction), for: .touchUpInside)
        return increaseTime
    }()
    
    private var stackHorizontalTime : UIStackView = {
        let stackHorizontalTime = UIStackView()
        stackHorizontalTime.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontalTime.axis = .horizontal
        stackHorizontalTime.spacing = 27
        stackHorizontalTime.distribution = .fillEqually
        return stackHorizontalTime
    }()
    
    private let playButton : UIButton = {
        let playButton  = UIButton()
        playButton.setTitle("Start", for: .normal)
        playButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        playButton.alpha = 0.3
        playButton.isEnabled = false
        playButton.backgroundColor = .white
        playButton.titleLabel?.font = FontKit.roundedFont(ofSize: 27, weight: .bold)
        playButton.titleLabel?.textAlignment = .center
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        return playButton
    }()
    
    private let separator : UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        separator.alpha = 0.3
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.layer.cornerRadius = 3
        return separator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        setUpGestureForKeyboard()
        setUpTargetButton()
        // Do any additional setup after loading the view.
    }
    
    func setUpGestureForKeyboard(){
        let tap = UITapGestureRecognizer(target : view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setUpTargetButton(){
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    func setUpConstraints(){
        view.addSubview(backButton)
        view.addSubview(descriptionLabel)
        view.addSubview(verticalStack)
        view.addSubview(stackHorizontalNumber)
        view.addSubview(stackHorizontalTime)
        verticalStack.addArrangedSubview(buttonNumber)
        verticalStack.addArrangedSubview(buttonLettereMin)
        verticalStack.addArrangedSubview(buttonLettereMaisc)
        
        stackHorizontalTime.addArrangedSubview(decreaseTime)
        stackHorizontalTime.addArrangedSubview(timeLabel)
        stackHorizontalTime.addArrangedSubview(increaseTime)
        stackHorizontalNumber.addArrangedSubview(decreaseNumberOfWord)
        stackHorizontalNumber.addArrangedSubview(numberOfWordLabel)
        stackHorizontalNumber.addArrangedSubview(increaseNumberOfWord)
        view.addSubview(playButton)
        view.addSubview(separator)
        view.addSubview(descriptionLabelNumber)
        verticalStack.spacing = 2.33*view.frame.height/100
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            backButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant:  -16),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 60),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            verticalStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 35),
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.widthAnchor.constraint(equalToConstant: 64*view.frame.size.width/100),
            verticalStack.heightAnchor.constraint(equalToConstant: 25.5*view.frame.size.height/100),
            
            stackHorizontalTime.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 35),
            stackHorizontalTime.heightAnchor.constraint(equalToConstant:7.6*view.frame.size.height/100),
            stackHorizontalTime.widthAnchor.constraint(equalToConstant: 63*view.frame.size.width/100),
            stackHorizontalTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            descriptionLabelNumber.topAnchor.constraint(equalTo: stackHorizontalTime.bottomAnchor, constant: 50),
            descriptionLabelNumber.heightAnchor.constraint(equalToConstant: 40),
            descriptionLabelNumber.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            descriptionLabelNumber.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            
            stackHorizontalNumber.topAnchor.constraint(equalTo: descriptionLabelNumber.bottomAnchor, constant: 25),
            stackHorizontalNumber.widthAnchor.constraint(equalToConstant: 63*view.frame.size.width/100),
            stackHorizontalNumber.heightAnchor.constraint(equalToConstant: 7.6*view.frame.size.height/100),
            stackHorizontalNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            playButton.topAnchor.constraint(equalTo: stackHorizontalNumber.bottomAnchor, constant: 5*view.frame.size.height/100),
            playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            playButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            playButton.heightAnchor.constraint(equalToConstant: 42),
            
            separator.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            separator.topAnchor.constraint(equalTo: playButton.bottomAnchor,constant: 5),
            separator.widthAnchor.constraint(equalToConstant: 60),
            separator.heightAnchor.constraint(equalToConstant: 4)
            
            
            
        ])
        
        decreaseNumberOfWord.frame = CGRect(x: 0, y: 0, width: 16*view.frame.size.width/100, height: 7.6*view.frame.size.height/100)
        decreaseNumberOfWord.layer.cornerRadius = 0.5 * decreaseNumberOfWord.frame.size.width
        
        increaseNumberOfWord.frame = CGRect(x: 0, y: 0, width: 16*view.frame.size.width/100, height: 7.6*view.frame.size.height/100)
        increaseNumberOfWord.layer.cornerRadius = 0.5 * increaseNumberOfWord.frame.size.width
        
        increaseTime.frame = CGRect(x: 0, y: 0, width: 16*view.frame.size.width/100, height: 7.6*view.frame.size.height/100)
        increaseTime.layer.cornerRadius = 0.5 * increaseTime.frame.size.width
        
        decreaseTime.frame = CGRect(x: 0, y: 0, width: 16*view.frame.size.width/100, height: 7.6*view.frame.size.height/100)
        decreaseTime.layer.cornerRadius = 0.5 * decreaseTime.frame.size.width
        
        buttonNumber.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 4, shadowOpacity: 0.3, offsetY: 4, offsetX: 0)
        buttonLettereMin.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 4, shadowOpacity: 0.3, offsetY: 4, offsetX: 0)
        buttonLettereMaisc.addShadowViewBest(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.5568627451, green: 0.4156862745, blue: 1, alpha: 1), shadowRadius: 4, shadowOpacity: 0.3, offsetY: 4, offsetX: 0)
        
        
    }
    
    @objc func changeButtonStart(){
        if buttonNumber.isChecked || buttonLettereMin.isChecked || buttonLettereMaisc.isChecked {
            playButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
            separator.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
            UIView.animate(withDuration: 0.4) {
                self.playButton.alpha = 1
                self.separator.alpha = 1
            }
            playButton.isEnabled = true
        } else {
            playButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
            UIView.animate(withDuration: 0.4) {
                self.separator.alpha = 0.3
                self.playButton.alpha = 0.3
            }

            playButton.isEnabled = false
        }
    }
    
    @objc func play(){
        let splitted =  timeLabel.text?.split(separator: " ")
        var time = Int(splitted![0])
        let copriScopriViewController = CopriScopriViewController()
        copriScopriViewController.timeShow = String(time!)
        copriScopriViewController.numberOfCharacthers = numberOfWordLabel.text!
        copriScopriViewController.numberSelected = buttonNumber.isChecked
        copriScopriViewController.maiuscSelected = buttonLettereMaisc.isChecked
        copriScopriViewController.minSelected = buttonLettereMin.isChecked
        copriScopriViewController.modalPresentationStyle = .fullScreen
        present(copriScopriViewController,animated: false)
               
    }
    
    @objc func increaseTimeAction() {
        let splitted =  timeLabel.text?.split(separator: " ")
        var time = Int(splitted![0])
        time = time! + 25
        timeLabel.text = "\(String(time!)) ms"
    }
    
    @objc func decreaseTimeAction() {
        let splitted =  timeLabel.text?.split(separator: " ")
        var time = Int(splitted![0])
        time = time! - 25
        timeLabel.text = "\(String(time!)) ms"
    }
    
    @objc func increaseWordAction(){
        if Int(numberOfWordLabel.text!)! < 16{
            numberOfWordLabel.text = String(Int(numberOfWordLabel.text!)!+1)
        }
    }
    
    @objc func decreaseWordAction(){
        if Int(numberOfWordLabel.text!)! > 5{
            numberOfWordLabel.text = String(Int(numberOfWordLabel.text!)!-1)
        }
        
    }
        
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension UITextField {
    
    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty {
            return false
        }
        return true
    }
}
