//
//  ContentView.swift
//  SwiftUI Advanced
//
//  Created by Mack Pessoal on 24/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextField: Bool = false
    @State private var editingPasswordTextField: Bool = false
    
    var body: some View {
        ZStack {
            Image("background-3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Sing up")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                    Text("Acess to 120+ hours of courses, tutorials asn livestreams")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                    HStack(spacing: 12) {
                        TextFieldIcon(iconName: "envelope.open.fill", currentEditing: $editingEmailTextField)
                        TextField("Email", text: $email) { isEditing in
                            editingEmailTextField = true
                            editingPasswordTextField = false
                            
                        }
                            .colorScheme(.dark)
                            .foregroundColor(.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                    }
                    .frame(height: 52)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: 1)
                            .blendMode(.overlay)
                    }
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    
                    HStack(spacing: 12) {
                        TextFieldIcon(iconName: "key.fill", currentEditing: $editingPasswordTextField)
                        SecureField("Password", text: $password)
                            .colorScheme(.dark)
                            .foregroundColor(.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.password)
                    }
                    .frame(height: 52)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: 1)
                            .blendMode(.overlay)
                    }
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    .onTapGesture {
                        editingPasswordTextField = true
                        editingEmailTextField = false
                    }
                    
                    GradientButton()
                    
                    Text("By clickin on Sing up, you agree to our Terms of services and Privacy policy")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.7))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Button {
                            print("Switch to Sing in")
                        } label: {
                            HStack(spacing: 4) {
                                Text("Already have an account?")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                GradientText(text: "Sign in")
                                    .font(.footnote)
                                    .bold()
                            }
                        }

                    }
                    

                }
                .padding(20)
            }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.white.opacity(0.3))
                    .background(Color("secondaryBackground").opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


