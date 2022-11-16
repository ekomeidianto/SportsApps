//
//  HomeRouter.swift
//  SportsApps
//
//  Created by Eko Meidianto on 19/10/22.
//

import SwiftUI
import Team
import Core

class HomeRouter {
  func goToDetailView(for team: TeamDomainModel) -> some View {
    let detailUseCase: Interactor<
      TeamEntities,
      [TeamDomainModel],
      TeamRepository<TeamLocaleDataSource, TeamRemoteDataSource, Transformer>
    > = Injector.init().provideTeam()
    let detailPresenter = DetailsPresenter(useCase: detailUseCase, team: team)
    return DetailView(detailPresenter: detailPresenter, teams: team)
  }

  func goToProfile() -> some View {
    return ProfileView()
  }

  func goToFavorite() -> some View {
    let favoriteUseCase: Interactor<
      TeamEntities,
      [TeamDomainModel],
      TeamRepository<TeamLocaleDataSource, TeamRemoteDataSource, Transformer>
    > = Injector.init().provideTeam()
    let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
    return FavoriteView(favoritePresenter: favoritePresenter)
  }
}
