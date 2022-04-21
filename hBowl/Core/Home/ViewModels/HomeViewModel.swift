//
//  HomeViewModel.swift
//  hBowl
//
//  Created by Adam Reed on 3/26/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var teams: [Team] = [Team(name: "Team 1", players: []), Team(name: "Team 2", players: [])]
    @Published var currentIndex = 0
    @Published var currentPlayer: Player?

    func addPlayer(player: Player) {
        // get index for current team
        for index in 0..<teams.count {

            if index == currentIndex {
                teams[index].players.append(player)
                // Add to the index, or reset if needed
                if currentIndex < teams.count - 1 {
                    currentIndex += 1
                } else {
                    currentIndex = 0
                }
                return
            }
        }
    }
    
    func removePlayer(_ player: Player) {
        for team in teams {
            if team.players.contains(player) {
                guard let teamIndex = teams.firstIndex(of: team) else { return }
                guard let playerIndex = team.players.firstIndex(of: player) else { return }
                
                teams[teamIndex].players.remove(at: playerIndex)
            }
        }
    }
    
    
    func swapTeam(_ player: Player) {

        // get team index
        for team in teams {
            if team.players.contains(player) {
                guard let teamIndex = teams.firstIndex(of: team) else { return }
                guard let playerIndex = team.players.firstIndex(of: player) else { return }
                
                let removedPlayer = teams[teamIndex].players.remove(at: playerIndex)
                
                if teamIndex + 1 < teams.count {
                    teams[teamIndex + 1].players.append(removedPlayer)
                } else {
                    teams[0].players.append(removedPlayer)                }
                
                
            }
        }
        // get player index within team
  
        
    }
    
}
