//
//  HomeUseCase.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation
import Combine

protocol HomeUseCase {
  func getTeams() -> AnyPublisher<[TeamModel], Error>
}

class HomeUseCaseImpl: HomeUseCase {
  private let repository: SportsRepositoryProtocol

  required init(repository: SportsRepositoryProtocol) {
    self.repository = repository
  }

  func getTeams() -> AnyPublisher<[TeamModel], Error> {
    repository.getTeamsRemote()
  }
}
