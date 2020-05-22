

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
    OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "HomeBoarding1"),
                       title: "File Manager",
                       description: "Upload or Scan your files and start your speed reading!",
                       pageIcon: .actions,
                       color: #colorLiteral(red: 0.5632914901, green: 0.4769576788, blue: 1, alpha: 1),
                       titleColor: .white,
                       descriptionColor: .white,
                       titleFont: FontKit.roundedFont(ofSize: 38, weight: .bold),
                       descriptionFont: FontKit.roundedFont(ofSize: 24, weight: .light)),

    OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "HomeBoarding2"),
                       title: "Reading Desk",
                       description: "Manage your files as well as keywords! ",
                       pageIcon: .actions,
                       color: #colorLiteral(red: 0.5224255919, green: 0.4336446226, blue: 0.97723037, alpha: 1),
                       titleColor: .white,
                       descriptionColor: .white,
                       titleFont: FontKit.roundedFont(ofSize: 38, weight: .bold),
                       descriptionFont: FontKit.roundedFont(ofSize: 24, weight: .light)),

    OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Risorsa 3") ,
                       title: "Exercises",
                       description: "Choose between three types of exercises in order to improve your skills!",
                       pageIcon: .actions ,
                       color: #colorLiteral(red: 0.4855933785, green: 0.4067794085, blue: 0.9202699661, alpha: 1),
                       titleColor: .white,
                       descriptionColor: .white,
                       titleFont: FontKit.roundedFont(ofSize: 38, weight: .bold),
                       descriptionFont: FontKit.roundedFont(ofSize: 24, weight: .light)),
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = true

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
        skipButton.isHidden = index == 2 ? false : true
    }

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        //item.titleCenterConstraint?.constant = 100
        //item.descriptionCenterConstraint?.constant = 100
        
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



