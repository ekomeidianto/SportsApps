//
//  HomeRouter.swift
//  SportsApps
//
//  Created by Eko Meidianto on 19/10/22.
//

import SwiftUI

class HomeRouter {
  func goToDetailView(for team: TeamModel) -> some View {
    let detailUseCase = Injector.init().provideDetail(team: team)
    let detailPresenter = DetailPresenter(detailUseCase: detailUseCase, teams: team)
    return DetailView(detailPresenter: detailPresenter)
  }

  func goToProfile() -> some View {
    return ProfileView()
  }

  func goToFavorite() -> some View {
    let favoriteUseCase = Injector.init().provideFavorite()
    let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
    return FavoriteView(favoritePresenter: favoritePresenter)
  }
}
