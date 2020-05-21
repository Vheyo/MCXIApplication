//
//  Utilities.swift
//  OCR
//
//  Created by Gabriele Iannace on 12/05/2020.
//  Copyright © 2020 Gabriele Iannace. All rights reserved.
//

import Foundation
import UIKit

var bugged = false
var tmpView : [Box?] = []

class Box{
    var imageView: UIView!
    var selected: Bool!
    
    init(imageView: UIView, selected: Bool) {
        self.imageView = imageView
        self.selected = selected
    }
}
