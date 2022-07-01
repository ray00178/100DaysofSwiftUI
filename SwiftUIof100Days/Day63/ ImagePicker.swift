//
//   ImagePicker.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/2.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
  func makeUIViewController(context: Context) -> some UIViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    
    let picker = PHPickerViewController(configuration: config)
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}
