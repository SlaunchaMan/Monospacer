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

        guard let firstLabel = firstLabel, let secondLabel = secondLabel
            else { return }
        do {
            let font = try firstLabel.font!.withMonospaceDigits()

            firstLabel.font = font
            secondLabel.font = font
        }
        catch MonospacerError.fontUnsupported {
            NSLog("Whoops! This font isn't supported!")
        }
        catch MonospacerError.fontCreationFailed {
            NSLog("Uh-oh. Creating this font failed.")
        }
        catch {
            fatalError("Unexpected error: \(error.localizedDescription)")
        }
    }

}
