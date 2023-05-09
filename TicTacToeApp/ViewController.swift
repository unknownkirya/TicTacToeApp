//
//  ViewController.swift
//  TicTacToeApp
//
//  Created by Кирилл Бережной on 05.05.2023.
//

import UIKit

class ViewController: UIViewController {

    
    enum Turn {
        case Cross
        case Null
    }
    
    //var firstTurn = Turn.Cross
    var nextTurn = Turn.Cross
    
    let textCross = "X"
    let textNull = "O"
    
    var arrButtons = [UIButton]()
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a11: UIButton!
    @IBOutlet weak var a12: UIButton!
    @IBOutlet weak var a13: UIButton!
    @IBOutlet weak var a21: UIButton!
    @IBOutlet weak var a22: UIButton!
    @IBOutlet weak var a23: UIButton!
    @IBOutlet weak var a31: UIButton!
    @IBOutlet weak var a32: UIButton!
    @IBOutlet weak var a33: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtonsArr()
    }
    
    func initButtonsArr() {
        arrButtons.append(a11)
        arrButtons.append(a12)
        arrButtons.append(a13)
        
        arrButtons.append(a21)
        arrButtons.append(a22)
        arrButtons.append(a23)
        
        arrButtons.append(a31)
        arrButtons.append(a32)
        arrButtons.append(a33)
    }

    @IBAction func buttonTapAction(_ sender: UIButton) {
        fillTheCage(sender)
        
        if (allButtonsAreUsed()) {
            resultAlert(title: "Draw")
        }
    }
    
    func checkVictory(_ s: String) -> Bool {
        
        switch
        
        return false
    }
    
//    func returnSymbol(_ button: UIButton, _ symbol: String) -> Bool {
//        return
//    }
    
    func resultAlert(title: String) {
        let allertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        allertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetButtons()
            }))
        self.present(allertController, animated: true)
    }
    
    func resetButtons() {
        
        for button in arrButtons {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        if nextTurn == Turn.Cross {
            nextTurn = Turn.Null
            turnLabel.text = textNull
        } else if nextTurn == Turn.Null {
            nextTurn = Turn.Cross
            turnLabel.text = textCross
        }
        
    }
    
    func allButtonsAreUsed() -> Bool {
        
        for button in arrButtons {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
        
    }
    
    func fillTheCage(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if nextTurn == Turn.Cross {
                sender.setTitle(textCross, for: .normal)
                sender.titleLabel?.font = UIFont(name: "Futura-Medium", size: 52)
                nextTurn = Turn.Null
                turnLabel.text = textNull
            } else if nextTurn == Turn.Null {
                sender.setTitle(textNull, for: .normal)
                sender.titleLabel?.font = UIFont(name: "Futura-Medium", size: 52)
                nextTurn = Turn.Cross
                turnLabel.text = textCross
            }
        }
        sender.isEnabled = false
    }
    
}

