//
//  FavoriteUseCase.swift
//  SportsApps
//
//  Created by Eko Meidianto on 20/10/22.
//

import Foundation
import Combine

protocol FavoriteUseCase {
  func getTeams() -> AnyPublisher<[TeamModel], Error>
}

class FavoriteUseCaseImpl: FavoriteUseCase {
  private let repository: SportsRepositoryProtocol

  required init(repository: SportsRepositoryProtocol) {
    self.repository = repository
  }

  func getTeams() -> AnyPublisher<[TeamModel], Error> {
    repository.getTeamLocale()
  }
}
