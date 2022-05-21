//
//  Day39View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/18.
//

import SwiftUI

struct Day39View: View {
    
    @State var profile: Profile?
    
    let layout = [
        GridItem(.adaptive(minimum: 80.0, maximum: 100.0)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    var body: some View {
        
        // 5️⃣ How to lay out views in a scrolling grid
        ScrollView(.vertical) {
            // 幾欄
            LazyVGrid(columns: layout, alignment: .center, spacing: 12) {
                ForEach(0 ..< 1000) {
                    Text("Item \($0)")
                        .font(.system(size: 16.0, weight: .medium, design: .monospaced))
                        .padding([.leading, .trailing], 8.0)
                }
            }
        }
        
        // 4️⃣ Working with hierarchical Codable data
        /*VStack(spacing: 12) {
            Button("Decode JSON") {
                let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Taiwan 🇹🇼"
                    }
                }
                """
                
                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                if let value = try? decoder.decode(Profile.self, from: data) {
                    profile = value
                }
            }
            
            Text(profile?.address.city ?? "")
                .font(.title)
        }*/
        
        // 3️⃣ Pushing new views onto the stack using NavigationLink
        /*NavigationView {
            List(0 ..< 100) { (row) in
                NavigationLink {
                    Text("TextView Detail \(row)")
                } label: {
                    Text("Row \(row)")
                        .font(.title)
                        .tint(.yellow)
                }
            }
            .navigationTitle("SwiftUI")
        }*/
        
        // 2️⃣ How ScrollView lets us work with scrolling data
        /*ScrollView {
            LazyVStack {
                ForEach(0 ..< 30) {
                    CustomView("Item \($0 + 1)")
                }
            }
            // lazy stacks always take up as much as room as is available in our layouts, whereas regular stacks take up only as much space as is needed.
            //.frame(maxWidth: .infinity)
        }*/
        
        // 1️⃣ Resizing images to fit the screen using GeometryReader
        // Tip: If you ever want to center a view inside a GeometryReader, rather than aligning to the top-left corner, add a second frame that makes it fill the full space of the container, like this:
        /*GeometryReader { geo in
            Image("US", bundle: nil)
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.3)
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }*/
    }
}

struct Day39View_Previews: PreviewProvider {
    static var previews: some View {
        Day39View()
    }
}

// MARK: - Custom View

struct CustomView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .padding(12)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

// MARK: - Model
 
extension Day39View {
    
    struct Profile: Decodable {
        
        var name: String
        var address: Address
        
    }

    struct Address: Decodable {
        
        var street: String
        var city: String
        
    }
}

