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
        case cross
        case null
    }
    var nextTurn = Turn.cross // следующий (текущий) ход, который будет сделан
}

extension TicTacToe {
    enum Constants {
        enum Text {
            static let cross = "X"
            static let null = "O"
        }
    }
}
