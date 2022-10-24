//
//  HomePresenter.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation
import Combine
import SwiftUI

class HomePresenter: ObservableObject {
  @Published var teams: [TeamModel] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String = ""

  private let homeUseCase: HomeUseCase
  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()

  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }

  func getTeams() {
    self.isLoading = true
    homeUseCase.getTeams()
      .receive(on: RunLoop.main)
      .sink { response in
        switch response {
          case .failure: self.errorMessage = String(describing: response)
          case .finished: self.isLoading = false
        }
      } receiveValue: { teams in
        self.teams = teams
      }
      .store(in: &cancellables)
  }

  func navigateToDetail<Content: View>(
    for team: TeamModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.goToDetailView(for: team)) {
      content()
    }
  }

  func navigateToProfile<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.goToProfile) {
      content()
    }
  }

  func navigateToFavorite<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.goToFavorite) {
      content()
    }
  }
}
