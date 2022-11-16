//
//  FavoritePresenter.swift
//  SportsApps
//
//  Created by Eko Meidianto on 20/10/22.
//

import Combine
import SwiftUI

class FavoritePresenter: ObservableObject {
  @Published var teams: [TeamModel] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String = ""

  private let favoriteUseCase: FavoriteUseCase
  private var cancellables: Set<AnyCancellable> = []
  private let router = FavoriteRouter()

  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }

  func getTeams() {
    isLoading = true
    favoriteUseCase.getTeams()
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

//  func navigateToDetail<Content: View>(
//    for team: TeamModel,
//    @ViewBuilder content: () -> Content
//  ) -> some View {
//    NavigationLink(destination: router.goToDetailView(for: team)) {
//      content()
//    }
//  }
}
