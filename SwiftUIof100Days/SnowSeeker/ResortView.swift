//
//  ResortView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/29.
//

import SwiftUI

// MARK: - ResortView

struct ResortView: View {
  @Environment(\.horizontalSizeClass) var sizeClass
  @Environment(\.dynamicTypeSize) var typeSize

  @State private var selectedFacility: Facility?
  @State private var showingFacility = false

  let resort: Resort

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        Image(resort.id)
          .resizable()
          .scaledToFit()

        HStack {
          if sizeClass == .compact, typeSize > .large {
            VStack(spacing: 10) { ResortDetailsView(resort: resort) }
            VStack(spacing: 10) { SkiDetailsView(resort: resort) }
          } else {
            ResortDetailsView(resort: resort)
            SkiDetailsView(resort: resort)
          }
        }
        .padding(.vertical)
        .background(Color.primary.opacity(0.1))

        Group {
          Text(resort.description)
            .padding(.vertical)

          Text("Facilities")
            .font(.headline)

          // e.g = 1, 2, and 3
          /* Text(resort.facilities, format: .list(type: .and))
           .padding(.vertical) */
          HStack {
            ForEach(resort.facilityTypes) { facility in
              Button {
                selectedFacility = facility
                showingFacility = true
              } label: {
                facility.icon
                  .font(.title)
              }
            }
          }
          .padding(.vertical)
        }
        .padding(.horizontal)
      }
    }
    // .ignoresSafeArea(edges: .top)
    .navigationTitle("\(resort.name), \(resort.country)")
    .navigationBarTitleDisplayMode(.inline)
    .alert(selectedFacility?.name ?? "More information",
           isPresented: $showingFacility,
           presenting: selectedFacility)
    { _ in
    } message: { facility in
      Text(facility.description)
    }
  }
}

// MARK: - ResortView_Previews

struct ResortView_Previews: PreviewProvider {
  static var previews: some View {
    ResortView(resort: Resort.example)
  }
}
