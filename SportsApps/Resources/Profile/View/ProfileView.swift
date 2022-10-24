//
//  ProfileView.swift
//  SportsApps
//
//  Created by Eko Meidianto on 19/10/22.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    VStack {
      photoPrifile
      name
      detailInformation
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.blue.opacity(0.5))
  }

  var photoPrifile: some View {
    Image("photo_profile")
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: 100, height: 100, alignment: .top)
      .clipShape(Circle())
      .background(
        Circle()
          .foregroundColor(Color.white)
          .frame(width: 110, height: 110, alignment: .center)
      )
  }

  var name: some View {
    Text("Eko Meidianto Nur Rahmad")
      .font(.title3)
      .bold()
      .foregroundColor(Color.white)
  }

  var detailInformation: some View {
    VStack(alignment: .leading) {
      infoContent(image: "mail", title: "Email", value: "ekomeidianto1995@gmail.com")
      horizontalLine
      infoContent(image: "phone.circle", title: "Phone", value: "082240206966")
      horizontalLine
    }
    .padding(
      EdgeInsets(
        top: 35,
        leading: 20,
        bottom: 35,
        trailing: 20
      )
    )
    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7, alignment: .topLeading)
    .background(
      RoundedRectangle(cornerRadius: 30, style: .continuous)
        .fill(Color.white)
        .edgesIgnoringSafeArea(.bottom)
    )
  }

  private func infoContent(image: String, title: String, value: String) -> some View {
    HStack(alignment: .top) {
      Image(systemName: image)
        .foregroundColor(.black)
        .font(.system(size: 20))
      VStack(alignment: .leading) {
        Text(title)
          .font(.system(size: 15))
        Text(value)
          .tint(Color.black)
          .font(.system(size: 12))
      }
    }
  }

  var horizontalLine: some View {
    Rectangle()
      .fill(Color.gray)
      .frame(height: 1, alignment: .center)
      .padding(.vertical)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
