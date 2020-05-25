

//
//  ViewController.swift
//  AnimatedPageView
//
//  Created by Alex K. on 12/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit
import paper_onboarding

class TutorialViewController: UIViewController {
    
    @IBOutlet var skipButton: UIButton!
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: UIImage(named: "FileIconHB")!,
                           title: "File Manager",
                           description: "Upload or Scan your files and \nstart your speed reading!",
                           pageIcon: #imageLiteral(resourceName: "pagecontrol"),
                           color: .clear,
                           titleColor: .white,
                           descriptionColor: .white,
                           titleFont: FontKit.roundedFont(ofSize: 34, weight: .bold),
                           descriptionFont: FontKit.roundedFont(ofSize: 21, weight: .light)),
        
        OnboardingItemInfo(informationImage: UIImage(named: "ReadIconHB")!,
                           title: "Reading Desk",
                           description: "Manage your files as well\n as keywords! ",
                           pageIcon: #imageLiteral(resourceName: "pagecontrol"),
                           color: .clear,
                           titleColor: .white,
                           descriptionColor: .white,
                           titleFont: FontKit.roundedFont(ofSize: 34, weight: .bold),
                           descriptionFont: FontKit.roundedFont(ofSize: 21, weight: .light)),
        
        OnboardingItemInfo(informationImage: UIImage(named: "ExIconHB")! ,
                           title: "Exercises",
                           description: "Choose between three types\n of exercises in order to improve\n your skills!",
                           pageIcon: #imageLiteral(resourceName: "pagecontrol") ,
                           color: .clear,
                           titleColor: .white,
                           descriptionColor: .white,
                           titleFont: FontKit.roundedFont(ofSize: 34, weight: .bold),
                           descriptionFont: FontKit.roundedFont(ofSize: 21, weight: .light)),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        skipButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubviewToFront(skipButton)
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NO_TUTORIAL") as? UITabBarController
        self.view.window?.rootViewController = vc
    }
    
}


// MARK: PaperOnboardingDelegate

extension TutorialViewController: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        //        skipButton.isHidden = index == 2 ? false : true
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        item.titleCenterConstraint?.constant = -10
        item.descriptionCenterConstraint?.constant = 10
//        item.superview!.setGradientBackground(colorOne: #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), colorTwo: #colorLiteral(red: 0.3490196078, green: 0.3333333333, blue: 0.8274509804, alpha: 1), frame : CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0 , width: view.frame.width , height: view.frame.height )
        gradientLayer.colors =  [#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.3921568627, green: 0.2666666667, blue: 0.8666666667, alpha: 1) ].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        item.superview!.layer.insertSublayer(gradientLayer, at: 0)
        
        // configure item
        
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource

extension TutorialViewController: PaperOnboardingDataSource {
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    //    func onboardinPageItemRadius() -> CGFloat {
    //        return 2
    //    }
    //
    //    func onboardingPageItemSelectedRadius() -> CGFloat {
    //        return 10
    //    }
    //    func onboardingPageItemColor(at index: Int) -> UIColor {
    //        return [UIColor.white, UIColor.red, UIColor.green][index]
    //    }
}



