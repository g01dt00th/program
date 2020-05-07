//
//  DetailView.swift
//  iPult
//
//  Created by Александр Менщиков on 27.04.2020.
//  Copyright © 2020 Alexander Menshikov. All rights reserved.
//

import SwiftUI

//let slist_Connect = ListConnect()

struct DetailView: View {
    let data_item: Connect
    
    @State private var showingActionSheet = false
    
    @State private var nameConnect = ""
    @State var typeServer = Connect.TypeServerSelect.tsDisp
    @State var typeServerSelect = ""
    @State var organization = ""
    @State var ip_Address = ""
    @State var UDP_Port = ""
    @State var TCP_Port = ""
    @State var userName = ""
    @State var userPassword = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack() {
                    Text ("Наименование")
                        .fontWeight(.bold)
                        .frame(width: 150)
                    TextField("Введите значение", text: $nameConnect)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack() {
                    Text ("Тип сервера")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 150)
                    Spacer()
                    Button(action: {
                        self.showingActionSheet = true
                    }) {
                        Text(typeServerSelect)
                    }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text("Тип сервера"), buttons: [
                            .default(Text("Disp"), action: {
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
                
                Spacer()
            } //VStack
                .onAppear {
                    self.DataPrepare()
            }
            .navigationBarTitle(Text("Подключение"))
            .padding()
        } //NavigationView
    } //body
    
    //Функция для заполнения ячеек TextField значениям из переданного класса data_item
    private func DataPrepare() {
        self.nameConnect = data_item.nameConnect
        self.typeServer = data_item.typeServer
        if self.typeServer == 0 {
            self.typeServerSelect = "Disp"
        }
        else if self.typeServer == 1 {
            self.typeServerSelect = "Cloud"
        }
        else if self.typeServer == 2 {
            self.typeServerSelect = "Domain"
        }
        self.organization = data_item.organization
        self.ip_Address = data_item.ip_Address
        self.UDP_Port = String(data_item.UDP_Port)
        self.TCP_Port = String(data_item.TCP_Port)
        self.userName = data_item.userName
        self.userPassword = data_item.userPassword
    }
} //DetailView

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        //DetailView(data_item: slist_Connect.array_Connect[0])
        DetailView(data_item: Connect.init())
    }
}
