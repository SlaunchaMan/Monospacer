//
//  ViewController.swift
//  Example-tvOS
//
//  Created by Jeff Kelley on 7/11/18.
//  Copyright © 2018 Jeff Kelley. All rights reserved.
//

import UIKit
import Monospacer

class ViewController: UIViewController {

    @IBOutlet var monospacedLabels: [UILabel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        monospacedLabels?.forEach { label in
            label.font = try! label.font.withMonospaceDigits()
        }
    }

}
