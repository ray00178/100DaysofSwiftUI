//
//  Day49View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/9.
//

import SwiftUI

struct Day49View: View {
    
    @State private var resuls = [Result]()
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        /*Form {
            Section {
                TextField("UserName", text: $username)
                TextField("E-Mail", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }*/
        
        List(resuls, id: \.trackId) { (item) in
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: "https://cdn.ftvnews.com.tw/manasystem/FileData/News/e59fb82f-9df4-4b43-b78a-8542b1137613.jpg")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
        }
        // SwiftUI provides a different modifier for these kinds of tasks,
        // giving it a particularly easy to remember name: task().
        // This can call functions that might go to sleep for a while;
        // all Swift asks us to do is mark those functions with a second keyword,
        // await, so we’re explicitly acknowledging that a sleep might happen.
        .task {
            await fetchDataset()
        }
    }
    
    func fetchDataset() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song")
        else {
            print("Invalid URL")
            return
        }
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            
            print("Response = \(response)")
            
            if let decode = try? JSONDecoder().decode(Response.self, from: data) {
                resuls = decode.results
            }
            
        } catch {
            
        }
    }
}

struct Day49View_Previews: PreviewProvider {
    static var previews: some View {
        Day49View()
    }
}
