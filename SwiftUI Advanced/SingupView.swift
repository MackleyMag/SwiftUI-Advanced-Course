//
//  ContentView.swift
//  SwiftUI Advanced
//
//  Created by Mack Pessoal on 24/08/23.
//

import SwiftUI
import AudioToolbox
import Firebase

struct SingupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextField: Bool = false
    @State private var editingPasswordTextField: Bool = false
    
    @State private var emailIconBounce: Bool = false
    @State private var passwordIconBounce: Bool = false
    
    @State private var showProfileView: Bool = false
    
    private let generator = UISelectionFeedbackGenerator()
    
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
                            .scaleEffect(emailIconBounce ? 1.2 : 1.0)
                        TextField("Email", text: $email) { isEditing in
                            editingEmailTextField = isEditing
                            editingPasswordTextField = false
                            generator.selectionChanged()
                            if isEditing {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                    emailIconBounce.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                        emailIconBounce.toggle()
                                    }
                                }
                            }
                        }
                            .colorScheme(.dark)
                            .foregroundColor(.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                    }
                    .frame(height: 52)
                    .overlay (
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: 1)
                            .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    
                    HStack(spacing: 12) {
                        TextFieldIcon(iconName: "key.fill", currentEditing: $editingPasswordTextField)
                            .scaleEffect(passwordIconBounce ? 1.2 : 1.0)
                        SecureField("Password", text: $password)
                            .colorScheme(.dark)
                            .foregroundColor(.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.password)
                    }
                    .frame(height: 52)
                    .overlay (
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: 1)
                            .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    .onTapGesture {
                        editingPasswordTextField = true
                        editingEmailTextField = false
                    }
                    
                    GradientButton(buttonTitle: "Create account") {
                        generator.selectionChanged()
                        singUp()
                    }
                    .onAppear {
                        Auth.auth()
                            .addStateDidChangeListener { auth, user in
                                if user != nil {
                                    showProfileView.toggle()
                                }
                        }
                    }
                    
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
                                    .font(.footnote
                                        .bold())
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
//        .fullScreenCover(isPresented: $showProfileView) {
//            ProfileView()
//        }
    }
    
    func singUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            print("User singned up")
        }
    }
}

struct SingupView_Previews: PreviewProvider {
    static var previews: some View {
        SingupView()
    }
}


