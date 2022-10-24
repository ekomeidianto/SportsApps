//
//  SportsRepository.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation
import Combine

protocol SportsRepositoryProtocol {
  func getTeamsRemote() -> AnyPublisher<[TeamModel], Error>
  func getTeamLocale() -> AnyPublisher<[TeamModel], Error>
  func addTeamsToFavorite(team: TeamEntity) -> AnyPublisher<[TeamModel], Error>
  func deletFromFavorite(team: TeamEntity) -> AnyPublisher<[TeamModel], Error>
}

final class SportsRepository: NSObject {

  typealias MealInstance = (LocaleDataSource, RemoteDataSource) -> SportsRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: MealInstance = { localeRepo, remoteRepo in
    return SportsRepository(locale: localeRepo, remote: remoteRepo)
  }

}

extension SportsRepository: SportsRepositoryProtocol {
  func getTeamsRemote() -> AnyPublisher<[TeamModel], Error> {
    return self.remote.getTeams()
      .map { TeamMapper.mapTeamResponsesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }

  func getTeamLocale() -> AnyPublisher<[TeamModel], Error> {
    return self.locale.getTeams()
      .map { TeamMapper.mapTeamEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }

  func addTeamsToFavorite(team: TeamEntity) -> AnyPublisher<[TeamModel], Error> {
    self.locale.addTeams(from: team)
      .filter { $0 }
      .flatMap { _ in
        self.locale.getTeams()
          .map { TeamMapper.mapTeamEntitiesToDomains(input: $0) }
      }
      .eraseToAnyPublisher()
  }

  func deletFromFavorite(team: TeamEntity) -> AnyPublisher<[TeamModel], Error> {
    self.locale.deleteTeams(from: team)
      .filter { $0 }
      .flatMap { _ in
        self.locale.getTeams()
          .map { TeamMapper.mapTeamEntitiesToDomains(input: $0) }
      }
      .eraseToAnyPublisher()
  }
}
