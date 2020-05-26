//
//  Utilities.swift
//  Ready
//
//  Created by Astroworld on 04/05/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
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
