//
//  FormCopriScopriViewController.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 08/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class FormCopriScopriViewController: UIViewController {

    var someValueTime: Int = 0 {
        didSet {
            timeTextField.text = "\(someValueTime)"
        }
    }
    
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

    
    private var timeTextField : UITextField = {
        var timeTextField = UITextField()
        timeTextField.translatesAutoresizingMaskIntoConstraints = false
        timeTextField.keyboardType = .numberPad
        timeTextField.placeholder = "400"
        timeTextField.borderStyle = .roundedRect
        return timeTextField
    }()
    
    private let stepper : UIView = {
        let stepper = UIView()
        stepper.backgroundColor = .white
        stepper.layer.borderColor = UIColor.lightGray.cgColor
        stepper.layer.borderWidth = 1
        stepper.layer.cornerRadius = 5
        return stepper
    }()
        
    private let charactersLabel : UILabel = {
        let charactersLabel = UILabel()
        charactersLabel.text = "Numero di caratteri"
        charactersLabel.translatesAutoresizingMaskIntoConstraints = false
        return charactersLabel
    }()
    
    private var charactersTextField : UITextField = {
        var charactersTextField = UITextField()
        charactersTextField.translatesAutoresizingMaskIntoConstraints = false
        charactersTextField.keyboardType = .numberPad
        charactersTextField.placeholder = "6"
        charactersTextField.borderStyle = .roundedRect
        charactersTextField.addTarget(self, action: #selector(controlFieldCharacters), for: .editingDidEnd)
        return charactersTextField
    }()
    
    private let buttonNumber : CheckBox = {
        let buttonNumber = CheckBox()
        buttonNumber.setTitle("Numbers", for: .normal)
        buttonNumber.tag = 1
        return buttonNumber
    }()
    
    private let buttonLettereMaisc : CheckBox = {
        let buttonLettereMaisc = CheckBox()
        buttonLettereMaisc.setTitle("Lower case letters", for: .normal)
        buttonLettereMaisc.tag = 2
        return buttonLettereMaisc
    }()
    
    private let buttonLettereMin : CheckBox = {
        let buttonLettereMin = CheckBox()
        buttonLettereMin.setTitle("Upper case letters", for: .normal)
        buttonLettereMin.tag = 3
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
        playButton.backgroundColor = .white
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        playButton.titleLabel?.textAlignment = .center
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private let separator : UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.layer.cornerRadius = 3
        return separator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpConstraints()
//        setUpStepperForTime()
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
            
            playButton.topAnchor.constraint(equalTo: stackHorizontalTime.bottomAnchor, constant: 50),
            playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            playButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            playButton.heightAnchor.constraint(equalToConstant: 42),
            
            separator.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            separator.topAnchor.constraint(equalTo: playButton.bottomAnchor,constant: 5),
            separator.widthAnchor.constraint(equalToConstant: 60),
            separator.heightAnchor.constraint(equalToConstant: 8)
            
            

        ])
    }
    
    @objc func play(){
        let copriScopriViewController = CopriScopriViewController()
        if !timeTextField.isEmpty{
            copriScopriViewController.timeShow = timeTextField.text!
        }
        if !charactersTextField.isEmpty{
            copriScopriViewController.numberOfCharacthers = charactersTextField.text!
        }
        
        if buttonNumber.isChecked || buttonLettereMaisc.isChecked || buttonLettereMin.isChecked {
            copriScopriViewController.numberSelected = buttonNumber.isChecked
            copriScopriViewController.maiuscSelected = buttonLettereMaisc.isChecked
            copriScopriViewController.minSelected = buttonLettereMin.isChecked
            navigationController?.pushViewController(copriScopriViewController, animated: true)
        }else {
            addPopUp(text: "Seleziona modalità")
        }
        
    }
    
    @objc func increaseTimeAction() {
        if Int(timeLabel.text!)! < 16{
            timeLabel.text = String(Int(timeLabel.text!)!+1)
        }
    }
    
    @objc func decreaseTimeAction() {
        if Int(timeLabel.text!)! > 5{
            timeLabel.text = String(Int(timeLabel.text!)!-1)
        }
    }
    @objc func controlFieldCharacters(_ sender : Any ){
        print(Int(charactersTextField.text!)!)
        if Int(charactersTextField.text!)! < 6 || Int(charactersTextField.text!)! > 15 {
            addPopUp(text: "Il range è tra 6 e 15")
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
