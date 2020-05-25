//
//  ReadingDeskViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import  UIKit
import MobileCoreServices
import PDFKit
import JGProgressHUD

class ReadingDeskViewController: UIViewController {
    
    
    private var titleTextLabel : UILabel = {
        let titleTextLabel = UILabel()
        titleTextLabel.text = """
        Add files\n by clicking\n "+"
        """
        titleTextLabel.textAlignment = .center
        titleTextLabel.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
        titleTextLabel.font = FontKit.roundedFont(ofSize: 24, weight: .bold)
        titleTextLabel.numberOfLines = 0
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleTextLabel
    }()
    
    private let backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView(image: UIImage(named: "Ghost-1"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFit
        return backgroundImageView
    }()
    
    private var someTextLabel : UILabel = {
        let someTextLabel = UILabel()
        someTextLabel.text = "Some Text"
        someTextLabel.textAlignment = .center
        someTextLabel.numberOfLines = 1
        someTextLabel.translatesAutoresizingMaskIntoConstraints = false

        return someTextLabel
    }()

    private let circleView : UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .white
        circleView.translatesAutoresizingMaskIntoConstraints = false
        return circleView
    }()
    
    
    private var playButton : UIButton = {
        let playButton = UIButton(type: UIButton.ButtonType.custom)
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.titleLabel?.font = FontKit.roundedFont(ofSize: 22, weight: .semibold)
        playButton.titleLabel?.textAlignment = .center
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.masksToBounds = true
        playButton.layer.cornerRadius = 30
        playButton.frame = CGRect(x: 0, y: 0, width: 235, height: 50)
        return playButton
    }()
    
//      imagePlay.image = UIImage(named: "ButtonPlay")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().shadowImage = UIImage()
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        overrideUserInterfaceStyle = .light
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        AppUtility.lockOrientation(.portrait)
        
        setUpNavigationBar()
        setUpConstraints()
        
        view.backgroundColor = .white
        playButton.addTarget(self, action: #selector(playMode), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        AppUtility.lockOrientation(.portrait)
        if(UserDefaults.isFirstLaunch()){
            let vc = self.storyboard?.instantiateViewController(identifier: "TUTORIAL") as? TutorialViewController
            self.view.window?.rootViewController = vc
            titleTextLabel.alpha = 0.0
            someTextLabel.text = "Use the + Button to add new File!"
        }
        if UserDefaults.standard.integer(forKey: "numFile") > 0{
            titleTextLabel.text = "File \((UserDefaults.standard.integer(forKey: "numFile")-1))"
            someTextLabel.text = obtainTextFromFile(indexPath: UserDefaults.standard.integer(forKey: "numFile"))
        }
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    

    
    
    func obtainTextFromFile(indexPath: Int) -> String {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let file = ("File\(indexPath).txt")
            let fileURL = dir.appendingPathComponent(file)
            
            do{
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                
                return text
                
            }catch{
                print("cant read...")
            }
        }
        return "no text"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    
    func setUpNavigationBar(){
//        self.title = "Reading Desk"
        let button1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFile(_:)))
        button1.tintColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    func setUpConstraints(){
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(titleTextLabel)
        playButton.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        playButton.setGradientBackground(colorOne: #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), colorTwo: #colorLiteral(red: 0.3725490196, green: 0.2274509804, blue: 0.8274509804, alpha: 1), frame : CGRect(x: 0, y: 0, width: 270, height: 60))
        backgroundImageView.addSubview(circleView)
        self.view.addSubview(playButton)
        NSLayoutConstraint.activate([
            
            circleView.centerXAnchor.constraint(equalTo: self.backgroundImageView.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: self.backgroundImageView.centerYAnchor, constant: -13*backgroundImageView.frame.size.height/200),
            circleView.widthAnchor.constraint(equalToConstant: 48*view.frame.size.width/100),
            circleView.heightAnchor.constraint(equalToConstant: 48*view.frame.size.width/100),
            
    
            titleTextLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            titleTextLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),

            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 90),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 70*view.frame.size.width/100),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 48*view.frame.size.height/100),
            
            
           
