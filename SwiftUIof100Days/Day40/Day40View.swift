//
//  Day40View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/22.
//

import SwiftUI

struct Day40View: View {
    
    var body: some View {
        
        let astronauts = Bundle.main.decode("astronauts.json")
        
        Text("astronauts count = \(astronauts.count)")
    }
}

struct Day40View_Previews: PreviewProvider {
    static var previews: some View {
        Day40View()
    }
}

