//
//  StartGameScreen.swift
//  hBowl
//
//  Created by Adam Reed on 3/26/22.
//

import SwiftUI
import Combine

struct GameSettingsView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State var playerName: String = ""
    @State var playerCount: String = "1"
    @State var gameTime: Int = 60
    var secondsInGameTime: Int {
        get {
            gameTime % 60
        }
    }
    var minutesInGameTime: Int {
        get {
            gameTime / 60
        }
    }
    @State var cardsAllowedToSee = 2
    
    @State var showingGameView = false
    
    @State var topicOne = ""
    @State var topicTwo = ""
    @State var topicThree = ""
    @State var topicFour = ""
    @State var topicFive = ""
    
    func resetInputValues() {
        playerName = ""
        topicOne = ""
        topicTwo = ""
        topicThree = ""
        topicFour = ""
        topicFive = ""
    }

    
    var body: some View {
        Form {

            Section(header: Text("Game Time"), footer: Text("45-60 reccomended")) {
                HStack {
                    Text("Time per round:")
                    Spacer()
                    Stepper(secondsInGameTime < 10 ? "\(minutesInGameTime):0\(secondsInGameTime)" : "\(minutesInGameTime):\(secondsInGameTime)",
                            onIncrement: { gameTime += 5 },
                            onDecrement: { gameTime -= 5 },
                            onEditingChanged: {_ in
                                if gameTime == 0 {
                                    gameTime = 5
                                }
                    })
                   
                    
                }
            }
            
            
            Section(header: Text("Cards Allowed Per Turn"), footer: Text("2 reccomended")) {
                VStack(alignment: .leading) {
                    
                    Stepper("\(cardsAllowedToSee)",
                            onIncrement: { cardsAllowedToSee += 1 },
                            onDecrement: { cardsAllowedToSee -= 1 },
                            onEditingChanged: {_ in
                                if cardsAllowedToSee == 0 {
                                    cardsAllowedToSee = 1
                                }
                    })
                }
                
            }
            
            Section(header: Text("Add Players"), footer: Text("Enter Player Name and five unique topics")) {
                HStack {
                    Text("Name:")
                    Spacer()
                    TextField("", text: $playerName)
                        
                        
                }
                HStack {
                    Text("1:")
                    Spacer()
                    TextField("", text: $topicOne)
                        .foregroundColor(topicOne != topicTwo && topicOne != topicThree && topicOne != topicFour && topicOne != topicFive ? Color.theme.text : .red)
                }
                HStack {
                    Text("2:")
                    Spacer()
                    TextField("", text: $topicTwo)
                        .foregroundColor(topicTwo != topicOne && topicTwo != topicThree && topicTwo != topicFour && topicTwo != topicFive ? Color.theme.text : .red)
                }
                HStack {
                    Text("3:")
                    Spacer()
                    TextField("", text: $topicThree)
                        .foregroundColor(topicThree != topicOne && topicThree != topicTwo && topicThree != topicFour && topicThree != topicFive ? Color.theme.text : .red)
                }
                HStack {
                    Text("4:")
                    Spacer()
                    TextField("", text: $topicFour)
                        .foregroundColor(topicFour != topicOne && topicFour != topicTwo && topicFour != topicThree && topicFour != topicFive ? Color.theme.text : .red)
                }
                HStack {
                    Text("5:")
                    Spacer()
                    TextField("", text: $topicFive)
                        .foregroundColor(topicFive != topicOne && topicFive != topicTwo && topicFive != topicThree && topicFive != topicFour ? Color.theme.text : .red)
                }
                
                Button("Join a Team") {
                    
                    guard playerName != "" else { return }
                    
                    // guard to make sure all topics were entered by user
                    guard topicOne != "" else { return }
                    guard topicTwo != "" else { return }
                    guard topicThree != "" else { return }
                    guard topicFour != "" else { return }
                    guard topicFive != "" else { return }
                    
                    // Create new player
                    var player = Player(name: playerName, individualScore: 0)
                    
                    // Append player questions to the array
                    player.questions.append(contentsOf: [topicOne, topicTwo, topicThree, topicFour, topicFive])
                    
                    // Add player to a team
                    vm.addPlayer(player: player)
                    
                    // Reset the entry value for playername and the topics submitted
                    resetInputValues()
                    
                   
                }
                .disabled( playerName == "" || topicOne == "" || topicTwo == "" || topicThree == "" || topicFour == "" || topicFive == "" )
            }
            TeamView().environmentObject(vm)

        }
        Button("Ready To Play") {
            showingGameView.toggle()
        }
        .disabled( vm.teams.map({ $0.players.count }).reduce(0, +) < 2 )
        .fullScreenCover(isPresented: $showingGameView, content: {
            GameView(gameTime: Int(gameTime) ?? 60).environmentObject(vm)
        })
        .navigationBarTitle("Game Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StartGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView().environmentObject(dev.homeVM)
    }
}
