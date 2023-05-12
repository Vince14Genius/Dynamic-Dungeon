//
//  TitleView.swift
//  
//
//  Created by Vincent C. on 5/9/23.
//

import SwiftUI

struct TitleView: View {
    @Binding var navigationState: NavigationState
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))
                    .ignoresSafeArea()
                VStack {
                    Image("edgeOfHell")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Image("edgeOfHell")
                        .resizable()
                        .rotationEffect(.radians(.pi))
                        .aspectRatio(contentMode: .fit)
                }
                .opacity(0.5)
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("title")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Button("Play") {
                        navigationState = .gameplay
                    }
                    .font(.title)
                    .buttonStyle(.bordered)
                    Spacer(minLength: proxy.size.height * 0.2)
                }
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(navigationState: .constant(.title))
    }
}
