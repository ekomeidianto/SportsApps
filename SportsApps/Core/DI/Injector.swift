//
//  Injector.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation
import RealmSwift

final class Injector: NSObject {

  private func provideRepository() -> SportsRepositoryProtocol {
    let realm = try? Realm()

    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return SportsRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeUseCaseImpl(repository: repository)
  }

  func provideDetail(team: TeamModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailUseCaseImpl(repository: repository, teams: team)
  }

  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteUseCaseImpl(repository: repository)
  }

}
