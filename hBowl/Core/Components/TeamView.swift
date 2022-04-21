//
//  TeamView.swift
//  hBowl
//
//  Created by Adam Reed on 3/28/22.
//

import SwiftUI


struct TeamView: View {

    @EnvironmentObject var vm: HomeViewModel
    @State var showingTopicsScreen: Bool = false

    
    @State var isActive = false
    
    var body: some View {
        ForEach(vm.teams, id: \.self) { team in
            Section {
                // Update team model to include a team name
                Text(team.name)
                    .font(.title3)
                ForEach(team.players, id:\.self) { player in
                    HStack(alignment: .center) {
                        Text(player.name)
                        Spacer()
                        Menu("Actions") {
                            Button("Remove Player") {
                                vm.removePlayer(player)
                            }
                            Button("Change Team") {
                                vm.swapTeam(player)
                            }
                        }

                    }
                }
                HStack {
                    Text("\(team.players.count.description) players on team.")
                        .font(.caption)
                    
                    
                }
                
            }
            
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
            .previewLayout(.sizeThatFits)
            .padding()

    }
}
