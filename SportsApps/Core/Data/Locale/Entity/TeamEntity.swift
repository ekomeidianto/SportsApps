//
//  TeamEntity.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation
import RealmSwift

class TeamEntity: Object {
  @objc dynamic var idTeam: String = ""
  @objc dynamic var strTeam: String = ""
  @objc dynamic var strTeamBadge: String = ""
  @objc dynamic var strDescriptionEN: String = ""

  override static func primaryKey() -> String? {
    return "idTeam"
  }
}
