//
//  ViewController.swift
//  Example-macOS
//
//  Created by Jeff Kelley on 7/11/18.
//  Copyright © 2018 Jeff Kelley. All rights reserved.
//

import Cocoa
import Monospacer

class ViewController: NSViewController {

    @IBOutlet weak var firstLabel: NSTextField?
    @IBOutlet weak var secondLabel: NSTextField?


    override func viewDidLoad() {
        super.viewDidLoad()

        [firstLabel!, secondLabel!].forEach { label in
            label.font = label.font?.withMonospaceDigits
        }
    }

}
