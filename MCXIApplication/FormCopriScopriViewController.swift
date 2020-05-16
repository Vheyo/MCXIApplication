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
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 25)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    
    private let verticalStack : UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.backgroundColor = .red
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.spacing = 20
        verticalStack.distribution = .fillEqually
        return verticalStack
    }()
    
    private var buttonNumber : CheckBox = {
        let buttonNumber = CheckBox()
        buttonNumber.setTitle("Numbers", for: .normal)
        buttonNumber.tag = 1
        buttonNumber.addTarget(self, action: #selector(changeButtonStart), for: .touchUpInside)
        return buttonNumber
    }()
    
    private var buttonLettereMaisc : CheckBox = {
        let buttonLettereMaisc = CheckBox()
        buttonLettereMaisc.setTitle("Lower case letters", for: .normal)
        buttonLettereMaisc.tag = 2
        buttonLettereMaisc.addTarget(self, action: #selector(changeButtonStart), for: .touchUpInside)
        return buttonLettereMaisc
    }()
    
    private var buttonLettereMin : CheckBox = {
        let buttonLettereMin = CheckBox()
        buttonLettereMin.setTitle("Upper case letters", for: .normal)
        buttonLettereMin.tag = 3
        buttonLettereMin.addTarget(self, action: #selector(changeButtonStart), for: .touchUpInside)
        return buttonLettereMin
    }()
    

    private var decreaseNumberOfWord : UIButton = {
        let decreaseNumberOfWord = UIButton()
        decreaseNumberOfWord.translatesAutoresizingMaskIntoConstraints = false
        decreaseNumberOfWord.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        decreaseNumberOfWord.setTitle("-", for: .normal)
        decreaseNumberOfWord.setTitleColor(.white, for: .normal)
        decreaseNumberOfWord.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        decreaseNumberOfWord.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        decreaseNumberOfWord.layer.cornerRadius = 0.5 * decreaseNumberOfWord.bounds.size.width
        decreaseNumberOfWord.addTarget(self, action: #selector(decreaseWordAction), for: .touchUpInside)
        return decreaseNumberOfWord
    }()
    
    private var numberOfWordLabel : UILabel = {
        let numberOfWordLabel = UILabel()
        numberOfWordLabel.text = "6"
        numberOfWordLabel.textAlignment = .center
        numberOfWordLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        numberOfWordLabel.font = UIFont.systemFont(ofSize: 18)
        numberOfWordLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberOfWordLabel
    }()
    
    private var increaseNumberOfWord : UIButton = {
        let increaseNumberOfWord = UIButton()
        increaseNumberOfWord.translatesAutoresizingMaskIntoConstraints = false
        increaseNumberOfWord.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        increaseNumberOfWord.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        increaseNumberOfWord.setTitle("+", for: .normal)
        increaseNumberOfWord.setTitleColor(.white, for: .normal)
        increaseNumberOfWord.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        increaseNumberOfWord.layer.cornerRadius = 0.5 * increaseNumberOfWord.bounds.size.width
        increaseNumberOfWord.addTarget(self, action: #selector(increaseWordAction), for: .touchUpInside)
        return increaseNumberOfWord
    }()
    
    private var stackHorizontalNumber : UIStackView = {
        let stackHorizontalNumber = UIStackView()
        stackHorizontalNumber.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontalNumber.axis = .horizontal
        stackHorizontalNumber.spacing = 30
        stackHorizontalNumber.distribution = .fillEqually
        return stackHorizontalNumber
    }()
    
    private var decreaseTime : UIButton = {
        let decreaseTime = UIButton()
        decreaseTime.translatesAutoresizingMaskIntoConstraints = false
        decreaseTime.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        decreaseTime.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        decreaseTime.setTitle("-", for: .normal)
        decreaseTime.setTitleColor(.white, for: .normal)
        decreaseTime.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        decreaseTime.layer.cornerRadius = 0.5 * decreaseTime.bounds.size.width
        decreaseTime.addTarget(self, action: #selector(decreaseTimeAction), for: .touchUpInside)
        return decreaseTime
    }()
    
    var timeLabel : UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "400 ms"
        timeLabel.textAlignment = .center
        timeLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        timeLabel.font = UIFont.systemFont(ofSize: 18)
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
        increaseTime.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        increaseTime.layer.cornerRadius = 0.5 * increaseTime.bounds.size.width
        increaseTime.addTarget(self, action: #selector(increaseTimeAction), for: .touchUpInside)
        return increaseTime
    }()
    
    private var stackHorizontalTime : UIStackView = {
        let stackHorizontalTime = UIStackView()
        stackHorizontalTime.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontalTime.axis = .horizontal
        stackHorizontalTime.spacing = 30
        stackHorizontalTime.distribution = .fillEqually
        return stackHorizontalTime
    }()
    
    private let playButton : UIButton = {
        let playButton  = UIButton()
        playButton.setTitle("Start", for: .normal)
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        playButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        playButton.alpha = 0.3
        playButton.isEnabled = false
        playButton.backgroundColor = .white
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
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
        buttonNumber.addShadowView()
        buttonLettereMaisc.addShadowView()
        buttonLettereMin.addShadowView()
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
            verticalStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80),
            verticalStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -80),
            verticalStack.heightAnchor.constraint(equalToConstant: 250),
            
            stackHorizontalNumber.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 35),
            stackHorizontalNumber.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
            stackHorizontalNumber.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
            stackHorizontalNumber.heightAnchor.constraint(equalToConstant: 80),
            
            stackHorizontalTime.topAnchor.constraint(equalTo: stackHorizontalNumber.bottomAnchor, constant: 35),
            stackHorizontalTime.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
            stackHorizontalTime.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
            stackHorizontalTime.heightAnchor.constraint(equalToConstant: 80),
            
            playButton.topAnchor.constraint(equalTo: stackHorizontalTime.bottomAnchor, constant: 80),
            playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            playButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            playButton.heightAnchor.constraint(equalToConstant: 42),
            
            separator.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            separator.topAnchor.constraint(equalTo: playButton.bottomAnchor,constant: 5),
            separator.widthAnchor.constraint(equalToConstant: 60),
            separator.heightAnchor.constraint(equalToConstant: 4)
            
            
            
        ])
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
        present(copriScopriViewController,animated: true)
               
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
