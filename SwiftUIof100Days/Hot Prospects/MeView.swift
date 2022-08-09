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

  @State private var qrCode = UIImage()
  
  @State var name = "Anonymous"
  @State var emailAddress = "your@email.com"

  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()

  var body: some View {
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
      NavigationView {
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
            .overlay(content: {
              Color.purple.opacity(0.2)
            })
            .contextMenu {
              Button {
                let imageServer = ImageServer()
                imageServer.writeToPhotoAlbum(image: qrCode)
              } label: {
                Label("Save to Photos", systemImage: "square.and.arrow.down")
              }
            }
        }
        .navigationTitle("Profile")
        .onAppear(perform: updateCode)
        .onChange(of: name) { _ in
          updateCode()
        }
        .onChange(of: emailAddress) { _ in
          updateCode()
        }
      }
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
  
  func updateCode() {
    qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
  }
}

// MARK: - MeView_Previews

struct MeView_Previews: PreviewProvider {
  static var previews: some View {
    MeView()
  }
}
