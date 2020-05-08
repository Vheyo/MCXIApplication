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
        
    private let timeLabel : UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "Tempo di Visualizzazione (ms)"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
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
    
    private var increaseVal : UIButton = {
        var increaseVal = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        increaseVal.addTarget(self, action: #selector(increase), for: .touchUpInside)
        increaseVal.setTitle("+", for: .normal)
        increaseVal.backgroundColor = .red
        increaseVal.translatesAutoresizingMaskIntoConstraints = false
        return increaseVal
    }()
    
    private var decreaseVal : UIButton = {
        var decreaseVal = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        decreaseVal.addTarget(self, action: #selector(decrease), for: .touchUpInside)
        decreaseVal.setTitle("-", for: .normal)
        decreaseVal.backgroundColor = .red
        decreaseVal.translatesAutoresizingMaskIntoConstraints = false
        return decreaseVal
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
        buttonNumber.setTitle("1", for: .normal)
        buttonNumber.tag = 1
        return buttonNumber
    }()
    
    private let buttonLettereMaisc : CheckBox = {
        let buttonLettereMaisc = CheckBox()
        buttonLettereMaisc.setTitle("2", for: .normal)
        buttonLettereMaisc.tag = 2
        return buttonLettereMaisc
    }()
    
    private let buttonLettereMin : CheckBox = {
        let buttonLettereMin = CheckBox()
        buttonLettereMin.setTitle("3", for: .normal)
        buttonLettereMin.tag = 3
        return buttonLettereMin
    }()
    
    private let playButton : UIButton = {
        let playButton  = UIButton()
        playButton.setTitle("Gioca", for: .normal)
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        playButton.setTitleColor(UIColor.black, for: .normal)
        playButton.backgroundColor = .lightGray
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setUpConstraints()
        setUpStepperForTime()
        setUpGestureForKeyboard()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationController(){
        self.title = "Copri e Scopri"

    }
    
    func setUpGestureForKeyboard(){
        let tap = UITapGestureRecognizer(target : view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setUpConstraints() {
        view.addSubview(timeLabel)
        view.addSubview(timeTextField)
        view.addSubview(charactersLabel)
        view.addSubview(charactersTextField)
        view.addSubview(buttonNumber)
        view.addSubview(buttonLettereMaisc)
        view.addSubview(buttonLettereMin)
        view.addSubview(playButton)

        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            
            timeTextField.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 16),
            timeTextField.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor, constant: 0),
            timeTextField.widthAnchor.constraint(equalToConstant: 100),
            
            charactersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            charactersLabel.centerYAnchor.constraint(equalTo: charactersTextField.centerYAnchor, constant: 0),
            
            charactersTextField.leadingAnchor.constraint(equalTo: charactersLabel.trailingAnchor, constant: 16),
            charactersTextField.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 16),
            charactersTextField.widthAnchor.constraint(equalToConstant: 100),
            
            buttonNumber.topAnchor.constraint(equalTo: charactersLabel.bottomAnchor, constant: 16),
            buttonNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonNumber.widthAnchor.constraint(equalToConstant: 60),
            
            buttonLettereMaisc.topAnchor.constraint(equalTo: buttonNumber.bottomAnchor, constant: 16),
            buttonLettereMaisc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonLettereMaisc.widthAnchor.constraint(equalToConstant: 60),
            
            buttonLettereMin.topAnchor.constraint(equalTo: buttonLettereMaisc.bottomAnchor, constant: 16),
            buttonLettereMin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonLettereMin.widthAnchor.constraint(equalToConstant: 60),
            
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            playButton.topAnchor.constraint(equalTo: buttonLettereMin.bottomAnchor, constant: 30),
            playButton.heightAnchor.constraint(equalToConstant: 100)
            

        ])
        
    }
    
    func setUpStepperForTime(){
        timeTextField.rightViewMode = UITextField.ViewMode.always
        stepper.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        timeTextField.rightView = stepper
        stepper.addSubview(increaseVal)
        stepper.addSubview(decreaseVal)
        
        NSLayoutConstraint.activate([
            increaseVal.trailingAnchor.constraint(equalTo: stepper.trailingAnchor),
            increaseVal.topAnchor.constraint(equalTo: stepper.topAnchor),
            increaseVal.heightAnchor.constraint(equalToConstant: stepper.frame.height/2),
            increaseVal.leadingAnchor.constraint(equalTo: stepper.leadingAnchor),
            
            decreaseVal.topAnchor.constraint(equalTo: increaseVal.bottomAnchor),
            decreaseVal.trailingAnchor.constraint(equalTo: stepper.trailingAnchor),
            decreaseVal.bottomAnchor.constraint(equalTo: stepper.bottomAnchor),
            decreaseVal.heightAnchor.constraint(equalToConstant: stepper.frame.height/2),
            decreaseVal.leadingAnchor.constraint(equalTo: stepper.leadingAnchor)
            
            
        ])
        
    }

    
    @objc func increase(_ sender: Any) {
        switch sender as! UIButton {
        case increaseVal :
            increaseValTime()
        default:
            print("Bottone non giusto")
        }
    }
    
    func increaseValTime(){
        if (timeTextField.text?.isEmpty)! {
            someValueTime += 1
        }
        else {
            someValueTime = Int(timeTextField.text!)!
            someValueTime += 1
        }
    }
    
    @objc func decrease(_ sender: Any) {
       switch sender as! UIButton {
        case decreaseVal :
            decreaseValTime()
        default:
            print("Bottone non giusto")
        }
       
    }
    
    func decreaseValTime(){
        if !(timeTextField.text?.isEmpty)! && timeTextField.text != "0" {
            someValueTime = Int(timeTextField.text!)!
            someValueTime -= 1
        }
        else {
            someValueTime = 0
        }
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
    
    @objc func controlFieldCharacters(_ sender : Any ){
        print(Int(charactersTextField.text!)!)
        if Int(charactersTextField.text!)! < 6 || Int(charactersTextField.text!)! > 15 {
            addPopUp(text: "Il range è tra 6 e 15")
        }
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
