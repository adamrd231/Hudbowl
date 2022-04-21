//
//  SwimmingFishView.swift
//  hBowl
//
//  Created by Adam Reed on 4/20/22.
//

import SwiftUI

struct SwimmingFishView: View {
    
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
        Image(fishSwimmingRight ? "fish" : "fishLeft")
            .resizable()
            .frame(width: 70, height: 50)
            .offset(x: fishPositionX, y: fishPositionY)
            .onReceive(timer) { input in
                withAnimation(.easeInOut(duration: 2.5)) {
                    runFishTimer()
                }
               
            }
            .zIndex(0)
    }
}

struct SwimmingFishView_Previews: PreviewProvider {
    static var previews: some View {
        SwimmingFishView()
    }
}
