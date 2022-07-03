//
//   ImageSaver.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/3.
//

import Foundation
import UIKit

// MARK: - ImageServer

class ImageServer: NSObject {
  
  func writeToPhotoAlbum(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
  }
}

// MARK: - Action

extension ImageServer {
  @objc private func saveCompleted(_: UIImage,
                                   didFinishSavingWithError _: Error?,
                                   contextInfo _: UnsafeRawPointer) {
    print("Save finished!")
  }
}
