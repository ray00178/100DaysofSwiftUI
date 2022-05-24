//
//  Day40View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/22.
//

import SwiftUI

struct Day40View: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(missions) { (mission) in
                        NavigationLink {
                            Text("Detail View")
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding(.vertical)
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                        .stroke(.yellow)
                            )
                        }
                    }
                }
                .padding([.vertical, .horizontal])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            // we can tell SwiftUI our view prefers to be in dark mode always – this will cause the title to be in white no matter what, and will also darken other colors such as navigation bar backgrounds.
            .preferredColorScheme(.dark)
        }
    }
}

struct Day40View_Previews: PreviewProvider {
    static var previews: some View {
        Day40View()
    }
}

