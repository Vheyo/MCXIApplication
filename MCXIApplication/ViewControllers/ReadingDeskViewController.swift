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
    
    
    private var viewViole : UIView = {
        let viewViole = UIView()
        viewViole.translatesAutoresizingMaskIntoConstraints = false
        viewViole.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        return viewViole
    }()
    
    private var titleTextLabel : UILabel = {
        let titleTextLabel = UILabel()
        titleTextLabel.text = "Il nome del file"
        titleTextLabel.textAlignment = .center
        titleTextLabel.textColor = .white
        titleTextLabel.font = UIFont.boldSystemFont(ofSize: 21)
        titleTextLabel.numberOfLines = 0
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleTextLabel
    }()
    
    private var textViewContainer : UIView = {
        let textViewContainer = UIView()
        textViewContainer.translatesAutoresizingMaskIntoConstraints = false
        textViewContainer.backgroundColor = .white
        textViewContainer.layer.cornerRadius = 25
        return textViewContainer
    }()
    
    private var someTextLabel : UILabel = {
        let someTextLabel = UILabel()
        someTextLabel.text = "Some Text"
        someTextLabel.textAlignment = .center
        someTextLabel.numberOfLines = 1
        someTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return someTextLabel
    }()
    
    
    private var playButton : UIButton = {
        let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        playButton.titleLabel?.textAlignment = .center
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.masksToBounds = true
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.4431372549, blue: 0.9882352941, alpha: 1)
        playButton.layer.cornerRadius = 40
        return playButton
    }()
    
    private var imagePlay : UIImageView = {
        let imagePlay = UIImageView()
        imagePlay.image = UIImage(named: "ButtonPlay")
        imagePlay.layer.masksToBounds = true
        imagePlay.layer.cornerRadius = 40
        imagePlay.translatesAutoresizingMaskIntoConstraints = false
        return imagePlay
    }()
    
    private var timeTextRead : UIButton = {
        let timeTextRead = UIButton()
        timeTextRead.setTitle("Tempo di lettura", for: .normal)
        timeTextRead.setTitleColor(.black, for: .normal)
        timeTextRead.layer.borderWidth = 1
        timeTextRead.layer.borderColor = UIColor.black.cgColor
        timeTextRead.translatesAutoresizingMaskIntoConstraints = false
        return timeTextRead
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait)
        setUpNavigationBar()
        setUpConstraints()
        textViewContainer.addShadowView2()
        someTextLabel.text = obtainTextFromFile(indexPath: UserDefaults.standard.integer(forKey: "numFile"))
        timeTextRead.addTarget(self, action: #selector(timerAnimation), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playMode), for: .touchUpInside)
    }
    
    
    func obtainTextFromFile(indexPath: Int) -> String {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let file = ("File\(indexPath).txt")
            let fileURL = dir.appendingPathComponent(file)
            
            do{
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                print(text)
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
        self.title = "Reading Desk"
        let button1 = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addFile))
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    func setUpConstraints(){
        self.view.addSubview(viewViole)
        self.view.addSubview(titleTextLabel)
        self.view.addSubview(textViewContainer)
        textViewContainer.addSubview(someTextLabel)
        self.view.addSubview(playButton)
        self.view.addSubview(timeTextRead)
        playButton.addSubview(imagePlay)
        NSLayoutConstraint.activate([
            
            viewViole.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewViole.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewViole.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewViole.heightAnchor.constraint(equalToConstant: 300),
            
            titleTextLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textViewContainer.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant:  16),
            textViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            textViewContainer.heightAnchor.constraint(equalToConstant: 300),
            
            someTextLabel.leadingAnchor.constraint(equalTo: textViewContainer.leadingAnchor,constant: 16),
            someTextLabel.trailingAnchor.constraint(equalTo: textViewContainer.trailingAnchor,constant: -16),
            someTextLabel.topAnchor.constraint(equalTo: textViewContainer.topAnchor,constant: 16),
            someTextLabel.bottomAnchor.constraint(equalTo: textViewContainer.bottomAnchor,constant: -16),
            
            
            playButton.topAnchor.constraint(equalTo: textViewContainer.bottomAnchor, constant: 16),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            playButton.heightAnchor.constraint(equalToConstant: 80),
            
            imagePlay.leadingAnchor.constraint(equalTo: playButton.leadingAnchor),
            imagePlay.trailingAnchor.constraint(equalTo: playButton.trailingAnchor),
            imagePlay.topAnchor.constraint(equalTo: playButton.topAnchor),
            imagePlay.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            
            timeTextRead.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 16),
            timeTextRead.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeTextRead.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
        ])
    }
    
    
    @objc func addFile(_ sender : Any){
        let alert = UIAlertController(title: "Add File", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ocr", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
            self.performSegue(withIdentifier: "navigation", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Pdf", style: .default , handler:{ (UIAlertAction)in
            self.importPdf()
            
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
        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = .white
        vc.text = someTextLabel.text!
        self.present(vc, animated: true, completion: nil)
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
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
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
