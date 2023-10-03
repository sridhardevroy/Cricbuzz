//
//  ContentView.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 02/10/23.
//

import SwiftUI

struct ContentView: View {
    let currentRating: CGFloat
    var body: some View {
        CustomRatingView(currentRating: .constant(currentRating))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentRating: 7.5)
    }
}
