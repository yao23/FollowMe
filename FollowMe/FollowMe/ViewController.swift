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
    var highlightSquareTime = 0.1

    override func viewDidLoad() {
//        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        startGame()
    }

    func buttonByColor(color : ButtonColor) -> UIButton {
        switch color {
            case .Red:
                return redButton
            case .Green:
                return greenButton
            case .Blue:
                return blueButton
            case .Yellow:
                return yellowButton
        }
    }

    func playSequence(index: Int, highlightTime: Double) {
        currentPlayer = .Computer
        if index == inputs.count {
            currentPlayer = .Human
            return
        }
        var button : UIButton = buttonByColor(inputs[index])
        var originalColor : UIColor? = button.backgroundColor
        var highlightColor : UIColor = UIColor.whiteColor()

        UIView.animateWithDuration(highlightTime, delay: 0.0, options: [.CurveLinear, .AllowUserInteraction, .BeginFromCurrentState],
            animations: {
                button.backgroundColor = highlightColor
            }, completion: { finished in
                button.backgroundColor = originalColor
                var newIndex : Int = index + 1
                self.playSequence(newIndex, highlightTime: highlightTime)
            })
    }

    @IBAction func buttonTouched(sender : UIButton) {
        // determine which button was touched by looking at its tag
        var buttonTag : Int = sender.tag

        if let colorTouched = ButtonColor(rawValue: buttonTag) {
            if currentPlayer == .Computer {
                // ignore touches as long as this flag is set to true
                return
            }

            if colorTouched == inputs[indexOfNextButtonToTouch] {
                // the player touched the correct button
                indexOfNextButtonToTouch++

                // determine if there are any more button left in this round
                if indexOfNextButtonToTouch == inputs.count {
                    // the player has won this round
                    if advanceGame() == false {
                        playerWins()
                    }
                    indexOfNextButtonToTouch = 0
                } else  {
                    // there are more buttons left in this round... keep going
                }
            } else {
                // the player touched the wrong button
                playerLoses()
                indexOfNextButtonToTouch = 0
            }
        }
    }

    func alertView(alertView: UIAlertView, clickedButtonAtIndex: Int) {
        startGame()
    }

    func playerWins(_: Void) {
        var winner : UIAlertView = UIAlertView(title: "You won!", message: "Congratulations!", delegate: self, cancelButtonTitle: nil,
            otherButtonTitles: "Awesome!")
        winner.show()
    }

    func playerLoses(_: Void) {
        var winner : UIAlertView = UIAlertView(title: "You lost!", message: "Sorry!", delegate: self, cancelButtonTitle: nil,
            otherButtonTitles: "Try Again!")
        winner.show()
    }

    func randomButton(_: Void) -> ButtonColor {
        var v : Int = Int(arc4random_uniform(UInt32(4))) + 1
        var result = ButtonColor(rawValue: v)
        return result!
    }

    func startGame(_: Void) -> Void {
        // randomize the input array
        inputs = [ButtonColor]()
        advanceGame()
    }

    func advanceGame(_: Void) -> Bool {
        var result : Bool = true

        if inputs.count == winningNumber {
            result = false
        } else {
            // add a new random number to the input list
            inputs += [randomButton()]

            // play the button sequence
            playSequence(0, highlightTime:  highlightSquareTime)
        }

        return result
    }
}

