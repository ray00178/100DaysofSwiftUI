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
  @State private var currentFilter: CIFilter = .sepiaTone()
  @State private var showingFilterSheet = false
  @State private var processedImage: UIImage?
  @State private var showingSaveSuccessSheet = false
  
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
          Button("Change Filter") {
            showingFilterSheet = true
          }

          Spacer()

          Button("Save", action: save)
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
      .sheet(isPresented: $showingImagePicker, content: {
        ImagePicker(image: $inputImage)
      })
      .confirmationDialog(
        "Select a filter",
        isPresented: $showingFilterSheet,
        actions: {
          Button("Crystallize") { setFilter(CIFilter.crystallize()) }
          Button("Edges") { setFilter(CIFilter.edges()) }
          Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
          Button("Pixellate") { setFilter(CIFilter.pixellate()) }
          Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
          Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
          Button("Vignette") { setFilter(CIFilter.vignette()) }
          Button("Cancel", role: .cancel) {}
        }
      )
      .alert("Save Status", isPresented: $showingSaveSuccessSheet, actions: {
        Button("OK") {}
      }, message: {
        Text("Filter image alreay save in your photo library.")
      })
      .onChange(of: inputImage) { _ in
        loadImage()
      }
    }
  }

  func save() {
    guard let processedImage else { return }
    
    let imageServer = ImageServer()
    
    imageServer.successHandler = {
      showingSaveSuccessSheet = true
    }
    
    imageServer.errorHandler = { (error) in
      print("Oops: \(error.localizedDescription)")
    }
    
    imageServer.writeToPhotoAlbum(image: processedImage)
  }

  func loadImage() {
    guard let inputImage else { return }

    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }

  func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    loadImage()
  }

  func applyProcessing() {
    let inputKeys = currentFilter.inputKeys
    
    if inputKeys.contains(kCIInputIntensityKey) {
      currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
    }
    
    if inputKeys.contains(kCIInputRadiusKey) {
      currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
    }
    
    if inputKeys.contains(kCIInputScaleKey) {
      currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
    }

    guard let outputImage = currentFilter.outputImage else { return }

    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
      
      processedImage = uiImage
    }
  }
}

// MARK: - Day64View_Previews

struct Day64View_Previews: PreviewProvider {
  static var previews: some View {
    Day65View()
  }
}
