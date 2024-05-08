//
//  SignUpView.swift
//  SUI
//
//  Created by Игорь Девин on 08.05.2024.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - Constants
    
    private enum Constants {
        static let getButtonnTitle = "Sing up"
        static let passwordTitle = "Forgot your password?"
        static let chekButton = "Check Verification"
        static let passwordLabel = "Password"
        static let toggleViewLeading = "Log In"
        static let toggleViewTrailing = "Sing Up"
    }
    
    var body: some View {
        NavigationView(content: {
            ZStack {
                backgroundNavigation
                VStack{
                    toggleSwitchView
                    Spacer()
                        .frame(height: 90)
                    textfildsView
                    Spacer()
                        .frame(height: 90)
                    signUpButton
                    otheView.onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        })
    }
    
    private var backgroundNavigation: some View {
        VStack {
            Rectangle().fill(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .leading, endPoint: .trailing))
                .frame(width: 400, height: 100)
            Spacer()
        }.ignoresSafeArea()
    }
    
    private var toggleSwitchView: some View {
            HStack(spacing: 0) {
                Text(Constants.toggleViewLeading)
                    .modifier(ButtonTextModifier())
                    .cornerRadius(27, corners: [.bottomLeft, .topLeft])
                Text(Constants.toggleViewTrailing)
                    .modifier(ButtonTextModifier())
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(27, corners: [.bottomRight, .topRight])
            }
            .overlay(
                RoundedRectangle(cornerRadius: 27)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 3)
            )
        }
    
    @State private var numberPhoneTextField = ""
    @State private var passwordTextField = ""
    @State private var isVisiblePassword = false
    @FocusState var focused: Int?
    private var textfildsView: some View {
        VStack(alignment: .leading) {
            TextField("+7 (999) 999-99-99", text: $numberPhoneTextField, onCommit: {
                focused = 2
            })
            .onChange(of: numberPhoneTextField, perform: { oldValue in
                numberPhoneTextField = format(with: "+X (XXX) XXX-XX-XX", phone: oldValue)
                if numberPhoneTextField.count == 18 {
                    focused = 2
                }
                        })
            .id(1)
            .focused($focused, equals: 1)
            .textFieldStyle(.plain)
            .padding(10)
            .padding(.leading)
            .keyboardType(.numberPad)
            Divider()
            Spacer()
                .frame(height: 30)
            Text(Constants.passwordLabel)
                .padding(.leading)
            HStack {
                if isVisiblePassword{
                    SecureField("••••••••", text: $passwordTextField)
                        .id(2)
                        .focused($focused, equals: 2)
                } else {
                    TextField("••••••••", text: $passwordTextField)
                        .id(2)
                        .focused($focused, equals: 2)
                }
                Button {
                    isVisiblePassword.toggle()
                } label: {
                    Image(systemName: isVisiblePassword ? "eye" : "eye.slash")
                        .foregroundColor(.black)
                }
                .padding(.trailing)
                
            }
            .padding(10)
            .padding(.leading)
            Divider()
            
        }.onAppear() {
            focused = 1
        }
    }
    
    @State private var isShowDetail = false
    private var signUpButton: some View {
        VStack {
            SignUpButtonView(title: Constants.getButtonnTitle, action: {
                isShowDetail.toggle()
            })
        }.fullScreenCover(isPresented: $isShowDetail, content: {
            DetailView()
        })
    }
    
    @State private var isShowAlert = false
    private var otheView: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Button {
                isShowAlert = true
            } label: {
                Text(Constants.passwordTitle)
                    .foregroundColor(.black.opacity(0.6))
                    .font(.title3.bold())
            }
            Spacer()
                .frame(height: 20)
            
            NavigationLink {
                VerificationView()
            } label: {
                Text(Constants.chekButton)
            }
            .foregroundColor(.black.opacity(0.6))
            .font(.title2.bold())
            Divider()
                .frame(width: 150)
                .background(Color.black)
        }
        .alert("Need help?", isPresented: $isShowAlert) {
            
        } message: {
            Text("88005553535")
        }
    }
    
    func format(with mask: String, phone: String) -> String {
            let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            var result = ""
            var index = numbers.startIndex
            
            for ch in mask where index < numbers.endIndex {
                if ch == "X" {
                    result.append(numbers[index])
                    index = numbers.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            return result
        }
}

#Preview {
    SignUpView()
}


