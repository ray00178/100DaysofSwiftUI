//
//  Day65View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/4.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

// MARK: - Day65View

struct Day65View: View {
  @State private var image: Image?
  @State private var filterIntensity = 0.5
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  @State private var currentFilter = CIFilter.sepiaTone()

  let context = CIContext()

  var body: some View {
    NavigationView {
      VStack {
        ZStack {
          Rectangle()
            .fill(.secondary)

          Text("Tap to select a picture")
            .foregroundColor(.white)
            .font(.headline)

          image?
            .resizable()
            .scaledToFit()
        }
        .onTapGesture {
          showingImagePicker = true
        }

        HStack {
          Text("Intensity")
          Slider(value: $filterIntensity)
            .onChange(of: filterIntensity) { _ in
              applyProcessing()
            }
        }
        .padding(.vertical)

        HStack {
          Button("Change Filter") {}

          Spacer()

          Button("Save", action: save)
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
      .sheet(isPresented: $showingImagePicker, content: {
        ImagePicker(image: $inputImage)
      })
      .onChange(of: inputImage) { _ in
        loadImage()
      }
    }
  }

  func save() {}

  func loadImage() {
    guard let inputImage else { return }

    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }

  func applyProcessing() {
    currentFilter.intensity = Float(filterIntensity)

    guard let outputImage = currentFilter.outputImage else { return }

    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
    }
  }
}

// MARK: - Day64View_Previews

struct Day64View_Previews: PreviewProvider {
  static var previews: some View {
    Day65View()
  }
}
