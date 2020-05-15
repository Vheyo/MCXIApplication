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
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.backgroundColor = .red
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
//        setUpConstraints()
//        setUpStepperForTime()
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
        view.addSubview(backButton)
        view.addSubview(descriptionLabel)
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(buttonNumber)
        verticalStack.addArrangedSubview(buttonLettereMin)
        verticalStack.addArrangedSubview(buttonLettereMaisc)
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
            verticalStack.heightAnchor.constraint(equalToConstant: 250)
            
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
