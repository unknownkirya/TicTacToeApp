//
//  TicTacToeModel.swift
//  TicTacToeApp
//
//  Created by Кирилл Бережной on 09.05.2023.
//

import Foundation

// MARK: Структура с properties нашей игры
struct TicTacToe {
    // Энум выбора
    enum Turn {
        case Cross
        case Null
    }
    
    let textCross = "X" // текст крестика
    let textNull = "O" // текст нолика
    var nextTurn = Turn.Cross // следующий (текущий) ход, который будет сделан
}
