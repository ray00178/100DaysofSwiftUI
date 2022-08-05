//
//  MeView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/2.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

// MARK: - MeView

struct MeView: View {
  @StateObject var prospects = Prospects()

  @State var name = "Anonymous"
  @State var emailAddress = "your@email.com"

  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()

  var body: some View {
    /* NavigationView {
       Form {
         TextField("Name", text: $name)
           .textContentType(.name)
           .font(.title)

         TextField("Email", text: $emailAddress)
           .textContentType(.emailAddress)
           .font(.title)

         Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
           .resizable()
           .interpolation(.none)
           .scaledToFit()
           .frame(width: 200, height: 200)
       }
       .navigationTitle("Your Code")
     } */

    TabView {
      ProspectsView(filter: .none)
        .tabItem {
          Label("Everyone", systemImage: "person.2")
        }
      ProspectsView(filter: .contacted)
        .tabItem {
          Label("Contacted", systemImage: "checkmark.circle")
        }
      ProspectsView(filter: .uncontacted)
        .tabItem {
          Label("Uncontacted", systemImage: "questionmark.diamond")
        }
      ProspectsView(filter: .me)
        .tabItem {
          Label("Me", systemImage: "person.crop.square")
        }
    }
    .environmentObject(prospects)
  }

  func generateQRCode(from string: String) -> UIImage {
    filter.message = Data(string.utf8)

    if let outputImage = filter.outputImage {
      if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgImage)
      }
    }

    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }
}

// MARK: - MeView_Previews

struct MeView_Previews: PreviewProvider {
  static var previews: some View {
    MeView()
  }
}
