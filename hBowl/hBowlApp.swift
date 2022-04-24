//
//  hBowlApp.swift
//  hBowl
//
//  Created by Adam Reed on 3/26/22.
//

import SwiftUI

@main
struct hBowlApp: App {
    
    // Store Manager object to make In App Purchases
    @StateObject var storeManager = StoreManager()
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView(storeManager: storeManager)
                .environmentObject(vm)
                .navigationBarTitle("HudBowl")
        }
    }
}
