//
//  TeamModel.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation

struct TeamModel: Equatable, Identifiable {
  let id: UUID = UUID()
  let teamId: String
  let teamName: String
  let teamLogo: String
  let teamDesc: String
}
