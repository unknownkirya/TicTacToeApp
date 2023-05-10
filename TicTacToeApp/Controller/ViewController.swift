//
//  ViewController.swift
//  TicTacToeApp
//
//  Created by Кирилл Бережной on 05.05.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    
    
    var ticTacToe = TicTacToe() // экземпляр модели с данными нашей игры
    var arrButtons = [UIButton]() // массив кнопок для перебора
    var scoreCrosses = 0 // счет побед за 'Крестики'
    var scoreNulls = 0 // счет побед за 'Нолики'
    
    // MARK: Outlets
    @IBOutlet weak var turnLabel: UILabel! // лейбл отображающий текущий ход
    // Кнопка промежуточных результатов игры
    @IBOutlet weak var resultsButton: UIButton!
    // Кнопки-поля для игры
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
        resultsButton.layer.cornerRadius = 15
        
        initButtonsArr()
    }
    
    // Добавляем кнопки в массив arrButtons, чтобы перебирать в других функциях
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
        
        if checkVictory(TicTacToe.Constants.Text.cross) {
            scoreCrosses += 1
            presentResultAlert(title: "Победил игрок играющий за Крестики!")
        } else if checkVictory(TicTacToe.Constants.Text.null) {
            scoreNulls += 1
            presentResultAlert(title: "Победил игрок играющий за Нолики!")
        } else if areAllButtonsUsed() {
            presentResultAlert(title: "Ничья! Сыграйте еще раз, чтобы выявить победителя :)")
        }
    }
    
    @IBAction func resultButtonTapAction(_ sender: Any) {
        getInterimResultsAlert()
    }
    
    // Функция проверки победы одного из пользователей
    func checkVictory(_ s: String) -> Bool {
        
        // "Горизонтальная" победа
        if checkSymbol(a11, s) && checkSymbol(a12, s) && checkSymbol(a13, s) {
            return true
        } else if checkSymbol(a21, s) && checkSymbol(a22, s) && checkSymbol(a23, s) {
            return true
        } else if checkSymbol(a31, s) && checkSymbol(a32, s) && checkSymbol(a33, s) {
            return true
        }
        
        // "Вертикальная" победа
        if checkSymbol(a11, s) && checkSymbol(a21, s) && checkSymbol(a31, s) {
            return true
        } else if checkSymbol(a12, s) && checkSymbol(a22, s) && checkSymbol(a32, s) {
            return true
        } else if checkSymbol(a13, s) && checkSymbol(a23, s) && checkSymbol(a33, s) {
            return true
        }
        
        // "Диагональная" победа
        if checkSymbol(a11, s) && checkSymbol(a22, s) && checkSymbol(a33, s) {
            return true
        } else if checkSymbol(a13, s) && checkSymbol(a22, s) && checkSymbol(a31, s) {
            return true
        }
        
        
        return false
    }
    
    // Функция проверки символов для уменьшения когда в if для функции выше
    func checkSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    // Алёрт, показывающий промежуточный счёт
    func getInterimResultsAlert() {
        var message = ""
        
        if scoreCrosses > scoreNulls {
            message = "Пока выигравыет команда 'Крестиков'!"
        } else if scoreNulls > scoreCrosses {
            message = "Пока выигравыет команда 'Ноликов'!"
        } else {
            message = "Пока ничья!"
        }
        message += "\nКрестики - \(scoreCrosses)\nНолики - \(scoreNulls)"
        
        let allertController = UIAlertController(title: "Счёт:", message: message, preferredStyle: .actionSheet)
        allertController.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: .none))
        self.present(allertController, animated: true)
    }

    // Алёрт при завершении игры
    func presentResultAlert(title: String) {
        let message = "\nСчёт:\n\nКрестики - \(scoreCrosses)\nНолики - \(scoreNulls)"
        let allertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        allertController.addAction(UIAlertAction(title: "Играть еще раз", style: .default, handler: { [weak self] _ in
            self?.resetButtons()
            }))
        self.present(allertController, animated: true)
    }
    
    // Новая игра
    func resetButtons() {
        
        for button in arrButtons {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        // По правилам, в новой игре всегда первым ходит игрок, играющий за "Крестики"
        ticTacToe.nextTurn = TicTacToe.Turn.cross
        turnLabel.text = TicTacToe.Constants.Text.cross
    }
    
    // Проверка что все окна заняты
    func areAllButtonsUsed() -> Bool {
        
        return !arrButtons.contains { $0.title(for: .normal) == nil }
        
    }
    
    // Функция заполнения поля, с настройкой шрифта
    func fillTheCage(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if ticTacToe.nextTurn == TicTacToe.Turn.cross {
                sender.setTitle(TicTacToe.Constants.Text.cross, for: .normal)
                sender.titleLabel?.font = Constants.Font.futuraMedium
                ticTacToe.nextTurn = TicTacToe.Turn.null
                turnLabel.text = TicTacToe.Constants.Text.null
            } else if ticTacToe.nextTurn == TicTacToe.Turn.null {
                sender.setTitle(TicTacToe.Constants.Text.null, for: .normal)
                sender.titleLabel?.font = Constants.Font.futuraMedium
                ticTacToe.nextTurn = TicTacToe.Turn.cross
                turnLabel.text = TicTacToe.Constants.Text.cross
            }
        }
        sender.isEnabled = false
    }
    
}

extension ViewController {
    enum Constants {
        enum Font {
            static let futuraMedium = UIFont(name: "Futura-Medium", size: 52)
        }
    }
}

