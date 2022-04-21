//
//  ContentView.swift
//  hBowl
//
//  Created by Adam Reed on 3/26/22.
//

import SwiftUI

struct HomeView: View {
    // Data
    @EnvironmentObject var vm: HomeViewModel
    
    // Navigation
    @State var viewingGameScreen: Bool = false
    
    // Animation Variables
    @State var animateGradient = false
    @State var fishPositionX:CGFloat = -250
    @State var fishPositionY:CGFloat = 200
    @State var fishSwimmingRight: Bool = true
    @State var timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    
    func runFishTimer() {
        if fishSwimmingRight == true {
            if fishPositionX < 275 {
                fishPositionX += CGFloat(Int.random(in: 35...150))
            } else {
                fishSwimmingRight = false
                fishPositionY = CGFloat(Int.random(in: -400..<400))
                
            }
        } else {
            if fishPositionX > -275 {
                fishPositionX -= CGFloat(Int.random(in:  35...150))
            } else {
                fishSwimmingRight = true
                fishPositionY = CGFloat(Int.random(in: -400..<400))
            }
        }
    }

    var body: some View {
        
        TabView {
            
            homeView
            .tabItem {
                tabItemHomeView
            }
            
            RulesView()
            .tabItem {
                tabItemRulesView
                
            }
            
            VStack {
                Text("Admob")
            }
            .tabItem {
                tabItemAdmobView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView().environmentObject(HomeViewModel())
        }
       
    }
}


extension HomeView {
    
    
    
    // MARK: Main Screen Views
    var homeView: some View {
        ZStack {
            LinearGradientBackgroundView()
            SwimmingFishView()
    
            VStack {
                Text("Hud-Bowl!")
                    .font(.title)
                    .foregroundColor(Color.theme.textWithBackground)
                    .fontWeight(.heavy)
                    .padding()

                    ZStack {
                        Rectangle()
                            .stroke(Color.theme.textWithBackground, lineWidth: 3)
                            .frame(width: 100, height: 50, alignment: .center)
                            
                        Text("Start")
                            .foregroundColor(Color.theme.textWithBackground)
                            .fontWeight(.heavy)
                            .onTapGesture {
                                viewingGameScreen = true
                            }
                    }
                    .sheet(isPresented: $viewingGameScreen, content: {
                        GameSettingsView()
                            .environmentObject(vm)
                    })
            }
        }
    }
    
    
    // MARK: Tab Item Views
    var tabItemHomeView: some View {
        VStack {
            Image(systemName: "house")
            Text("Home")
        }
    }
    
    var tabItemRulesView: some View {
        VStack {
            Image(systemName: "menubar.rectangle")
            Text("Explain")
        }
    }
    
    var tabItemAdmobView: some View {
        VStack {
            Image(systemName: "creditcard")
            Text("AdMob")
        }
    }
}
