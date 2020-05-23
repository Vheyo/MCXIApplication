//
//  OcrSavioViewController.swift
//  MCXIApplication
//
//  Created by Valentino Palomba on 15/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import UIKit
import Vision
import VisionKit
import WeScan
import JGProgressHUD

class OcrViewController : UIViewController, VNDocumentCameraViewControllerDelegate {
    var swipeActivation: Bool = false
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 50.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 12.0
    var opacity: CGFloat = 0.2
    var swiped = false
    var expanse = false
    var pagine  = [UIImage]()
    var pagineCounter : Int!
    var bufferString = [String]()
    var saveTxt = false
    
    var selectAllButton: UIBarButtonItem!
    var resetButton: UIBarButtonItem!
    @IBOutlet var tempImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    var nextButton: UIBarButtonItem!
    var backButton: UIBarButtonItem!
    @IBOutlet weak var scanButton: UIButton!
    var cropButton: UIBarButtonItem!
    @IBOutlet weak var imageView: BoundingBoxImageView!
    @IBOutlet weak var croppedImage: UIImageView!
    @IBOutlet weak var resultText: UITextView!
    
    var imageCenter : CGPoint!
    
    var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setupVision();
        pagineCounter = 0;
        imageCenter = imageView.center
    
        let spaceItemLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "OcrBefore"), style: .plain, target: self, action: #selector(backPagePressed))
        nextButton = UIBarButtonItem(image: #imageLiteral(resourceName: "OcrNext"), style: .plain, target: self, action: #selector(nextPagePressed))
        cropButton = UIBarButtonItem(image: #imageLiteral(resourceName: "OcrCrop"), style: .plain, target: self, action: #selector(cropPLS))
        selectAllButton = UIBarButtonItem(image: #imageLiteral(resourceName: "OcrAll"), style: .plain, target: self, action: #selector(selectAll_pressed))
        resetButton = UIBarButtonItem(image: #imageLiteral(resourceName: "OcrReset"), style: .plain, target: self, action: #selector(reset))
        let spaceItemRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbarItems = [spaceItemLeft, backButton, nextButton, selectAllButton, resetButton, cropButton, spaceItemRight]
        
        backButton.isEnabled = false
        nextButton.isEnabled = false
        selectAllButton.isEnabled = false
        resetButton.isEnabled = false
        cropButton.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PhotoScan));
        tap.numberOfTouchesRequired = 1;
        scanButton.addGestureRecognizer(tap);
        
        let resetTap = UITapGestureRecognizer(target: self, action: #selector(tap2Reset))
        resetTap.numberOfTapsRequired = 2;
        tempImageView.addGestureRecognizer(resetTap)
        
        //
        //        let cropGesture = UITapGestureRecognizer(target: self, action: #selector(cropPLS));
        //        cropGesture.numberOfTouchesRequired = 1;
        //        cropButton.addGestureRecognizer(cropGesture);
        
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pichToZoom))
        tempImageView.isUserInteractionEnabled = true
        tempImageView.addGestureRecognizer(pinch)
        
        let doubleFingerPan = UIPanGestureRecognizer(target: self, action: #selector(finger2scroll))
        doubleFingerPan.minimumNumberOfTouches = 2;
        doubleFingerPan.maximumNumberOfTouches = 2;
        tempImageView.addGestureRecognizer(doubleFingerPan)
        
//                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
//                    print(self.resultText.text)
//                    print(self.pagineCounter)
//                    print(self.bufferString)
//                })
        
    }
    
    @IBAction func exitPressed(_ sender: Any) {
        dismiss(animated: true, completion: {
            print("dismissed")
        })
    }
    
    
    
    @objc func backPagePressed(){
        bugged = false
        saveTxt = false
        tmpView.removeAll()
        //        if(pagineCounter == 0){
        //            backButton.isEnabled = false
        //            return
        //        }
        //        bufferString.append(resultText.text)
        nextButton.isEnabled = true
        backButton.isEnabled = true
        pagineCounter -= 1;
        for index in imageView.subviews{
            index.removeFromSuperview()
        }
        imageView.image = reloadedImage(pagine[pagineCounter])
        processImage(imageView.image!)
        if(pagineCounter == 0){
            backButton.isEnabled = false
        }
    }
    
    @objc func nextPagePressed() {
        bugged = false
        saveTxt = false
        tmpView.removeAll()
        //        if(pagineCounter == (pagine.count - 1)){
        //            nextButton.isEnabled = false
        //            return
        //        }
        //        bufferString.append(resultText.text)
        backButton.isEnabled = true
        nextButton.isEnabled = true
        pagineCounter += 1;
        for index in imageView.subviews{
            index.removeFromSuperview()
        }
        imageView.image = reloadedImage(pagine[pagineCounter])
        processImage(imageView.image!)
        if(pagineCounter == (pagine.count - 1)){
            nextButton.isEnabled = false
        }
    }
    
    @objc func selectAll_pressed() {
        bugged = false
        bufferString.append(resultText.text)
        var passingString = String()
        for index in bufferString{
            passingString += index
        }
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let file = "File\(UserDefaults.standard.integer(forKey: "numFile")+1).txt"
        let text = passingString
        let fileUrl = dir.appendingPathComponent(file)
        do {
            try text.write(to: fileUrl, atomically: false, encoding: .utf8)
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "numFile")+1, forKey: "numFile")
            
        } catch {
            print("cant write...")
        }
        
        dismiss(animated: true, completion: {
            print("dismissed")
        })
    }
    
    func exit(){
        var passingString = String()
        for index in bufferString{
            passingString += index
        }
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let file = "File\(UserDefaults.standard.integer(forKey: "numFile")+1).txt"
        let text = passingString
        let fileUrl = dir.appendingPathComponent(file)
        do {
            try text.write(to: fileUrl, atomically: false, encoding: .utf8)
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "numFile")+1, forKey: "numFile")
            
        } catch {
            print("cant write...")
        }
        
        dismiss(animated: true, completion: {
            print("dismissed")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetectedViewController
        vc.passingText = resultText.text
        
    }
    
    
    @objc func tap2Reset(_ sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.5, animations: {
            let newScale = 1;
            let transform = CGAffineTransform(scaleX: CGFloat(newScale), y: CGFloat(newScale))
            self.swipeActivation = false
            self.tempImageView.center = self.imageCenter
            self.imageView.center = self.imageCenter
            self.tempImageView.transform = transform
            self.imageView.transform = transform
        })
    }
    
    var starting_location: CGPoint!
    @objc func finger2scroll(_ sender: UIPanGestureRecognizer){
        if(!swipeActivation){return}
        if sender.state == .began{
            starting_location = sender.location(in: imageView)
        }
        else if sender.state == .changed {
            guard starting_location != nil else { return }
            let offset = sender.location(in: imageView)
            self.imageView.center.x += (starting_location.x - offset.x)*1.5
            self.tempImageView.center.x += (starting_location.x - offset.x)*1.5
            self.imageView.center.y += (starting_location.y - offset.y)*1.5
            self.tempImageView.center.y += (starting_location.y - offset.y)*1.5
            starting_location = offset
        }
    }
    
    @objc func pichToZoom(_ sender: UIPinchGestureRecognizer){guard sender.view != nil else { return }
        self.swipeActivation = true
        if sender.state == .ended || sender.state == .changed {
            
            let currentScale = self.imageView.frame.size.width / self.imageView.bounds.size.width
            var newScale = currentScale*sender.scale
            
            if newScale < 1 {
                newScale = 1
            }
            if newScale > 9 {
                newScale = 9
            }
            
            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
            
            self.tempImageView.transform = transform
            self.imageView?.transform = transform
            sender.scale = 1
            
            if(newScale < 2) {
                swipeActivation = false
                tempImageView.center = imageCenter
                imageView.center = imageCenter
                
            }
            
        }
    }
    
    
    
    @objc func cropPLS(){
        resultText.text = ""
        for index in tmpView{
            if(index!.selected){
                bugged = true
                saveTxt = true
                index!.imageView.layer.borderColor = UIColor.clear.cgColor
                self.croppedImage.image = self.imageView.snapshot(of: index?.imageView.frame, afterScreenUpdates: false)
                self.recognizeTextInImage(self.croppedImage.image!)
            }
        }
        
        let hud = JGProgressHUD(style: .dark)
        
        if(pagineCounter == (pagine.count - 1)){
            hud.textLabel.text = "Saving text..."
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: {_ in
//                self.exit()
            })
        }else{
            hud.textLabel.text = "Cropped"
        }
        
        if(hud.textLabel.text == "Saving text..."){
            DispatchQueue.global(qos: .background).sync{
                let indicator = JGProgressHUDRingIndicatorView()
                hud.indicatorView = indicator
                hud.show(in: self.view)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)){
                    self.incrementHUD(hud, progress: 0)
                }
            }
        }else{
            let indicator = JGProgressHUDSuccessIndicatorView()
            hud.indicatorView = indicator
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 1)
        }
            
    }
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
                    self.exit()
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
    
    @objc func reset() {
        tempImageView.image = nil
        for sub in imageView.subviews{
            if sub.backgroundColor == .blue{
                sub.backgroundColor = .clear
                sub.layer.borderColor = UIColor.gray.cgColor
                sub.layer.borderWidth = 2
                sub.layer.cornerRadius = 2
                sub.layer.masksToBounds = true
            }
        }
        
        for index in tmpView{
            index?.selected = false
            index?.imageView.backgroundColor = .clear
            index?.imageView.alpha = 1
            
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.tempImageView)
        }
        
    }
    
    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(tempImageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: tempImageView.frame.size.width, height: tempImageView.frame.size.height))
        
        // 2
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        // 3
        context?.setLineCap(.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 0.0)
        context?.setBlendMode(.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 6
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: tempImageView)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            // 7
            lastPoint = currentPoint
            
            
            
            for index in tmpView{
                let min_x = (index?.imageView.frame.origin.x)!
                let max_x = CGFloat(Float(min_x) + Float((index?.imageView.frame.width)!))
                
                let fourth_part = CGFloat((index?.imageView.frame.height)!/4)
                
                let min_y = CGFloat((index?.imageView.frame.origin.y)! + fourth_part)
                let max_y = CGFloat(Float(min_y) + Float((index?.imageView.frame.height)!) - Float(fourth_part))
                
                if(currentPoint.x > min_x && currentPoint.x < max_x && currentPoint.y > min_y && currentPoint.y < max_y){
                    index?.imageView.backgroundColor = .blue
                    index?.imageView.alpha = 0.2
                    index?.selected = true
                }
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
    }
    
    @objc func PhotoScan(){
        let scannerViewController = VNDocumentCameraViewController();
        scannerViewController.delegate = self;
        present(scannerViewController, animated: true);
    }
    
    
    
    //    Questa funzione fa i BOX
    private func setupVision() {
        textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            var detectedText = ""
            var boundingBoxes = [CGRect]()
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { return }
                
                detectedText += topCandidate.string
                detectedText += "\n"
                
                do {
                    guard let rectangle = try topCandidate.boundingBox(for: topCandidate.string.startIndex..<topCandidate.string.endIndex) else { return }
                    boundingBoxes.append(rectangle.boundingBox)
                } catch {
                    // You should handle errors appropriately in your app
                    print(error)
                }
            }
            
            DispatchQueue.main.async {
                self.scanButton.isEnabled = true
                //                    self.progressIndicator.progress = 1
                
                self.textView.text = detectedText
                self.resultText.text += detectedText
                if(self.saveTxt){
                    if(self.bufferString.count == self.pagineCounter){
                        self.bufferString.insert("", at: self.pagineCounter)
                    }
                    self.bufferString[self.pagineCounter] = self.resultText.text
                }
                self.textView.flashScrollIndicators()
                
                self.imageView.load(boundingBoxes: boundingBoxes)
            }
        }
        
        // I have not yet been able to get the progressHandler working (to display the progress indicator progress normally) as it seems to have a bug that causes random crashes
        //        textRecognitionRequest.progressHandler = { [weak self] (_, progress, _) in
        //            DispatchQueue.main.async {
        //                self.scanButton.isEnabled = progress == 1
        //                self.progressIndicator.progress = Float(progress)
        //            }
        //        }
        
        textRecognitionRequest.recognitionLevel = .accurate
    }
    // MARK: - VNDocumentCameraViewControllerDelegate
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        // Make sure the user scanned at least one page
        guard scan.pageCount >= 1 else {
            // You are responsible for dismissing the VNDocumentCameraViewController.
            controller.dismiss(animated: true)
            return
        }
        
        // This is a workaround for the VisionKit bug which breaks the `UIImage` returned from `VisionKit`
        // See the `Image Loading Hack` section below for more information.
        let originalImage = scan.imageOfPage(at: 0)
        let fixedImage = reloadedImage(originalImage)
        
        // You are responsible for dismissing the VNDocumentCameraViewController.
        controller.dismiss(animated: true)
        
        // Process the image
        //Evito di processare l'immagine se non preme seleziona tutto
        processImage(fixedImage)
        
        for index in 1...scan.pageCount{
            let originalImage = scan.imageOfPage(at: index-1)
            let fixedImage = reloadedImage(originalImage)
            pagine.append(fixedImage)
        }
        
        if(scan.pageCount > 1){
            nextButton.isEnabled = true
        }
        cropButton.isEnabled = true
        selectAllButton.isEnabled = true
        resetButton.isEnabled = true
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        // The VNDocumentCameraViewController failed with an error.
        // For now, we'll print it, but you should handle it appropriately in your app.
        print(error)
        
        // You are responsible for dismissing the VNDocumentCameraViewController.
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        // You are responsible for dismissing the VNDocumentCameraViewController.
        controller.dismiss(animated: true)
    }
    // MARK: - Scan Handling
    
    /// Processes the image by displaying it and extracting text which is shown to the user
    /// - Parameter image: A `UIImage` to process
    private func processImage(_ image: UIImage) {
        imageView.image = image
        imageView.removeExistingBoundingBoxes()
        
        recognizeTextInImage(image)
    }
    /// Recognizes and displays the text from the image
    /// - Parameter image: `UIImage` to process and perform OCR on
    private func recognizeTextInImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        textView.text = ""
        scanButton.isEnabled = false
        //        progressIndicator.progress = 0
        
        //        textRecognitionWorkQueue.async {
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try requestHandler.perform([self.textRecognitionRequest])
        } catch {
            print(error)
        }
    }
    
    func reloadedImage(_ originalImage: UIImage) -> UIImage {
        guard let imageData = originalImage.jpegData(compressionQuality: 1),
            let reloadedImage = UIImage(data: imageData) else {
                return originalImage
        }
        return reloadedImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        croppedImage.isHidden = true
        textView.isHidden = true
        resultText.isHidden = true
    }
}


extension UIView {
    
    /// Create image snapshot of view.
    ///
    /// - Parameters:
    ///   - rect: The coordinates (in the view's own coordinate space) to be captured. If omitted, the entire `bounds` will be captured.
    ///   - afterScreenUpdates: A Boolean value that indicates whether the snapshot should be rendered after recent changes have been incorporated. Specify the value false if you want to render a snapshot in the view hierarchy’s current state, which might not include recent changes. Defaults to `true`.
    ///
    /// - Returns: The `UIImage` snapshot.
    
    func snapshot(of rect: CGRect? = nil, afterScreenUpdates: Bool = true) -> UIImage {
        return UIGraphicsImageRenderer(bounds: rect ?? bounds).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
        }
    }
}
