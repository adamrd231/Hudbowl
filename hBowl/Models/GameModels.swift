//
//  GameModels.swift
//  hBowl
//
//  Created by Adam Reed on 3/26/22.
//

import Foundation

struct Player: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var individualScore: Int
    var questions: [String] = []
    
}

struct Team: Equatable, Hashable {
    var id = UUID()
    var name: String = "New Game"
    var players: [Player] = []
}

