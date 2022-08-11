//
//  Day87View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/9.
//

import SwiftUI

// MARK: - Day87View

struct Day87View: View {
  
  @State private var current: String = "The time is now ..."
  
  /// 監聽目前APP狀態, 背景 前景
  @Environment(\.scenePhase) var scenePhase
  
  // tolerance: 允許0.5s誤差
  let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

  var body: some View {
    
    Text(current)
      .frame(height: 200)
      .font(.headline)
      .onReceive(timer) { time in
        current = "The time is now \(time)"
      }
      .onTapGesture {
        timer.upstream.connect().cancel()
      }
      .onChange(of: scenePhase) { newValue in
        switch newValue {
        case .active:
          print("active")
        case .inactive:
          print("inactive")
        case .background:
          print("background")
        default:
          break
        }
      }
  }
}

// MARK: - Day87View_Previews

struct Day87View_Previews: PreviewProvider {
  static var previews: some View {
    Day87View()
  }
}
