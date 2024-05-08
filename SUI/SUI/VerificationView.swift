//
//  VerificationView.swift
//  SUI
//
//  Created by Игорь Девин on 08.05.2024.
//

import SwiftUI

struct VerificationView: View {
    // MARK: - Constants
    
    private enum Constants {
        static let imageTitle = "Verification code"
        static let smsTitle = "Check the SMS"
        static let messageTitle = "message to get verification code"
        static let receiveTitle = "Didn’t receive sms"
    }
    
    // MARK: - FocusPin
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, inOut
    }
    
    @Environment(\.presentationMode) var presenter
    @FocusState private var pinFocusState : FocusPin?
    var body: some View {
        ZStack {
            backgroundNavigation
            VStack{
                imageLogo
                    .focusable()
                    .focused($pinFocusState, equals: .inOut)
                textFieldView
                otherLabel
                otherTitle
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Verification")
            .navigationBarItems(leading: Button(action: {
                presenter.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }))
            
            if isShowProgressView {
                ProgressView()
            }
        }
    }
    private var backgroundNavigation: some View {
        VStack {
            Rectangle().fill(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .leading, endPoint: .trailing))
                .frame(width: 400, height: 100)
            Spacer()
        }.ignoresSafeArea()
    }
    
    private var imageLogo: some View {
        VStack(spacing: 0) {
            Image("image")
                .frame(width: 200, height: 200)
            Text(Constants.imageTitle)
                .font(Font.system(size: 20))
                .foregroundColor(.black.opacity(0.7))
        }
    }
    
    @State private var textFieldOne = ""
    @State private var textFieldTwo = ""
    @State private var textFieldThree = ""
    @State private var textFieldFour = ""
    
    private var textFieldView: some View {
        HStack(spacing:15, content: {
                TextField("", text: $textFieldOne)
                    .modifier(OtpModifer())
                    .onChange(of: textFieldOne, { oldValue, newValue in
                        if (newValue.count == 1) {
                            pinFocusState = .pinTwo
                        }
                    })
                    .focused($pinFocusState, equals: .pinOne)
                TextField("", text:  $textFieldTwo)
                    .modifier(OtpModifer())
                    .onChange(of: textFieldTwo, { oldValue, newValue in
                        if (newValue.count == 1) {
                            pinFocusState = .pinThree
                        }else {
                            if (newValue.count == 0) {
                                pinFocusState = .pinOne
                            }
                        }
                    })
                    .focused($pinFocusState, equals: .pinTwo)
            TextField("", text:$textFieldThree)
                .modifier(OtpModifer())
                .onChange(of: textFieldThree, { oldValue, newValue in
                    if (newValue.count == 1) {
                        pinFocusState = .pinFour
                    }else {
                        if (newValue.count == 0) {
                            pinFocusState = .pinTwo
                        }
                    }
                })
                .focused($pinFocusState, equals: .pinThree)
                TextField("", text: $textFieldFour)
                    .modifier(OtpModifer())
                    .onChange(of: textFieldFour, { oldValue, newValue in
                        if (newValue.count == 0) {
                            pinFocusState = .pinThree
                        } else if newValue.count == 1 {
                            pinFocusState = .inOut
                        }
                    })
                    .focused($pinFocusState, equals: .pinFour)
        })
        .padding(.vertical)
    }
    
    @State private var isShowProgressView = false
    private var otherLabel: some View {
        VStack {
            Text(Constants.smsTitle)
                .foregroundColor(.black.opacity(0.6))
                .font(.title3.bold())
            Text(Constants.messageTitle)
                .foregroundColor(.black.opacity(0.6))
                Spacer()
                .frame(height: 30)
            SignUpButtonView(title: "Continue") {
                isShowProgressView.toggle()
            }
        }
    }
    
    @State private var isShowAlert = false
    private var otherTitle: some View {
        VStack {
            Text(Constants.receiveTitle)
                .foregroundColor(.black.opacity(0.6))
                .padding()
            Button {
                isShowAlert = true
            } label: {
                Text("Send sms again")
                    .foregroundColor(.black.opacity(0.6))
                    .font(.title2.bold())
            }
            Divider()
                .frame(width: 150)
                .background(Color.black)
        }
        .alert("Fill in from message", isPresented: $isShowAlert) {
            Button("Cancel"){}
            Button(role: .cancel) {
                let title = String(Int.random(in: 1000...9999))
               let array = title.compactMap({$0})
                textFieldOne = String(array.first ?? Character(""))
                textFieldTwo = String(array[1])
                textFieldThree = String(array[2])
                textFieldFour = String(array.last ?? Character(""))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    pinFocusState = .inOut
                })
            } label: {
                Text("ok")
            }
        } message: {
            Text(String(Int.random(in: 1000...9999)))
        }
    }
}

#Preview {
    VerificationView()
}
