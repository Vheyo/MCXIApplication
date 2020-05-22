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

class ReadingDeskViewController: UIViewController {
    
    
    private var titleTextLabel : UILabel = {
        let titleTextLabel = UILabel()
        titleTextLabel.text = "Il nome del file"
        titleTextLabel.textAlignment = .center
        titleTextLabel.textColor = .black
        titleTextLabel.font = UIFont.boldSystemFont(ofSize: 21)
//        titleTextLabel.font = FontKit.roundedFont(ofSize: 21, weight: .semibold)
        titleTextLabel.numberOfLines = 0
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleTextLabel
    }()
    
    private let backgroundImageView : UIImageView = {
        let backgroundImageView = UIImageView(image: UIImage(named: "violet"))
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
        circleView.frame = CGRect(x: 0, y: 0, width: 235, height: 235)
        circleView.layer.cornerRadius = circleView.frame.width/2
        circleView.translatesAutoresizingMaskIntoConstraints = false
        return circleView
    }()
    
    
    private var playButton : UIButton = {
        let playButton = UIButton(type: UIButton.ButtonType.custom)
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        playButton.titleLabel?.textAlignment = .center
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.masksToBounds = true
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        playButton.layer.cornerRadius = 30
        playButton.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        playButton.frame = CGRect(x: 0, y: 0, width: 235, height: 50)
        return playButton
    }()
    
//      imagePlay.image = UIImage(named: "ButtonPlay")

    private var timeTextRead : UIButton = {
        let timeTextRead = UIButton()
        timeTextRead.setTitle("Timer", for: .normal)
        timeTextRead.setTitleColor(#colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1), for: .normal)
        timeTextRead.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        timeTextRead.layer.masksToBounds = true
        timeTextRead.layer.borderWidth = 2
        timeTextRead.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        timeTextRead.layer.cornerRadius = 22
        timeTextRead.translatesAutoresizingMaskIntoConstraints = false
        timeTextRead.frame = CGRect(x: 0, y: 0, width: 190, height: 40)
        return timeTextRead
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        overrideUserInterfaceStyle = .light
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        AppUtility.lockOrientation(.portrait)
        setUpNavigationBar()
        setUpConstraints()
        
        view.backgroundColor = .white
        
        timeTextRead.addTarget(self, action: #selector(timerAnimation), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playMode), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
//        self.view.addSubview(someTextLabel)
        
        backgroundImageView.addSubview(circleView)
        self.view.addSubview(playButton)
        self.view.addSubview(timeTextRead)
        NSLayoutConstraint.activate([
            
            circleView.centerXAnchor.constraint(equalTo: self.backgroundImageView.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: self.backgroundImageView.centerYAnchor, constant: -71),
            circleView.widthAnchor.constraint(equalToConstant: 235),
            circleView.heightAnchor.constraint(equalToConstant: 235),
            
    
            titleTextLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            titleTextLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),

            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 293),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 437),
            
            
           
            playButton.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 35),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 270),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timeTextRead.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            timeTextRead.heightAnchor.constraint(equalToConstant: 44),
            timeTextRead.widthAnchor.constraint(equalToConstant: 218),
            timeTextRead.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        
        ])
    }
    
    
    @objc func addFile(_ sender : Any){
        let alert = UIAlertController(title: "Add File", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Scan Images", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
          self.performSegue(withIdentifier: "navigation", sender: self)
//            self.present(OcrViewController(),animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Import Pdf", style: .default , handler:{ (UIAlertAction)in
            self.importPdf()
            
        }))
       alert.addAction(UIAlertAction(title: "Scrivi Testo", style: .default , handler:{ (UIAlertAction)in
                 let vc = PasteAndCopyViewController()
        vc.view.backgroundColor = .white
                vc.modalPresentationStyle = .fullScreen
                self.present(vc,animated: true)
                  
              }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
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
        let actionSheet = UIAlertController(title: "Seleziona il tempo dell'esercizio \n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let view = timerPickerView(frame: CGRect(x: 8.0, y: 8.0, width: actionSheet.view.bounds.size.width - 8.0 * 4.5, height: 200.0))
        actionSheet.view.addSubview(view)
        
        actionSheet.addAction(UIAlertAction(title: "Done", style: .default, handler: { (ACTION :UIAlertAction!)in
            self.someTextLabel.text = "\(view.hour)"+" ore "+"\(view.minutes)"+" min "+"\(view.seconds)"
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
}


extension ReadingDeskViewController : UIDocumentPickerDelegate {
    
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


