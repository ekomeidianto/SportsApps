//
//  DetailUseCase.swift
//  SportsApps
//
//  Created by Eko Meidianto on 20/10/22.
//

import Foundation
import Combine

protocol DetailUseCase {
  func getTeams() -> AnyPublisher<[TeamModel], Error>
  func addToFavorite(team: TeamModel) -> AnyPublisher<[TeamModel], Error>
  func removeFromFavorite(team: TeamModel) -> AnyPublisher<[TeamModel], Error>
}

class DetailUseCaseImpl: DetailUseCase {
  private let repository: SportsRepositoryProtocol
  private let teams: TeamModel

  required init(repository: SportsRepositoryProtocol, teams: TeamModel) {
    self.repository = repository
    self.teams = teams
  }

  func addToFavorite(team: TeamModel) -> AnyPublisher<[TeamModel], Error> {
    repository.addTeamsToFavorite(team: TeamMapper.mapTeamDomainToEntities(input: team))
  }

  func removeFromFavorite(team: TeamModel) -> AnyPublisher<[TeamModel], Error> {
    repository.deletFromFavorite(team: TeamMapper.mapTeamDomainToEntities(input: team))
  }

  func getTeams() -> AnyPublisher<[TeamModel], Error> {
    repository.getTeamLocale()
  }
}
