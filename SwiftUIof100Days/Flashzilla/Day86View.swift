//
//  Day86View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/8.
//

import CoreHaptics
import SwiftUI

// MARK: - Day86View

struct Day86View: View {
  @State private var currentTap = "Part 1 Tap"
  @State private var isShowingAlert1 = false
  @State private var isShowingAlert2 = false

  @State private var currentAmount = 0.0
  @State private var finalAmount = 1.0

  // how far the circle has been dragged
  @State private var offset = CGSize.zero

  // whether it is currently being dragged or not
  @State private var isDragging = false

  @State private var engine: CHHapticEngine?

  var body: some View {
    /* Text("Hello")
     .onAppear(perform: prepareHaptics)
     .onTapGesture(perform: complexSuccess) */
    
    VStack {
        Text("Hello")
        Spacer().frame(height: 100)
        Text("World")
    }
    // 將整個空間變得可點擊
    .contentShape(Rectangle())
    .onTapGesture {
        print("VStack tapped!")
    }
    
    /*ZStack {
      Rectangle()
        .fill(.blue)
        .frame(width: 200, height: 200)
        .onTapGesture {
          print("Rectangle on tap")
        }
      
      Circle()
        .fill(.red)
        .frame(width: 200, height: 200)
        .containerShape(Rectangle())
        .onTapGesture {
          print("Circle on tap")
        }
        //.allowsHitTesting(false)
    }*/
  }

  @ViewBuilder
  func createVStackView() -> some View {
    VStack(spacing: 28) {
      Text(currentTap)
        .font(.headline)
        .frame(width: 200, height: 200)
        .foregroundColor(.white)
        .background(LinearGradient(colors: [Color.black, Color.orange], startPoint: .top, endPoint: .bottom))
        .onTapGesture(count: 2) {
          currentTap = "Part 1 Tap"
          isShowingAlert1.toggle()
        }
        .alert("注意", isPresented: $isShowingAlert1) {
          Button("我知道了") {}
        } message: {
          Text("已連續點擊2次")
        }
        .onLongPressGesture(minimumDuration: 2) {
          isShowingAlert2.toggle()
        } onPressingChanged: { inProgress in
          // 判斷是否正在進行中
          // True means progress, otherwise false.
          print("In progress: \(inProgress)")
        }
        .alert("注意", isPresented: $isShowingAlert2) {
          Button("我知道了") {}
        } message: {
          Text("長按觸發")
        }

      Text("Part 2")
        .frame(width: 200, height: 200)
        .background(LinearGradient(colors: [Color.red, Color.orange], startPoint: .top, endPoint: .bottom))
        .scaleEffect(finalAmount + currentAmount)
        .gesture(MagnificationGesture()
          .onChanged { amount in
            currentAmount = amount - 1
          }
          .onEnded { _ in
            finalAmount += currentAmount
            currentAmount = 0
          }
        )
    }
    // 1.當Parent & Child 都手勢動作，會先以Child為主
    //   所以利用 highPriorityGesture，讓Parent有優先權
    // 2.simultaneousGesture: 表示Parent & Child 同時觸發
    .highPriorityGesture(TapGesture(count: 2)
      .onEnded { _ in
        currentTap = "VStack Tap"

        simpleSuccess()
      })
  }

  @ViewBuilder
  func createCircle() -> some View {
    let dragGesture = DragGesture()
      .onChanged { value in offset = value.translation }
      .onEnded { _ in
        withAnimation {
          offset = .zero
          isDragging = false
        }
      }

    // a long press gesture that enables isDragging
    let pressGesture = LongPressGesture()
      .onEnded { _ in
        withAnimation {
          isDragging = true
        }
      }

    // a combined gesture that forces the user to long press then drag
    let combined = pressGesture.sequenced(before: dragGesture)

    Circle()
      .fill(.pink)
      .frame(width: 64, height: 64)
      .scaleEffect(isDragging ? 1.5 : 1)
      .offset(offset)
      .gesture(combined)
  }

  func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
  }

  func prepareHaptics() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

    do {
      engine = try CHHapticEngine()
      try engine?.start()
    } catch {
      print("There was an error creating the engine: \(error.localizedDescription)")
    }
  }

  func complexSuccess() {
    // make sure that the device supports haptics
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    var events = [CHHapticEvent]()

    // create one intense, sharp tap
    for i in stride(from: 0, to: 1, by: 0.1) {
      let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
      let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
      let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
      events.append(event)
    }

    for i in stride(from: 0, to: 1, by: 0.1) {
      let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
      let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
      let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
      events.append(event)
    }

    // convert those events into a pattern and play it immediately
    do {
      let pattern = try CHHapticPattern(events: events, parameters: [])
      let player = try engine?.makePlayer(with: pattern)
      try player?.start(atTime: 0)
    } catch {
      print("Failed to play pattern: \(error.localizedDescription).")
    }
  }
}

// MARK: - Day86View_Previews

struct Day86View_Previews: PreviewProvider {
  static var previews: some View {
    Day86View()
  }
}
