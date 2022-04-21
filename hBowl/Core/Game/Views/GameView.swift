//
//  GameView.swift
//  hBowl
//
//  Created by Adam Reed on 3/30/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var gvm = GameViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: HomeViewModel
    
    let amountOfCardsViewed = 2
    @State var currentRound = 0
    @State var currentTeamIndex = 0
    @State var teamOnePlayerIndex = 0
    @State var teamTwoPlayerIndex = 0
    @State var allQuestions:[String] = []
    @State var currentQuestions:[String] = []
    @State var answeredQuestions:[String] = []
    
    @State var showingEndGameStats = false
    
    // Timer Stuff
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State var gameTime: Int
    @State var gameTimeBackup = 0
    var currentSeconds: Int { get { gameTime % 60 }}
    var currentMinutes: Int { get { gameTime / 60 }}
    @State var timerIsRunning = false
    @State var timerIsPaused = false
    
    
    // Animations
    @State var animateGradient = false
    @State var fishPositionX:CGFloat = -250
    @State var fishPositionY:CGFloat = -100
    @State var fishTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    enum GameState {
        case timerRunning, timerPaused, notRunning
    }
    
    @State var gameState = GameState.notRunning
    
    func getRandomTopic() -> String? {
        guard currentQuestions.count < amountOfCardsViewed else { return nil }
        
        if let index = allQuestions.indices.randomElement() {
            return allQuestions.remove(at: index)
        } else {
            return ""
        }
    }
    
    func startTimer() {
        gameState = .timerRunning
        timer = Timer.publish(every: 1, on: .main, in: .common)
        timer.connect()
    }
    
    func updateTeamAndPlayerTurns() {
        print("Current Team Index \(currentTeamIndex)")
        print("Team Count: \(vm.teams.count)")
        
        
        // Change Player on newly selected team
        if currentTeamIndex == 0 {
            if teamOnePlayerIndex != vm.teams[0].players.count - 1 {
                teamOnePlayerIndex += 1
            } else {
                teamOnePlayerIndex = 0
            }
            
        } else {
            print("teamTwoPlayerIndex \(teamTwoPlayerIndex), vm.teams[1].players.count - 1 \(vm.teams[1].players.count - 1)")
            if teamTwoPlayerIndex != vm.teams[1].players.count - 1 {
                
                teamTwoPlayerIndex += 1
                print("Team two player in dex: \(teamTwoPlayerIndex)")
            } else {
                teamTwoPlayerIndex = 0
                print("Team two player in dex: \(teamTwoPlayerIndex)")
            }
        }
        
        
        if currentTeamIndex != vm.teams.count - 1 {
            currentTeamIndex += 1
            print("Set index to \(currentTeamIndex)")
        } else {
            currentTeamIndex = 0
            print("Set index to \(currentTeamIndex)")
        }
    }
    
    
    func runRoundTimer() {
        if gameTime > 0 {
            gameTime -= 1
            
        } else {
            // Update team turn and player turn
            updateTeamAndPlayerTurns()
            // Stop Timer from running
            timer.connect().cancel()
            // Reset the timer with value from backup
            gameTime = gameTimeBackup
            // Update Game State to not running
            gameState = .notRunning
            
            // Move unanswered questions back to allQuestions Array
            allQuestions.insert(contentsOf: currentQuestions, at: 0)
            currentQuestions.removeAll()
        }
        
    }
    
    
    
    func stopTimer() {
        // Check to see if the timer is getting paused or stopped
        
        
        // Resset Values
        gameState = .notRunning
        // Cancel Timer
        self.timer.connect().cancel()
    }
    
    func endGame() {
        stopTimer()
        gameTime = 0
        gameState = .notRunning
        showingEndGameStats.toggle()
    }
    
    
    func newRoundSetup() {
        if currentRound > 1 {
            endGame()
        } else {
            gameState = .notRunning
            currentRound += 1
            allQuestions.insert(contentsOf: answeredQuestions, at: 0)
            answeredQuestions.removeAll()
            
        }
    }
    
    func scorePoint(with question: String) {
        // If index for current question exists
        if let index = currentQuestions.firstIndex(of: question) {
            // Remove current question
            currentQuestions.remove(at: index)
            // Append it to the answered Questions array
            answeredQuestions.append(question)
            
            // Score point for player
            if currentTeamIndex == 0 {
                print("Point for team 1")
                vm.teams[0].players[teamOnePlayerIndex].individualScore += 1
            } else {
                print("Point for team 2")
                vm.teams[1].players[teamTwoPlayerIndex].individualScore += 1
            }
            
            if currentQuestions.count == 0 && allQuestions.count == 0 {
                print("End of the round")
                stopTimer()
                newRoundSetup()
                
            }
        }
    }
    
    var simpleGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                
            }
    }
    
 
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(
                            colors: [Color.theme.mainPurple, Color.theme.mainBlue, ]),
                           startPoint: animateGradient ? .leading : .topTrailing,
                            endPoint: animateGradient ? .bottomTrailing : .bottomLeading)
                .ignoresSafeArea()
                .onAppear {
                        withAnimation(
                            .linear(duration: 5.0)
                                .repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 15) {
                
                // Menu Options
                HStack {
                    Button("Dismiss Game") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(Color.theme.textWithBackground)
                    
                }
                
                // Team Scores an Time Left
                
                HStack {
                    VStack(spacing: 3) {
                        Text("Team One")
                            
                        Text("\(vm.teams[0].players.map({$0.individualScore}).reduce(0,+))")
                            
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(Color.theme.textWithBackground)
                    
                    Spacer()
                    ZStack {
                        if currentSeconds < 10 {
                            Text("\(currentMinutes):0\(currentSeconds)")
                               
                                .fontWeight(.bold)
                        } else {
                            Text("\(currentMinutes):\(currentSeconds)")
                                
                                .fontWeight(.bold)
                        }
                        Circle()
                            .trim(from: 0, to: 1)
                            .stroke(Color.theme.textWithBackground.opacity(0.09), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                            .frame(width: 75, height: 66)
                        Circle()
                            .trim(from: 0, to: CGFloat(gameTime) / CGFloat(gameTimeBackup))
                            .stroke(Color.theme.textWithBackground.opacity(0.3), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                            .frame(width: 75, height: 66)
                            .rotationEffect(.init(degrees: 270))
                    }
                    .foregroundColor(Color.theme.textWithBackground)
                    
                    
                    Spacer()
                    VStack(spacing: 3) {
                        Text("Team Two")
                        Text("\(vm.teams[1].players.map({$0.individualScore}).reduce(0,+))")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(Color.theme.textWithBackground)
                    
                }
                .padding()
                Spacer()

                // Game Card Info
                VStack {
                    if gameState == .notRunning {
                        VStack(spacing: 5) {
                            // Current Team up to play
                            Text("\(vm.teams[currentTeamIndex].name)'s turn")
                                .fontWeight(.heavy)
                            // Current player going next
                            if currentTeamIndex == 0 {
                                Text("\(vm.teams[currentTeamIndex].players[teamOnePlayerIndex].name)'s turn")
                            } else {
                                Text("\(vm.teams[currentTeamIndex].players[teamTwoPlayerIndex].name)'s turn")
                            }
                        }
                        .foregroundColor(Color.theme.textWithBackground)
                        .font(.title3)
                        
                        
                    } else if gameState == .timerRunning {

                        VStack(spacing: 10) {
                            ForEach(currentQuestions, id: \.self) { question in
                                ZStack {
                                    
                                    Rectangle()
                                        .stroke(Color.theme.textWithBackground ,lineWidth: 2)
                                    // Question and answer button stack
                                    VStack(spacing: 5) {
                                        Text(question)
                                            .font(.largeTitle)
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color.theme.textWithBackground)
                                            
                                        Button("GOT IT!") {
                                            scorePoint(with: question)
                                            
                                        }
                                        .foregroundColor(Color.theme.textWithBackground)
                                    }
            
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.66, height: UIScreen.main.bounds.height * 0.25)
                                

                            }
                        }
                    }
                }
                
                
    
                Spacer()
                ZStack {
                    Rectangle()
                        .stroke(Color.theme.textWithBackground, lineWidth: 3)
                        .frame(width: 200, height: 50)
                        .opacity(currentQuestions.count > 1 || gameState != .timerRunning ? 0.5 : 1.0)
                        
                    Text("View Next Topic")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.textWithBackground)
                        .onTapGesture {
                            if allQuestions.count > 0 {
                                if let question = getRandomTopic() {
                                    currentQuestions.append(question)
                                }
                            }
                        }
                        .disabled(currentQuestions.count > 1 || gameState != .timerRunning)
                        .opacity(currentQuestions.count > 1 || gameState != .timerRunning ? 0.5 : 1.0)
                }
                HStack {
                    Button(gameState == .notRunning ? "Begin Round" : "Playing Now") {
                        startTimer()
                    }
                    .foregroundColor(Color.theme.textWithBackground)
                }
                
                
                // Current Round and Rules
                if currentRound == 0 {
                    Text("Rules: Describing Only, NO: Sounds Like, Rhymes With, Using Letters")
                        .foregroundColor(Color.theme.textWithBackground)
                        .multilineTextAlignment(.center)
                } else if currentRound == 1 {
                    Text("Rules: Acting Only")
                        .foregroundColor(Color.theme.textWithBackground)
                        .multilineTextAlignment(.center)
                } else {
                    Text("Rules: One Word, Sound, or Gesture")
                        .foregroundColor(Color.theme.textWithBackground)
                        .multilineTextAlignment(.center)
                }
                
                
            }
            // End of Game Screen, display final results, individual scores, etc
            .sheet(isPresented: $showingEndGameStats, content: {
                EndOfGameView().environmentObject(vm)
            })
            .padding()
        }
        
        .onAppear(perform: {
            for team in vm.teams {
                for player in team.players {
                    for question in player.questions {
                        allQuestions.append(question)
                    }
                }
            }
            gameTimeBackup = gameTime
        })
        .onReceive(timer, perform: { _ in
            runRoundTimer()
        })
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameTime: 60).environmentObject(dev.homeVM)
    }
}

extension GameView {
    
}

