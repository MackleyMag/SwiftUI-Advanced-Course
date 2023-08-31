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
    @State private var singupToggle: Bool = true
    
    @State private var rotationAngle = 0.0
    @State private var signInWIthAppleObject = SignInWithAppleObject()
    @State private var fadeToggle: Bool = true
    
    @State private var showAlertView: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Image(singupToggle ? "background-3" : "background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 1.0 : 0.0)
            
            Color("secondaryBackground")
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 0.0 : 1.0)
            
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text(singupToggle ? "Sing up" : "Sing in")
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
                    
                    GradientButton(buttonTitle: singupToggle ? "Create account" : "Sing in") {
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
                    
                    if singupToggle {
                        
                        Text("By clickin on Sing up, you agree to our Terms of services and Privacy policy")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.7))
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white.opacity(0.1))
                    }
                    VStack(alignment: .leading, spacing: 16) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                fadeToggle.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                    withAnimation(.easeInOut(duration: 0.35)) {
                                        self.fadeToggle.toggle()
                                    }
                                }
                            }
                            withAnimation(.easeInOut(duration: 0.7)) {
                                singupToggle.toggle()
                                self.rotationAngle += 180
                            }
                        }, label: {
                            HStack(spacing: 4) {
                                Text(singupToggle ? "Already have an account?" : "Dont have an account?")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.7))
                                GradientText(text: singupToggle ? "Sign in" : "Sing up")
                                    .font(.footnote.bold())
                            }
                        })
                        
                        if !singupToggle {
                            Button {
                                sendPasswordResetEmail()
                            } label: {
                                HStack(spacing: 4) {
                                    Text("Forgot password?")
                                        .font(.footnote)
                                        .foregroundColor(.white.opacity(0.7))
                                    GradientText(text: "Reset password")
                                        .font(.footnote.bold())
                                }
                            }
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white.opacity(0.1))
                            Button {
                                signInWIthAppleObject.singInWithApple()
                            } label: {
                                SignInWithAppleButton()
                                    .frame(height: 50)
                                    .cornerRadius(16)
                            }

                            
                        }
                    }
                    
                    
                }
                .padding(20)
            }
            .rotation3DEffect(
                Angle(degrees: self.rotationAngle),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.white.opacity(0.3))
                    .background(Color("secondaryBackground").opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            .rotation3DEffect(
                Angle(degrees: self.rotationAngle),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .alert(isPresented: $showAlertView) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
            }
        }
        //        .fullScreenCover(isPresented: $showProfileView) {
        //            ProfileView()
        //        }
    }
    
    func singUp() {
        if singupToggle {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    self.alertTitle = "Uh-oh!"
                    self.alertMessage = "error!.localizedDescription"
                    self.showAlertView.toggle()
                    return
                }
                
                print("User singned up")
            }
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    self.alertTitle = "Uh-oh!"
                    self.alertMessage = "error!.localizedDescription"
                    self.showAlertView.toggle()
                    return
                }
                
                print("User singned in")
            }
        }
    }
    
    func sendPasswordResetEmail() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                alertTitle = "Uh-oh!"
                alertMessage = (error!.localizedDescription)
                showAlertView.toggle()
                return
            }
            alertTitle = "Password reset email sent"
            alertMessage = "Check your inbox for an email to reset your password"
            showAlertView.toggle()
        }
    }
}

struct SingupView_Previews: PreviewProvider {
    static var previews: some View {
        SingupView()
    }
}


