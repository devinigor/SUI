//
//  ContentView.swift
//  SUI
//
//  Created by Игорь Девин on 29.04.2024.
//
import SwiftUI

struct ContentView: View {
    var titleSettings = ["Авиарежим", "Wi-Fi", "Bluetooth" , "Сотовая связь", "Режим модема", "VPN"]
    @State private var aviaToogle = false
    @State private var vpnToogle = false
    @State private var selectMode = ["Подключено", "Не подключено"]
    @State private var selectWifi = 0
    @State private var selectBluetooth = 0
    @State private var selectMobile = 0
    @State private var selectModem = 0
    var body: some View {
        NavigationView{
            Form(content: {
                    settingCloud()
                Section{
                    NavigationLink("IOS 17.2: уже доступно") {}
                }
                otherSettings()
            }).navigationTitle("Настройки")
        }
    }
    func settingCloud() -> some View {
        Section {
            NavigationLink {
            } label: {
                VStack {
                    HStack{
                        Image("avatar")
                        VStack(alignment: .leading){
                            Text("Igor")
                                .fontWeight(.bold)
                            Text("Apple ID, iCloud, контент и покупки")
                        }
                    }
                }
            }
            NavigationLink("Предложения Apple ID") {}
        }
    }
    
    func otherSettings() -> some View {
        Section {
            VStack{
                HStack{
                    IconSetting(icon: "plane", color: .orange)
                    Toggle(isOn: $aviaToogle) {
                        Text(titleSettings[0])
                    }
                }
            }
                HStack{
                    IconSetting(icon: "wifi", color: .blue)
                    if #available(iOS 16.0, *) {
                        Picker(selection: $selectWifi) {
                            ForEach(0...1, id: \.self){ item in
                                Text(selectMode[item])
                            }
                        } label: {
                            Text(titleSettings[1])
                        }.pickerStyle(.navigationLink)
                    } else {
                    }
                }
                HStack{
                    IconSetting(icon: "bluetooth", color: .blue)
                    if #available(iOS 16.0, *) {
                        Picker(selection: $selectBluetooth) {
                            ForEach(0...1, id: \.self){ item in
                                Text(selectMode[item])
                            }
                        } label: {
                            Text(titleSettings[2])
                        }.pickerStyle(.navigationLink)
                    } else {
                    }
                }
                HStack{
                    IconSetting(icon: "phone", color: .green)
                    if #available(iOS 16.0, *) {
                        Picker(selection: $selectMobile) {
                            ForEach(0...1, id: \.self){ item in
                                Text(selectMode[item])
                            }
                        } label: {
                            Text(titleSettings[3])
                        }.pickerStyle(.navigationLink)
                    } else {
                    }
            }
                HStack{
                    IconSetting(icon: "modem", color: .green)
                    if #available(iOS 16.0, *) {
                        Picker(selection: $selectModem) {
                            ForEach(0...1, id: \.self){ item in
                                Text(selectMode[item])
                            }
                        } label: {
                            Text(titleSettings[4])
                        }.pickerStyle(.navigationLink)
                    } else {
                    }
                }
            HStack{
                IconSetting(icon: "global", color: .blue)
                Toggle(isOn: $vpnToogle) {
                    Text(titleSettings[5])
                }
            }
        }
    }
}

struct IconSetting: View {
    var icon: String
    var color: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 30, height: 30)
            Image(icon)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
