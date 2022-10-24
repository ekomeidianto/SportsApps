//
//  DetailPresenter.swift
//  SportsApps
//
//  Created by Eko Meidianto on 19/10/22.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
  @Published var teams: TeamModel
  @Published var favoriteTeams: [TeamModel] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String = ""
  @Published var isFavorite: Bool = false

  private let detailUseCase: DetailUseCase
  private var cancellables: Set<AnyCancellable> = []

  init(detailUseCase: DetailUseCase, teams: TeamModel) {
    self.detailUseCase = detailUseCase
    self.teams = teams
  }

  func getTeamsFavorite() {
    detailUseCase.getTeams()
      .receive(on: RunLoop.main)
      .sink { response in
        switch response {
          case .failure: self.errorMessage = String(describing: response)
          case .finished: self.isLoading = false
        }
      } receiveValue: { team in
        self.favoriteTeams = team
        self.checkFavorite()
      }
      .store(in: &cancellables)
  }

  func addToFavorite() {
    detailUseCase.addToFavorite(team: teams)
      .receive(on: RunLoop.main)
      .sink { response in
        switch response {
          case .failure: self.errorMessage = String(describing: response)
          case .finished: self.isLoading = false
        }
      } receiveValue: { _ in
        self.isFavorite  = true
      }
      .store(in: &cancellables)
  }

  func checkFavorite() {
    if !favoriteTeams.isEmpty {
      if favoriteTeams.contains(where: { $0.teamName == teams.teamName }) {
        isFavorite = true
      } else {
        isFavorite = false
      }
    }
  }

  func deleteFromFavorite() {
    detailUseCase.removeFromFavorite(team: teams)
      .receive(on: RunLoop.main)
      .sink { response in
        switch response {
          case .failure: self.errorMessage = String(describing: response)
          case .finished: self.isLoading = false
        }
      } receiveValue: { _ in
        self.isFavorite = false
      }
      .store(in: &cancellables)
  }
}
