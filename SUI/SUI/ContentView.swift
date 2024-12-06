//
//  ContentView.swift
//  SUI
//
//  Created by Игорь Девин on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isOnToggle = false
    @State private var primaryCardAccount = 50000.0
    @State private var isShowingActionSheet = false
    @State private var isShowingAlert = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    VStack() {
                        Button(action: {
                        }) {
                            VStack {
                                Image("logoCard")
                            }
                            HStack {
                                VStack {
                                    Text("50 000,00 ₽")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Text("MIR  **0001")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        Button(action: {
                        }) {
                            VStack {
                                Image("logoCard")
                            }
                            HStack {
                                VStack {
                                    Text("100 000,00 ₽")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Text("MIR  **0002")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.leading, 10)
                        Button(action: {
                        }) {
                            VStack {
                                Image("logoCard")
                            }
                            HStack {
                                VStack {
                                    Text("1 000,00 ₽")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Text("MIR  **0003")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 0).fill(Color("basicBackgroundColor"))
                    .offset(x: isOnToggle ? 300: 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3))
                    .edgesIgnoringSafeArea(.all)
                Spacer()
                VStack {
                    Text("Карта 1")
                        .font(.custom("Inter-Bold", size: 20))
                        .padding(.leading, -160)
                        .padding(.bottom, 20)
                    ZStack(alignment: .bottom) {
                        Image("backgroundCard")
                        Text(String(primaryCardAccount))
                            .font(.custom("Inter-Bold", size: 20))
                            .foregroundColor(.white)
                            .padding(.bottom, 160)
                            .padding(.leading, -160)
                        Text("Доступно")
                            .foregroundColor(.gray)
                            .padding(.bottom, 135)
                            .padding(.leading, -160)
                        Image("logoCardMir")
                            .padding(.leading, 225)
                            .padding(.bottom, 15)
                    }
                    .padding(.bottom)
                    ZStack {
                        Image("backgroundOperationsCard")
                        HStack {
                            Spacer()
                            Button(action: {
                                isShowingActionSheet.toggle()
                            }) {
                                VStack {
                                    Image("replenishIcon")
                                        .padding(.bottom, 10)
                                    Text("Пополнить")
                                        .padding(.bottom)
                                        .foregroundColor(.black)
                                }
                            }
                            .actionSheet(isPresented: $isShowingActionSheet) {
                                ActionSheet(title: Text("Хотите пополнить счет?"), message: nil, buttons: [.default(Text("Пополнить на 1000 ₽"), action: {
                                    primaryCardAccount += 1000
                                }), .cancel()])
                            }
                            Spacer()
                            Button(action: {
                                isShowingAlert.toggle()
                            }) {
                                VStack {
                                    Image("translateIcon")
                                        .padding(.bottom, 10)
                                    Text("Перевести")
                                        .padding(.bottom)
                                        .foregroundColor(.black)
                                }
                            }
                            .alert(isPresented: $isShowingAlert, content: {
                                Alert(title: Text("Перевод"), message: Text("Перевести 1000 рублей на карту1?"), primaryButton: .cancel(), secondaryButton: .default(Text("Ok"), action: {
                                    primaryCardAccount -= 1000
                                }))
                            })
                            Spacer()
                            Button(action: {
                                print("Открытие карты")
                            }) {
                                VStack {
                                    Image("openCardIcon")
                                        .padding(.bottom, 5)
                                    Text("Открыть \nкарту")
                                        .foregroundColor(.black)
                                }
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .offset(x: isOnToggle ? 300: 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3))
            }
            Toggle(isOn: $isOnToggle, label: {
                Text("Показать мой кошелёк")
            })
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

