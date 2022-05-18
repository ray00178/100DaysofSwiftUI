//
//  Day39View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/5/18.
//

import SwiftUI

struct Day39View: View {
    var body: some View {
        // Tip: If you ever want to center a view inside a GeometryReader, rather than aligning to the top-left corner, add a second frame that makes it fill the full space of the container, like this:
        GeometryReader { geo in
            Image("US", bundle: nil)
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.3)
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
}

struct Day39View_Previews: PreviewProvider {
    static var previews: some View {
        Day39View()
    }
}
