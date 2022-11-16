//
//  ContentView.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import SwiftUI
import Core
import Team

struct ContentView: View {
  @EnvironmentObject var homePresenter: GetListPresenter<
    TeamEntities,
    TeamDomainModel,
    Interactor<
      TeamEntities,
      [TeamDomainModel],
      TeamRepository<TeamLocaleDataSource, TeamRemoteDataSource, Transformer>
    >
  >
  @State var isActive: Bool = false

  var body: some View {
    NavigationView {
      ZStack {
        if self.isActive {
          HomeView(homePresenter: homePresenter)
        } else {
          Color.yellow.edgesIgnoringSafeArea(.all)
          Image("LaunchScreen")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
        }
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
          withAnimation {
            self.isActive = true
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
