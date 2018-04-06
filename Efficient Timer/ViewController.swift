//
//  ViewController.swift
//  Efficient Timer
//
//  Created by Jayant Arora on 4/6/18.
//  Copyright © 2018 Jayant Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Variables
    var timer: EFTimer!
    var timer2: EFTimer!

    // MARK: Outlets
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var outputLabel2: UILabel!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = EFTimer(name: "Timer 1", interval: 10, completion: {
            self.outputLabel.text = "Timer 1 ran" // not the best approach. Should not be used from background
                                                  // thread
            print("Timer 1 ran")
        })

        timer.inititalize()

        timer2 = EFTimer(name: "Timer 2", interval: 15, completion: {
            self.outputLabel2.text = "Timer 2 ran"  // not the best approach. Should not be used from background
                                                    // thread
            print("Timer 2 ran")
        })

        timer2.inititalize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

