//
//  RulesView.swift
//  hBowl
//
//  Created by Adam Reed on 4/18/22.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        ZStack {
            VStack {
                List {

                    Section(header: Text("About")) {
                        VStack(alignment: .leading) {
                            Text("Hudbowl is a fun group memory game that combines the charades, password and taboo. It is a easy to learn game perfect for small and large groups.")
                        }
                    }
                    
                    Section(header: Text("GamePlay")) {
                        Text("There are three rounds in the game of Hudbowl. Each players will enter five topics into the 'bowl' and will have one minute to get their team to guess as many topics as possible. Each round has a different set of rules on how to prompt your team to guess.")
                    }
                    
                    Section(header: Text("Round One: Taboo Rules")) {
                        Text("Get your team to say the topic, without using the topics name in the clue.")
                    }
                    
                    Section(header: Text("Round Two: Charade Rules")) {
                        Text("Get your team to say the topic, using only gestures and movements. You can stand up and move around if needed.")
                    }
                    
                    Section(header: Text("Round Three: One Rule")) {
                        Text("Get your team to say the topic, using only one gesture, sound, or word.")
                    }
                }
            }
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RulesView()
                .navigationTitle("HudBowl")
        }
        
    }
}
