//
//  ContentView.swift
//  SUI
//
//  Created by Игорь Девин on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Constants
    
    private enum Constants {
        static let defaultPrice = 2_189_900
        static let logoImage = "logo"
        static let sharedButton = "arrowshape.turn.up.right.fill"
        static let title = "Информация об автомобиле"
        static let engineTitle = "Двигатель"
        static let transmisiion = "Привод"
        static let equipment = "Комплектация"
        static let priceTitle = "Цена"
        static let kaskoTitle = "ОМОДА Каско"
        static let cancelButton = "Нет,не нужно"
        static let agreeButton = "Да"
        static let alertMessage = "Подключить Каско на выгодных условиях?"
        static let actionSheetMessage = "Благодарим за заказ. Наш менеджер свяжется с Вами в рабочее время для уточнения деталей."
        static let titleOrderButton = "Заказать"
    }
    
    @ObservedObject private var carViewModel = CarViewModel()
    @State private var price = Constants.defaultPrice
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 70)
            carImage
            segment
            ZStack {
                rectangleView
                    .ignoresSafeArea()
                infoCar
            }
        }
        .background(Color.back)
    }
    
    @State private var selectedIndex = 0
    private var segment: some View {
        Picker("", selection: $selectedIndex) {
            ForEach(0..<carViewModel.cars.count, id: \.self){
                Text(carViewModel.cars[$0].model)
                    .tag($0)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .pickerStyle(.segmented)
        .onChange(of: selectedIndex) {newValue in
            isKaskoToogle = false
            price = carViewModel.cars[newValue].price
        }
    }
    
    @State private var isSharedPressed = false
    private var carImage: some View {
        VStack{
            HStack {
                Spacer()
                Image(Constants.logoImage)
                Spacer()
                Button(action: {
                    isSharedPressed = true
                }, label: {
                    Image(systemName: Constants.sharedButton)
                        .tint(.white)
                })
            }.padding(.horizontal)
            Image(carViewModel.cars[selectedIndex].carImage)
                .frame(width: 345, height: 198)
        }
        .sheet(isPresented: $isSharedPressed, content: {
            ActivityView(activityItems: ["Omoda \(carViewModel.cars[selectedIndex].model) - я выбираю тебя"])
        })
    }
    
    private var rectangleView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
    }
    
    private var infoCar: some View {
        VStack(spacing:0) {
            Spacer()
                .frame(height: 25)
            Text(Constants.title)
                .fontWeight(.heavy)
            configurationView(title: Constants.engineTitle, info: "Есть")
            configurationView(title: Constants.transmisiion, info: "AWD")
            configurationView(title: Constants.equipment, info: "", divider: false)
            slider
            kaskoToggle
            configurationView(title: Constants.priceTitle, info: "\(price) руб", divider: false)
                .font(.headline)
            orderButton
            Spacer()
        }
    }
    
    private func configurationView(title: String, info: String, divider: Bool = true) -> some View {
        VStack{
            HStack{
                Text(title)
                Spacer()
                Text(info)
            }
            if divider {
                Divider()
                    .padding(.horizontal, 60)
            }
        }
        .padding()
    }
    
    @State private var sliderSelection = 0.0
    private var complictations = ["Joy", "Lifestyle", "Ultimate", "Active","Supreme"]
    private var slider: some View {
        VStack{
            Slider(value: $sliderSelection, in: 0...4, step: 1)
                .onAppear {
                    let progressCircleConfig = UIImage.SymbolConfiguration(scale: .small)
                    UISlider.appearance()
                        .setThumbImage(UIImage(systemName: "circle.fill",
                                               withConfiguration: progressCircleConfig), for: .normal)
                }
                .tint(.black)
            HStack(spacing: 34){
                ForEach(0..<complictations.count, id: \.self){ item in
                    Text(complictations[item])
                        .font(.system(size: 12))
                }
            }
        }
        .padding(.horizontal)
        .onChange(of: sliderSelection) {newValue in
            price += 190_000
        }
    }
    
    @State private var isKaskoToogle = false
    @State private var alertCall = false
    private var kaskoToggle: some View {
        VStack(spacing: 0){
            Toggle(Constants.kaskoTitle, isOn: $isKaskoToogle)
            Divider()
                .padding(.horizontal, 60)
        }
        .padding()
        .alert(Constants.kaskoTitle, isPresented: $alertCall) {
            Button(Constants.cancelButton){isKaskoToogle = false}
            Button(role: .cancel, action: {
                price += 99_000
            },
                   label: {
                Text(Constants.agreeButton)
            })
        } message: {
            Text(Constants.alertMessage)
        }
        .onChange(of: isKaskoToogle) {value in
            if value {
                alertCall = value
            } else {
                price = carViewModel.cars[selectedIndex].price
            }
        }
    }
    
    @State private var actionSheetCall = false
    private var orderButton: some View {
        VStack{
            Button(action: {
                actionSheetCall.toggle()
            }, label: {
                Text(Constants.titleOrderButton)
            })
            .tint(.white)
            .frame(width: 358, height: 48)
            .background(Color.back)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }.confirmationDialog("", isPresented: $actionSheetCall) {
            
        } message: {
            Text(Constants.actionSheetMessage)
        }
    }
}

#Preview {
    ContentView()
}
