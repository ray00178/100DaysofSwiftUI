//
//   ImagePicker.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/2.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var image: UIImage?
  
  func makeUIViewController(context: Context) -> some UIViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  // MARK: - Inner Class
  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true)
      
      guard let provider = results.first?.itemProvider else { return }
      
      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { data, _ in
          self.parent.image = data as? UIImage
        }
      }
    }
  }
}
