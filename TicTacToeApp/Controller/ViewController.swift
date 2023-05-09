//
//  ViewController.swift
//  TicTacToeApp
//
//  Created by Кирилл Бережной on 05.05.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    
    // Энум выбора
    enum Turn {
        case Cross
        case Null
    }
    
    var nextTurn = Turn.Cross // следующий (текущий) ход, который будет сделан
    let textCross = "X" // крестик
    let textNull = "O" // нолик
    var arrButtons = [UIButton]() // массив кнопок
    
    // MARK: Outlets
    @IBOutlet weak var turnLabel: UILabel! // лейбл отображающий текущий ход
    @IBOutlet weak var a11: UIButton!
    @IBOutlet weak var a12: UIButton!
    @IBOutlet weak var a13: UIButton!
    @IBOutlet weak var a21: UIButton!
    @IBOutlet weak var a22: UIButton!
    @IBOutlet weak var a23: UIButton!
    @IBOutlet weak var a31: UIButton!
    @IBOutlet weak var a32: UIButton!
    @IBOutlet weak var a33: UIButton!
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtonsArr()
    }
    
    // Добавляем кнопки(поля) в массив arrButtons, чтобы исползовать в других функциях
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

    // Обработка нажатия на поля
    @IBAction func buttonTapAction(_ sender: UIButton) {
        fillTheCage(sender)
        
        if (allButtonsAreUsed()) {
            resultAlert(title: "Draw")
        }
    }
    
    // Функция проверки победы
    func checkVictory(_ s: String) -> Bool {
        
        // "Горизонтальная" победа
        if returnSymbol(a11, s) && returnSymbol(a12, s) && returnSymbol(a13, s) {
            return true
        } else if returnSymbol(a21, s) && returnSymbol(a22, s) && returnSymbol(a23, s) {
            return true
        } else if returnSymbol(a31, s) && returnSymbol(a32, s) && returnSymbol(a33, s) {
            return true
        }
        
        // "Вертикальная" победа
        if returnSymbol(a11, s) && returnSymbol(a21, s) && returnSymbol(a31, s) {
            return true
        } else if returnSymbol(a12, s) && returnSymbol(a22, s) && returnSymbol(a32, s) {
            return true
        } else if returnSymbol(a13, s) && returnSymbol(a23, s) && returnSymbol(a33, s) {
            return true
        }
        
        // "Диагональная" победа
        if returnSymbol(a11, s) && returnSymbol(a22, s) && returnSymbol(a33, s) {
            return true
        } else if returnSymbol(a13, s) && returnSymbol(a22, s) && returnSymbol(a31, s) {
            return true
        }
        
        
        return false
    }
    
    // Функция проверки символов для уменьшения когда в if для функции выше
    func returnSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    // Алёрт при завершении игры
    func resultAlert(title: String) {
        let allertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        allertController.addAction(UIAlertAction(title: "Play again", style: .default, handler: { (_) in
            self.resetButtons()
            }))
        self.present(allertController, animated: true)
    }
    
    // Новая игра
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
    
    // Проверка что все окна заняты
    func allButtonsAreUsed() -> Bool {
        
        for button in arrButtons {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
        
    }
    
    // Функция заполнения поля, с настройкой шрифта
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

