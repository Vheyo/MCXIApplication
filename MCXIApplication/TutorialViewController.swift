

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
    OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Risorsa 4"),
                       title: "File",
                       description: "Lorem ipsum dolor sit amet,\n consectetuer adipiscing elit, sed \n diam nonummy nibh euismod\n tincidunt ut laoreet dolore magna\n aliquam erat volutpat. ",
                       pageIcon: .actions,
                       color: #colorLiteral(red: 0.5564950109, green: 0.4687417746, blue: 1, alpha: 1),
                       titleColor: .white,
                       descriptionColor: .white,
                       titleFont: FontKit.roundedFont(ofSize: 32, weight: .bold),
                       descriptionFont: FontKit.roundedFont(ofSize: 18, weight: .regular)),

    OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Risorsa 2"),
                       title: "Reading Desk",
                       description: "Lorem ipsum dolor sit amet,\n consectetuer adipiscing elit, sed \n diam nonummy nibh euismod\n tincidunt ut laoreet dolore magna\n aliquam erat volutpat. ",
                       pageIcon: .actions,
                       color: #colorLiteral(red: 0.5224255919, green: 0.4336446226, blue: 0.97723037, alpha: 1),
                       titleColor: .white,
                       descriptionColor: .white,
                       titleFont: FontKit.roundedFont(ofSize: 32, weight: .bold),
                       descriptionFont: FontKit.roundedFont(ofSize: 18, weight: .regular)),

    OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Risorsa 3") ,
                       title: "Exercises",
                       description: "Lorem ipsum dolor sit amet,\n consectetuer adipiscing elit, sed \n diam nonummy nibh euismod\n tincidunt ut laoreet dolore magna\n aliquam erat volutpat. ",
                       pageIcon: .actions ,
                       color: #colorLiteral(red: 0.5004448295, green: 0.4153957367, blue: 0.9361353517, alpha: 1),
                       titleColor: .white,
                       descriptionColor: .white,
                       titleFont: FontKit.roundedFont(ofSize: 32, weight: .bold),
                       descriptionFont: FontKit.roundedFont(ofSize: 18, weight: .regular)),
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


//MARK: Constants
private extension TutorialViewController {
    
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}