            playButton.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 5.9*view.frame.size.height/100 ),
            playButton.heightAnchor.constraint(equalToConstant: 6.4*view.frame.size.height/100),
            playButton.widthAnchor.constraint(equalToConstant: 62*view.frame.size.width/100),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
  
        
        ])
        
        circleView.frame = CGRect(x: 0, y: 0, width: 48*view.frame.size.width/100, height: 48*view.frame.size.width/100)
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        
        circleView.addShadowView(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 1), shadowRadius: 10, shadowOpacity: 0.5)
        
        playButton.addShadowView2(isShadowPathEnabled: true, shadowColor: #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), shadowRadius: 3.5, shadowOpacity: 0.5)
        
    }
    
    
    @objc func addFile(_ sender : Any){
        let alert = UIAlertController(title: "Add File", message: "Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Scan", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
          self.performSegue(withIdentifier: "navigation", sender: self)
//            self.present(OcrViewController(),animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Import File", style: .default , handler:{ (UIAlertAction)in
            self.importPdf()
            
        }))
       alert.addAction(UIAlertAction(title: "Write Text", style: .default , handler:{ (UIAlertAction)in
                 let vc = PasteAndCopyViewController()
        vc.view.backgroundColor = .white
                vc.modalPresentationStyle = .fullScreen
                self.present(vc,animated: true)
                  
              }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
    @objc func playMode(){
       let vc = PresentatiotionTextToReadViewController()
        vc.text = someTextLabel.text!
        vc.modalPresentationStyle = .fullScreen
        vc.nameFile = titleTextLabel.text!
        vc.view.backgroundColor = .white
        present(vc,animated: true)
    }
    
    
   
    
    func importPdf(){
        let documentPicker = UIDocumentPickerViewController(documentTypes: [(kUTTypePDF as String)], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true)
    }
    
    
    @objc func timerAnimation(){
        let actionSheet = UIAlertController(title: "Choose the time of reading \n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let view = timerPickerView(frame: CGRect(x: 8.0, y: 8.0, width: actionSheet.view.bounds.size.width - 8.0 * 4.5, height: 200.0))
        actionSheet.view.addSubview(view)
        
        actionSheet.addAction(UIAlertAction(title: "Done", style: .default, handler: { (ACTION :UIAlertAction!)in
            self.someTextLabel.text = "\(view.hour)"+" h "+"\(view.minutes)"+" min "+"\(view.seconds)"
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
}


extension ReadingDeskViewController : UIDocumentPickerDelegate {
    func incrementHUD(_ hud: JGProgressHUD, progress previousProgress: Int) {
        let progress = previousProgress + 1
        hud.progress = Float(progress)/100.0
        hud.detailTextLabel.text = "\(progress)% Complete"
        
        if progress == 100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                UIView.animate(withDuration: 2, animations: {
                    hud.textLabel.text = "Success"
                    hud.detailTextLabel.text = nil
                    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                }, completion: {_ in
                    
                })
                
                hud.dismiss(afterDelay: 1.0)
            }
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(20)) {
                self.incrementHUD(hud, progress: progress)
            }
        }
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            return
        }
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        var file = String()
        var text = String()
        var fileUrl = dir.appendingPathComponent(file)
        if FileManager.default.fileExists(atPath: sandboxFileURL.path){
            print("Esiste il File e non lo copiamo")
        }
            
            
        else {
            let hud = JGProgressHUD(style: .light)
            DispatchQueue.global(qos: .background).sync{
                let indicator = JGProgressHUDRingIndicatorView()
                hud.textLabel.text = "Processing data";
                hud.indicatorView = indicator
                hud.show(in: self.view)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)){
                    self.incrementHUD(hud, progress: 0)
                }
            }
            do {
                if let pdf = PDFDocument(url: selectedFileURL) {
                    let pageCount = pdf.pageCount
                    let documentContent = NSMutableAttributedString()
                    
                    for i in 1 ..< pageCount {
                        guard let page = pdf.page(at: i) else { continue }
                        guard let pageContent = page.attributedString else { continue }
                        documentContent.append(pageContent)
                    }
                    file = "File\(UserDefaults.standard.integer(forKey: "numFile")+1).txt"
                    text = String(documentContent.mutableString)
                    fileUrl = dir.appendingPathComponent(file)
                    
                    do{
                        try text.write(to: fileUrl, atomically: false, encoding: .utf8)
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "numFile")+1, forKey: "numFile")
                           } catch {
                               print("cant write...")
                           }
                }
                
            }
            catch{
                print("Errore nel copiare il file")
            }
            
            someTextLabel.text = String(text)
            titleTextLabel.text = file
        }
        
    }
    
}
extension UserDefaults {
        // check for is first launch - only true on first invocation after app install, false on all further invocations
        // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
        static func isFirstLaunch() -> Bool {
            let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
            let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
            if (isFirstLaunch) {
                UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
                UserDefaults.standard.synchronize()
            }
            return isFirstLaunch
        }
        static func FirstLunchSet(_ valore : Bool){
            let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
            UserDefaults.standard.set(!valore, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
}

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo : UIColor, frame : CGRect, livello : UInt32 = 0){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [ colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0 , 0.7]
        gradientLayer.startPoint = CGPoint(x: 0 , y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: livello)
        
    }
}


