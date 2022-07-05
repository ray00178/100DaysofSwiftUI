//
//   ImageSaver.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/3.
//

import Foundation
import UIKit

// MARK: - ImageServer

typealias DataClosure<T> = ((T) -> Swift.Void)
typealias EmptyClosure = (() -> Swift.Void)

class ImageServer: NSObject {
  
  var successHandler: EmptyClosure?
  var errorHandler: DataClosure<Error>?
  
  func writeToPhotoAlbum(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
  }
}

// MARK: - Action

extension ImageServer {
  @objc private func saveCompleted(_: UIImage,
                                   didFinishSavingWithError error: Error?,
                                   contextInfo _: UnsafeRawPointer) {
    if let error {
      errorHandler?(error)
    } else {
      successHandler?()
    }
  }
}
