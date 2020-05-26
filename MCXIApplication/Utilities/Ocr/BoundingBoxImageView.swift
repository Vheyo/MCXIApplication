//
//  TextAnnotationLayer.swift
//  Ready
//
//  Created by Astroworld on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Vision
import UIKit

/// Custom `UIImageView` subclass that adds support for displaying bounding boxes around detected text
class BoundingBoxImageView: UIImageView {
    
    /// The bounding boxes currently shown
    private var boundingBoxViews = [UIView]()
    
    func load(boundingBoxes: [CGRect]) {
        // Remove all the old bounding boxes before adding the new ones
        removeExistingBoundingBoxes()
        
        // Add each bounding box
        for box in boundingBoxes {
            load(boundingBox: box)
        }
    }
    
    /// Removes all existing bounding boxes
    func removeExistingBoundingBoxes() {
        for view in boundingBoxViews {
            view.removeFromSuperview()
        }
        boundingBoxViews.removeAll()
    }
    
    private func load(boundingBox: CGRect) {
        // Cache the image rectangle to avoid unneccessary work
        let imageRect = self.imageRect
        
        // Create a mutable copy of the bounding box
        var boundingBox = boundingBox
        
        // Flip the Y axis of the bounding box because Vision uses a different coordinate system to that of UIKit
        boundingBox.origin.y = 1 - boundingBox.origin.y
        
        // Convert the bounding box rect based on the image rectangle
        var convertedBoundingBox = VNImageRectForNormalizedRect(boundingBox, Int(imageRect.width), Int(imageRect.height))
        
        // Adjust the bounding box based on the position of the image inside the UIImageView
        // Note that we only adjust the axis that is not the same in both--because we're using `scaleAspectFit`, one of the axis will always be equal
        if frame.width - imageRect.width != 0 {
            convertedBoundingBox.origin.x += imageRect.origin.x
            convertedBoundingBox.origin.y -= convertedBoundingBox.height
        } else if frame.height - imageRect.height != 0 {
            convertedBoundingBox.origin.y += imageRect.origin.y
            convertedBoundingBox.origin.y -= convertedBoundingBox.height
        }
        
        // Enlarge the bounding box to make it contain the text neatly
        let enlargementAmount = CGFloat(2.2)
        convertedBoundingBox.origin.x    -= enlargementAmount
        convertedBoundingBox.origin.y    -= enlargementAmount
        convertedBoundingBox.size.width  += enlargementAmount * 2
        convertedBoundingBox.size.height += enlargementAmount * 2
        
        // Create a view with a narrow border and transparent background as the bounding box
        let view = UIView(frame: convertedBoundingBox)
        view.layer.opacity = 1
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        
//        addSubview(view)
        print(view.frame)
        let Rect = CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height)
        let rectView = UIView(frame: Rect);
        rectView.layer.borderColor = UIColor.gray.cgColor
        rectView.layer.borderWidth = 2
        rectView.layer.cornerRadius = 2
        rectView.layer.masksToBounds = true
        rectView.backgroundColor = .clear
        if(bugged == false){
            addSubview(rectView)
        }
//        tmpView.append(rectView)
        tmpView.append(Box(imageView: rectView, selected: false))
        boundingBoxViews.append(view)
    }
}


