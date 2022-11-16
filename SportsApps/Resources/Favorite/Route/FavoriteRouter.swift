//
//  FavoriteRouter.swift
//  SportsApps
//
//  Created by Eko Meidianto on 20/10/22.
//

import SwiftUI
import Team
import Core

class FavoriteRouter {
  func goToDetailView(for team: TeamDomainModel) -> some View {
    let detailUseCase: Interactor<
      TeamEntities,
      [TeamDomainModel],
      TeamRepository<TeamLocaleDataSource, TeamRemoteDataSource, Transformer>
    > = Injector.init().provideTeam()
    let detailPresenter = DetailsPresenter(useCase: detailUseCase, team: team)
    return DetailView(detailPresenter: detailPresenter, teams: team)
  }
}
