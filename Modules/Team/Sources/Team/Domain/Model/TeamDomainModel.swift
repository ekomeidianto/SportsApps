//
//  File.swift
//  
//
//  Created by Eko Meidianto on 14/11/22.
//

import Foundation

public struct TeamDomainModel: Equatable, Identifiable {
  public let id: UUID = UUID()
  public let teamId: String
  public let teamName: String
  public let teamLogo: String
  public let teamDesc: String
}
