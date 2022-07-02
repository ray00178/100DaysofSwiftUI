//
//  Day63View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/30.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

// MARK: - Day63View

struct Day63View: View {
  
  @State private var image: Image?
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?

  var body: some View {
    // Wrapping a UIViewController in a SwiftUI view
    VStack(spacing: 20.0) {
      image?
        .resizable()
        .scaledToFit()

      Button("Select Image") {
        showingImagePicker = true
      }
      .textCase(.uppercase)
      .padding()
    }
    .sheet(isPresented: $showingImagePicker) {
      ImagePicker(image: $inputImage)
    }
    .onChange(of: inputImage, perform: { _ in
      loadImageFromPicker()
    })

    // Integrating Core Image with SwiftUI
    /* VStack {
       image?
         .resizable()
         .scaledToFit()
     }
     .onAppear {
       loadImage()
     } */
  }

  func loadImage() {
    guard let beginImage = UIImage(named: "apollo17") else { return }

    let inputImage = CIImage(image: beginImage)

    let context = CIContext()
    let currentFilter = CIFilter.pixellate()
    let inputKeys = currentFilter.inputKeys

    currentFilter.inputImage = inputImage

    if inputKeys.contains(kCIInputIntensityKey) {
      // currentFilter.intensity = 1.0
    }

    if inputKeys.contains(kCIInputScaleKey) {
      currentFilter.scale = 15
    }

    guard let outputImage = currentFilter.outputImage,
          let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
    else {
      return
    }

    let uiImage = UIImage(cgImage: cgimg)
    image = Image(uiImage: uiImage)
  }

  func loadImageFromPicker() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
  }
}

// MARK: - Day63View_Previews

struct Day63View_Previews: PreviewProvider {
  static var previews: some View {
    Day63View()
  }
}
