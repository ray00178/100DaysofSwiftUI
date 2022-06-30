//
//  Day63View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/30.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

// MARK: - Day63View

struct Day63View: View {
  
  @State private var image: Image?
  
  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
    }
    .onAppear {
      loadImage()
    }
  }
  
  func loadImage() {
    guard let beginImage = UIImage(named: "apollo17") else { return }
    
    let inputImage = CIImage(image: beginImage)
    
    let context = CIContext()
    let currentFilter = CIFilter.pixellate()
    let inputKeys = currentFilter.inputKeys
    
    currentFilter.inputImage = inputImage
    
    if inputKeys.contains(kCIInputIntensityKey) {
      //currentFilter.intensity = 1.0
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
}

// MARK: - Day63View_Previews

struct Day63View_Previews: PreviewProvider {
  static var previews: some View {
    Day63View()
  }
}
