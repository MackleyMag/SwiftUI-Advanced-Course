//
//  TextFieldIcon.swift
//  SwiftUI Advanced
//
//  Created by Mack Pessoal on 25/08/23.
//

import SwiftUI

struct TextFieldIcon: View {
    var iconName: String
    @Binding var currentEditing: Bool
    
    var gradient1: [Color] = [
          Color.init(red: 101/255, green: 134/255, blue: 1),
          Color.init(red: 1, green: 64/255, blue: 80/255),
          Color.init(red: 109/255, green: 1, blue: 185/255),
          Color.init(red: 39/255, green: 232/255, blue: 1)
      ]
    
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .dark) {
                ZStack {
                    if currentEditing{
                        AngularGradient(
                            gradient: Gradient(colors: gradient1),
                            center: .center,
                            angle: .degrees(0)
                        ).blur(radius: 10)
                    }
                    Color("tertiaryBackground")
                        .cornerRadius(12)
                        .opacity(0.8)
                    .blur(radius: 3.0)
                }
            }
            .cornerRadius(12)
            .overlay (
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: 1)
                        .blendMode(.overlay)
                    Image(systemName: iconName)
                        .gradientForeGround(colors: [Color("pink-gradient-1"),Color("pink-gradient-2")])
                        .font(.system(size: 17, weight: .medium))
                }
            )
            .frame(width: 36, height: 36, alignment: .center)
            .padding([.vertical, .leading], 8)
            
        }
    }
}

struct TextFieldIcon_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldIcon(iconName: "key.fill", currentEditing: .constant(false))
    }
}
