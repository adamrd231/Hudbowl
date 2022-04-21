//
//  PreviewProvider.swift
//  hBowl
//
//  Created by Adam Reed on 4/11/22.
//

import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}
    

    
class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {
        homeVM.teams[0].players.append(Player(name: "Adam", individualScore: 1))
        homeVM.teams[0].players.append(Player(name: "Hudson", individualScore: 2))
        homeVM.teams[1].players.append(Player(name: "Becky", individualScore: 3))
        homeVM.teams[1].players.append(Player(name: "Albus", individualScore: 4))
        
        
    }
    
    let homeVM = HomeViewModel()
    
    let playerThree = Player(name: "Becky", individualScore: 3)
    let playerFour = Player(name: "Lola", individualScore: 4)
    
    let exampleTeamOne = Team(name: "Example Team ONE",
                              players: [
                                Player(name: "Adam", individualScore: 1),
                                Player(name: "Hudson", individualScore: 2),
                                Player(name: "Becky", individualScore: 3)
                              ])
    
    let exampleTeamTwo = Team(name: "Example Team TWO",
                              players: [
                                Player(name: "Lola", individualScore: 1),
                                Player(name: "Albus", individualScore: 2),
                                Player(name: "Lucy", individualScore: 3)
                              ])
    
    
    

}
    

