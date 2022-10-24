//
//  Color+Extension.swift
//  SportsApps
//
//  Created by Eko Meidianto on 19/10/22.
//

import Foundation
import SwiftUI

extension Color {
  static var random: Color {
    return Color(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1)
    )
  }
}
