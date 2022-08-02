//
//  AppDelegate.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/2.
//

import Foundation
import UIKit
import UserNotifications

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    // Show local notification in foreground
    UNUserNotificationCenter.current().delegate = self

    return true
  }
}

// MARK: UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.list, .badge, .sound, .badge])
  }
}
