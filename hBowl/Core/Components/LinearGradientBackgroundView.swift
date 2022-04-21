//
//  LinearGradientBackgroundView.swift
//  hBowl
//
//  Created by Adam Reed on 4/20/22.
//

import SwiftUI

struct LinearGradientBackgroundView: View {
    
    @State var animateGradient = false
    
    var body: some View {
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
    }
}

struct LinearGradientBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        LinearGradientBackgroundView()
    }
}
