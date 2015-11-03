//
//  ViewController.swift
//  FollowMe
//
//  Created by Yao Li on 11/2/15.
//  Copyright © 2015 MyCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {

    enum ButtonColor : Int {
        case Red = 1
        case Green = 2
        case Blue = 3
        case Yellow = 4
    }

    enum WhoseTurn {
        case Human
        case Computer
    }

    // view related objects and variables
    @IBOutlet weak var redButton : UIButton!
    @IBOutlet weak var greenButton : UIButton!
    @IBOutlet weak var blueButton : UIButton!
    @IBOutlet weak var yellowButton : UIButton!

    // model related objects and variables
    let winningNumber : Int = 25
    var currentPlayer : WhoseTurn = .Computer
    var inputs = [ButtonColor]()
    var indexOfNextButtonToTouch : Int = 0
    var highlightSquareTime = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

