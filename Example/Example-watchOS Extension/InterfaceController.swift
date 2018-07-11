//
//  InterfaceController.swift
//  Example-watchOS Extension
//
//  Created by Jeff Kelley on 7/11/18.
//  Copyright © 2018 Jeff Kelley. All rights reserved.
//

import WatchKit
import Foundation
import Monospacer

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var firstLabel: WKInterfaceLabel?
    @IBOutlet weak var secondLabel: WKInterfaceLabel?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        let font = UIFont.systemFont(ofSize: 17).withMonospaceDigits

        firstLabel?.setAttributedText(
            NSAttributedString(string: "11 22 33 44 55 66 77 88 99",
                               attributes: [.font: font]))

        secondLabel?.setAttributedText(
            NSAttributedString(string: String("11 22 33 44 55 66 77 88 99".reversed()),
                               attributes: [.font: font]))
    }

}
