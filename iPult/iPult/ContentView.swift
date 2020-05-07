//
//  ContentView.swift
//  iPult
//
//  Created by Александр Менщиков on 08.04.2020.
//  Copyright © 2020 Alexander Menshikov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    init() {
        // Удалить дополнительные линии, ниже списка:
        UITableView.appearance().tableFooterView = UIView()
        
        // Удалить все разделительные линии:
        //UITableView.appearance().separatorStyle = .none
    }
    
    @EnvironmentObject var list_Connect: ListConnect
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    NavigationLink(destination: ConnectionView()){
                        Text("Демонстрационное подключение")
                    }
                    
                    NavigationLink(destination: ConnectionView()){
                        Text("Подключение")
                    }
                } //List
                
                List {
                    /*ForEach(0 ..< list_Connect.arrayTest.count) {
                        Text(self.list_Connect.arrayTest[$0])
                    }*/
                    
                    ForEach (list_Connect.array_Connect) { item_array in
                        NavigationLink(destination: DetailView(data_item: item_array)) {
                            Text(item_array.nameConnect)
                        }
                    }
                    
                    /*ForEach(list_Connect.Get_Array()) { item_array in
                        NavigationLink(destination: DetailView(data_item: item_array)) {
                            Text(item_array.nameConnect)
                        }
                    }*/
                    .onDelete(perform: Delete_item)
                }
                
                /*Button(action: {
                 //let List_Connect = ListConnect()
                 self.List_Connect.XML_Load()
                 }) {
                 Text("Обновить")
                 }*/ //Button
            } //Form
                
                // displayMode - Выбор отображения надписи в шапке
                .navigationBarTitle(Text("Список подключений"), displayMode: .large)
        } //NavigationView
        
    } //body
    
    func Delete_item(at offsets: IndexSet) {
        list_Connect.array_Connect.remove(atOffsets: offsets)
        list_Connect.XML_Save()
        list_Connect.XML_Load()
    }
    
} //ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
