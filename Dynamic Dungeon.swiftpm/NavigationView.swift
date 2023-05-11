import SwiftUI

enum NavigationState {
    case title
    case gameplay
    case gameover(score: Int)
}

struct NavigationView: View {
    @State var navigationState: NavigationState = .title
    
    var body: some View {
        Group {
            switch navigationState {
            case .title:
                TitleView(navigationState: $navigationState)
            case .gameplay:
                GameplayView(navigationState: $navigationState)
            case .gameover(let score):
                GameOverView(score: score, navigationState: $navigationState)
            }
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
