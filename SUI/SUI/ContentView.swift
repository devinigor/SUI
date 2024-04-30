//
//  ContentView.swift
//  SUI
//
//  Created by Игорь Девин on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresentAlert = false
    @State private var isShowAlert = false
    @State private var isPresentSheet = false
    @State private var isShowSheet = false
    
    @State var secondAlertText = "Пример Alert с 2 \nкнопками и логикой"
    @State var secondSheetText = "Пример ActionSheet \nкнопками и логикой"
    @State var newText = "The text has been changed"
    @State var coke = "Coke"
    @State var pepsi = "Pepsi"
    @State var delete = "O_o"
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("Alert & ActionSheet")
                .lineLimit(1)
                .font(.custom("Inter-Bold", fixedSize: 20))
                .offset(y: -50)
            
            HStack {
                Text("Пример Alert")
                    .font(.custom("Inter-Bold", fixedSize: 14))
                Spacer()
                Button {
                    isPresentAlert = true
                } label: {
                    Text("Показать")
                }
                .frame(width: 150, height: 40)
                .shadow(radius: 8)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .alert(isPresented: $isPresentAlert, content: {
                    Alert(title: Text("Download file?"), message: nil, dismissButton: .default(Text("Ok")))
                })
            }
            
            HStack {
                Text(secondAlertText)
                    .font(.custom("Inter-Bold", fixedSize: 14))
                Spacer()
                Button(action: {
                    isShowAlert = true
                }) {
                    Text("Показать")
                }.alert(isPresented: $isShowAlert) {
                    Alert(title: Text("Do you want to change the text?"), message: nil, primaryButton: .default(Text("Сhange the text"), action: {
                        secondAlertText = newText
                    }), secondaryButton: .cancel())
                }
                .frame(width: 150, height: 40)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .shadow(radius: 8)
                .cornerRadius(10)
            }
            
            HStack {
                Text("Пример ActionSheet")
                    .font(.custom("Inter-Bold", fixedSize: 14))
                Spacer()
                Button(action: {
                    isPresentSheet = true
                }) {
                    Text("Показать")
                }.actionSheet(isPresented: $isPresentSheet) {
                    ActionSheet(title: Text("Coke or Pepsi?"), message: nil, buttons: [.default(Text("Coke")), .default(Text("Pepsi"))])
                }
                .frame(width: 150, height: 40)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .shadow(radius: 8)
                .cornerRadius(10)
            }
            
            HStack {
                Text(secondSheetText)
                    .font(.custom("Inter-Bold", fixedSize: 14))
                Spacer()
                Button(action:  {
                    isShowSheet = true
                }) {
                    Text("Показать")
                }.actionSheet(isPresented: $isShowSheet) {
                    ActionSheet(title: Text("Coke or Pepsi?"), message: Text("Please, make a choice"), buttons: [.default(Text("Coke"), action: {
                        secondSheetText = coke
                    }), .default(Text("Pepsi"), action: {
                        secondSheetText = pepsi
                    }), .destructive(Text("Delete"), action: {
                        secondSheetText = delete
                    })])
                }
                .frame(width: 150, height: 40)
                .shadow(radius: 8)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
        }
        .padding(.top, -300)
        .padding()
    }
}

#Preview {
    ContentView()
}

