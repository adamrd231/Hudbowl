//
//  hBowlApp.swift
//  hBowl
//
//  Created by Adam Reed on 3/26/22.
//

import SwiftUI

@main
struct hBowlApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
                .navigationBarTitle("HudBowl")
        }
    }
}
