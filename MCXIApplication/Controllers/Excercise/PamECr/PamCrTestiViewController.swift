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
        descriptionLabel.text = "Siamo Pronti ?"
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
        
    private let separator : UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        separator.alpha = 0.3
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.layer.cornerRadius = 3
        return separator
    }()
    
    private var cardCollectionView : UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        let cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cardCollectionView.showsVerticalScrollIndicator = false
        cardCollectionView.isScrollEnabled = false
        cardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cardCollectionView.backgroundColor = .white
        return cardCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        cardCollectionView.register(TextToAnswerCollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func setUpConstraints() {
        view.addSubview(backButton)
        view.addSubview(playButton)
        view.addSubview(separator)
        view.addSubview(descriptionLabel)
        view.addSubview(cardCollectionView)
 
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
            
            
            cardCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            cardCollectionView.heightAnchor.constraint(equalToConstant: 55*view.frame.size.height/100),
            cardCollectionView.widthAnchor.constraint(equalToConstant: 70*view.frame.size.width/100),
            cardCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
          
            playButton.topAnchor.constraint(equalTo: cardCollectionView.bottomAnchor, constant: view.frame.size.height/100*5),
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
    
    @objc func play(){
        let vc = ExerciseWithFormViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = .white
        self.present(vc, animated: false)

    }


}

extension PamCrTestiViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! TextToAnswerCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        numeroText = indexPath.row
        playButton.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        separator.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        UIView.animate(withDuration: 0.4) {
            self.playButton.alpha = 1
            self.separator.alpha = 1
        }
        playButton.isEnabled = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70*view.frame.size.width/100, height: 15*view.frame.size.height/100)
    }
    
}

