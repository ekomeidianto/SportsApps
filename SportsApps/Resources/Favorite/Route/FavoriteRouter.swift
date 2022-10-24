//
//  FavoriteRouter.swift
//  SportsApps
//
//  Created by Eko Meidianto on 20/10/22.
//

import Foundation
import SwiftUI

class FavoriteRouter {
  func goToDetailView(for team: TeamModel) -> some View {
    let detailUseCase = Injector.init().provideDetail(team: team)
    let detailPresenter = DetailPresenter(detailUseCase: detailUseCase, teams: team)
    return DetailView(detailPresenter: detailPresenter)
  }
}
