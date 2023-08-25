//
//  GradientText.swift
//  SwiftUI Advanced
//
//  Created by Mack Pessoal on 25/08/23.
//

import SwiftUI

struct GradientText: View {
    var text: String = "Text here"
    var body: some View {
        Text(text)
            .gradientForeGround(colors: [Color("pink-gradient-1"), Color("pink-gradient-2")])
    }
}

struct GradientText_Previews: PreviewProvider {
    static var previews: some View {
        GradientText()
    }
}

extension View {
    public func gradientForeGround(colors: [Color]) -> some View {
        self
            .overlay {
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
                .mask(self)
        }
    }
}
