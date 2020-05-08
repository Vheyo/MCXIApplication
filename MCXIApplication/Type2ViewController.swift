//
//  Type2ViewController.swift
//  AppStoreTransitionAnimation
//
//  Created by Razvan Chelemen on 15/05/2019.
//  Copyright © 2019 appssemble. All rights reserved.
//

import UIKit
import AppstoreTransition

class Type2ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descriptionExercise: UITextView!
    
    var subtitle: String? = nil
    var background: UIImage? = nil
    var titleLabe : String? = nil
    var tagButton : Int? = nil
    var descrip : String? = nil
    
    private var buttonPlay : UIButton = {
        let buttonPlay = UIButton()
        buttonPlay.setTitle("Play", for: .normal)
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.setTitleColor(.darkGray, for: .normal)
        buttonPlay.addTarget(self, action: #selector(showExcercise), for: .touchUpInside)
        return buttonPlay
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.clipsToBounds = true
        contentScrollView.delegate = self
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        let _ = dismissHandler
        if let subtitle = subtitle {
            subtitleLabel.text = subtitle
        }
        if let background = background {
            backgroundImage.image = background
        }
        if let titleLabe = titleLabe {
            titleLabel.text = titleLabe
        }
        if let tagButton = tagButton {
            buttonPlay.tag = tagButton
        }
        if let descrip = descrip {
            descriptionExercise.text = descrip
        }
        
        setUpConstraints()
        setUpLayoutButtonPlay()
        heightConstraint.constant = UIScreen.main.bounds.width * 1.272 - 16.0
    }
    
    func setUpConstraints(){
        contentView.addSubview(buttonPlay)
        
        NSLayoutConstraint.activate([
            descriptionExercise.heightAnchor.constraint(equalToConstant: 200),
            
            
            buttonPlay.topAnchor.constraint(equalTo: descriptionExercise.bottomAnchor, constant: 30),
            buttonPlay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonPlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonPlay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            buttonPlay.heightAnchor.constraint(equalToConstant: 80)
            
        ])
    }
    
    func setUpLayoutButtonPlay(){
        descriptionExercise.isEditable = false
        buttonPlay.layer.cornerRadius = 13
        buttonPlay.backgroundColor  = .white
        buttonPlay.addShadowView()
    }
    
    @objc func showExcercise(_ sender : UIButton){
        print(sender.tag)
        switch sender.tag{
        case 0:
            performSegue(withIdentifier: "CopriEScopri", sender: self);
        case 1:
            performSegue(withIdentifier: "Rombo", sender: self);
        case 2:
            performSegue(withIdentifier: "Comprensione", sender: self)
        default :
            print("Fatal error");
    }
    

    }
}

extension Type2ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // prevent bouncing when swiping down to close
        scrollView.bounces = scrollView.contentOffset.y > 100
        
        dismissHandler.scrollViewDidScroll(scrollView)
    }
    
}

extension Type2ViewController: CardDetailViewController {
   
    
    
    var scrollView: UIScrollView {
        return contentScrollView
    }
    
    
    var cardContentView: UIView {
        return headerView
    }

}
