//
//  ConnectionView.swift
//  iPult
//
//  Created by Александр Менщиков on 08.04.2020.
//  Copyright © 2020 Alexander Menshikov. All rights reserved.
//

import SwiftUI

struct ConnectionView: View {
    
    @EnvironmentObject var list_Connect: ListConnect
    
    let appContent = Connect()
    
    @State private var showTypeServer = false
    @State var showFavoritesOnly = false
    
    @State private var showingActionSheet = false
    
    @State var nameConnect = NSLocalizedString("Server", comment: "")
    @State var typeServer = Connect.TypeServerSelect.tsDisp
    @State var typeServerSelect = "Disp"
    @State var organization = ""
    @State var ip_Address = "demo.ru"
    @State var UDP_Port = "45002"
    @State var TCP_Port = "45002"
    @State var userName = "iSPult"
    @State var userPassword = "654321"
    
    var body: some View {
        NavigationView {
            VStack (){
                /*HStack() {
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("Принимать уведомления")
                            .fontWeight(.bold)
                    }
                }*/
                
                HStack() {
                    Text ("Наименование")
                        .fontWeight(.bold)
                        .frame(width: 150)
                    TextField("Введите значение", text: $nameConnect)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                /*HStack() {
                    Text ("Тип сервера")
                        .fontWeight(.bold)
                        //.multilineTextAlignment(.trailing)
                        .frame(width: 150)
                    TextField("Введите значение", value: $typeServer, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }*/
                
                HStack() {
                    Text ("Тип сервера")
                        .fontWeight(.bold)
                        .frame(width: 150)
                    Spacer()
                    Button(action: {
                        self.showingActionSheet = true
                    }) {
                        Text(typeServerSelect)
                    }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text("Тип сервера"), buttons: [
                            .default(Text("isp"), action: {
                                self.typeServer = Connect.TypeServerSelect.tsDisp
                                self.typeServerSelect = "Disp"
                            }),
                            .default(Text("Cloud"), action: {
                                self.typeServer = Connect.TypeServerSelect.tsCloud
                                self.typeServerSelect = "Cloud"
                            }),
                            .default(Text("Domain"), action: {
                                self.typeServer = Connect.TypeServerSelect.tsDomain
                                self.typeServerSelect = "Domain"
                            }),
                            .cancel()])
                    }
                }

                HStack() {
                    Text ("Организация")
                        .fontWeight(.bold)
                        .frame(width: 150)
                    TextField("Введите значение", text: $organization)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack() {
                    Text ("IP адрес")
                        .fontWeight(.bold)
                        .frame(width: 150)
                    TextField("Введите IP адрес", text: $ip_Address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                //.frame(height: 70)
                
                HStack() {
                    Text ("UDP порт")
                        .fontWeight(.bold)
                        .frame(width: 150)
                    TextField("Введите UDP порт", text: $UDP_Port)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                //.frame(height: 70)
                
                HStack() {
                    Text ("TCP порт")
                        .fontWeight(.bold)
                        .frame(width: 150)
                    TextField("Введите TCP порт", text: $TCP_Port)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack() {
                    Text ("Пользователь")
                        .fontWeight(.bold)
                        .frame(width: 150)
                    TextField("Введите имя", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack() {
                    Text ("Пароль")
                        .fontWeight(.bold)
                        .frame(width: 150)
                    SecureField("Введите пароль", text: $userPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: {
                    self.appContent.nameConnect = self.nameConnect
                    self.appContent.typeServer = self.typeServer
                    self.appContent.organization = self.organization
                    self.appContent.ip_Address = self.ip_Address
                    self.appContent.UDP_Port = Int(self.UDP_Port)!
                    self.appContent.TCP_Port = Int(self.TCP_Port)!
                    self.appContent.userName = self.userName
                    self.appContent.userPassword = self.userPassword
                    
                    self.list_Connect.array_Connect.append(self.appContent)
                    print ("Количество элементов в массиве \(self.list_Connect.array_Connect.count)")
                    self.list_Connect.XML_Save()
                }) {
                    Text("Подключиться")
                }

                Spacer()
            } //VStack
                .navigationBarTitle(Text("Подключение"))
            .padding()
        } //NavigationView
    } //body
    
} //ConnectionView


struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}
