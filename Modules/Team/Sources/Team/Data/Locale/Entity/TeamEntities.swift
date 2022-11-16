//
//  File.swift
//  
//
//  Created by Eko Meidianto on 14/11/22.
//

import Foundation
import RealmSwift

public class TeamEntities: Object {
  @objc dynamic var idTeam: String = ""
  @objc dynamic var strTeam: String = ""
  @objc dynamic var strTeamBadge: String = ""
  @objc dynamic var strDescriptionEN: String = ""

  public override static func primaryKey() -> String? {
    return "idTeam"
  }
}
