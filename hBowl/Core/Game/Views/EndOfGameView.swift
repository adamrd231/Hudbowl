//
//  EndOfGameView.swift
//  hBowl
//
//  Created by Adam Reed on 4/20/22.
//

import SwiftUI

struct EndOfGameView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    
    func getHighestPlayerFromTeam(team: Int) -> String {
        
        var highestPlayer = Player(name: "", individualScore: 0)
        
        if team == 0 {
            highestPlayer = vm.teams[0].players.max(by: { $0.individualScore < $1.individualScore }) ?? Player(name: "", individualScore: 0)
        } else {
            highestPlayer = vm.teams[1].players.max(by: { $0.individualScore < $1.individualScore }) ?? Player(name: "", individualScore: 0)
        }

        return "\(highestPlayer.name)"

       
    }
    
    var body: some View {
        ZStack {
            LinearGradientBackgroundView()
            SwimmingFishView()
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("End of Game")
                        .font(.title)
                        .bold()
                    if vm.teams[0].players.map { $0.individualScore }.reduce(0,+) < vm.teams[1].players.map { $0.individualScore }.reduce(0,+) {
                        Text("Team Two Wins")
                            .fontWeight(.light)
                    } else {
                        Text("Team One Wins")
                            .fontWeight(.light)
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Team One MVP: ")
                        Spacer()
                        Text("\(getHighestPlayerFromTeam(team: 0))")
                            .bold()
                    }
                    HStack {
                        Text("Team Two MVP: ")
                        Spacer()
                        Text("\(getHighestPlayerFromTeam(team: 1))")
                            .bold()
                    }
                }
                .padding(.trailing)
                .padding(.vertical)
        
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Team One")
                            .fontWeight(.bold)

                        ForEach(vm.teams[0].players) { player in
                            HStack {
                                Text("\(player.name)")
                                Spacer()
                                Text("\(player.individualScore)")
                            }
                        }
                        Divider()
                        HStack {
                            Text("Total Score").fontWeight(.light)
                            Spacer()
                            Text("\(vm.teams[0].players.map { $0.individualScore }.reduce(0,+))")
                                .bold()
                        }
                        
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Team Two")
                            .fontWeight(.bold)
          
                        ForEach(vm.teams[1].players) { player in
                            HStack {
                                Text("\(player.name)")
                                Spacer()
                                Text("\(player.individualScore)")
                            }
                           
                        }
                        Divider()
                        HStack {
                            Text("Total Score").fontWeight(.light)
                            Spacer()
                            Text("\(vm.teams[1].players.map { $0.individualScore }.reduce(0,+))")
                                .bold()
                        }
                        
                        
                    }
                }
            }
            .padding()
        }
        .foregroundColor(Color.theme.textWithBackground)
    }
}

struct EndOfGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndOfGameView().environmentObject(dev.homeVM)
    }
}
