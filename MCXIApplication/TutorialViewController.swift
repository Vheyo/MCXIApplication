//
//  TutorialViewController.swift
//  MCXIApplication
//
//  Created by Gabriele Iannace on 17/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import UIKit
import paper_onboarding

class TutorialViewController: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {

    @IBOutlet weak var skipButton: UIButton!
    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return [
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "2"),
                           title: "1",
                           description: "Ciao, sono la view 1",
                           pageIcon: #imageLiteral(resourceName: "2"),
                           color: .blue,
                           titleColor: .black,
                           descriptionColor: .black,
                           titleFont: UIFont.italicSystemFont(ofSize: CGFloat(40.0)),
                           descriptionFont: UIFont.italicSystemFont(ofSize: CGFloat(30.0))),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "1"),
                           title: "2",
                           description: "Ciao, sono la view 2",
                           pageIcon: #imageLiteral(resourceName: "1"),
                           color: .green,
                           titleColor: .black,
                           descriptionColor: .black,
                           titleFont: UIFont.italicSystemFont(ofSize: CGFloat(40.0)),
                           descriptionFont: UIFont.italicSystemFont(ofSize: CGFloat(30.0))),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "3"),
                           title: "3",
                           description: "Ciao, sono la view 3",
                           pageIcon: #imageLiteral(resourceName: "3"),
                           color: .yellow,
                           titleColor: .black,
                           descriptionColor: .black,
                           titleFont: UIFont.italicSystemFont(ofSize: CGFloat(40.0)),
                           descriptionFont: UIFont.italicSystemFont(ofSize: CGFloat(30.0)))
        ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let onboarding = PaperOnboarding()
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // add constraints
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
        view.bringSubviewToFront(skipButton)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func skipPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NO_TUTORIAL") as? UITabBarController
        self.view.window?.rootViewController = vc
        
    }
    
}
