//
//  PamCrTestiViewController.swift
//  MCXIApplication
//
//  Created by Francesco Tito on 17/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit

class PamCrTestiViewController: UIViewController {
    
    
    private let backButton : UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "Xviolet"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return backButton
    }()
    
    private let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Siamo Pronti"
        descriptionLabel.textColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 25)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private let playButton : UIButton = {
        let playButton  = UIButton()
        playButton.setTitle("Start", for: .normal)
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
    
    private let verticalStack : UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.backgroundColor = .red
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.spacing = 20
        verticalStack.distribution = .fillEqually
        return verticalStack
    }()
    
    private var buttonEsercizio1 : CheckBox = {
        let buttonEsercizio1 = CheckBox()
        buttonEsercizio1.setTitle("Esercizio 1", for: .normal)
        buttonEsercizio1.tag = 1
        buttonEsercizio1.addTarget(self, action: #selector(changeButtonStart), for: .touchUpInside)
        return buttonEsercizio1
    }()
    
    private var buttonEsercizio2 : CheckBox = {
        let buttonEsercizio2 = CheckBox()
        buttonEsercizio2.setTitle("Esercizio 2", for: .normal)
        buttonEsercizio2.tag = 2
        buttonEsercizio2.addTarget(self, action: #selector(changeButtonStart), for: .touchUpInside)
        return buttonEsercizio2
    }()
    
    private var buttonEsercizio3 : CheckBox = {
        let buttonEsercizio3 = CheckBox()
        buttonEsercizio3.setTitle("Esercizio 3", for: .normal)
        buttonEsercizio3.tag = 3
        buttonEsercizio3.addTarget(self, action: #selector(changeButtonStart), for: .touchUpInside)
        return buttonEsercizio3
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
        // Do any additional setup after loading the view.
    }
    
    
    func setUpConstraints() {
        view.addSubview(backButton)
        view.addSubview(playButton)
        view.addSubview(separator)
        view.addSubview(descriptionLabel)
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(buttonEsercizio1)
        verticalStack.addArrangedSubview(buttonEsercizio2)
        verticalStack.addArrangedSubview(buttonEsercizio3)
        buttonEsercizio1.addShadowView2()
        buttonEsercizio2.addShadowView2()
        buttonEsercizio3.addShadowView2()
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
            verticalStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
            verticalStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
            verticalStack.heightAnchor.constraint(equalToConstant: 410),
          
            playButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 80),
            playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            playButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            playButton.heightAnchor.constraint(equalToConstant: 42),

            separator.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            separator.topAnchor.constraint(equalTo: playButton.bottomAnchor,constant: 5),
            separator.widthAnchor.constraint(equalToConstant: 60),
            separator.heightAnchor.constraint(equalToConstant: 4)
            
        ])
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func changeButtonStart(){
        if buttonEsercizio3.isChecked || buttonEsercizio2.isChecked || buttonEsercizio1.isChecked {
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
        numeroText = buttonChecked()
        let vc = ExerciseWithFormViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = .white
        self.present(vc, animated: false)
        
    }
    
    func buttonChecked() -> Int {
        if buttonEsercizio1.isChecked {
            return buttonEsercizio1.tag
        }else if buttonEsercizio2.isChecked{
            return buttonEsercizio2.tag
        }
        
        return buttonEsercizio3.tag
    }
    


}
