//
//  XML_work.swift
//  iPult
//
//  Created by Александр Менщиков on 16.04.2020.
//  Copyright © 2020 Alexander Menshikov. All rights reserved.
//

import Foundation

class ListConnect: ObservableObject {
    @Published var array_Connect: [Connect] = [Connect]()

    init() {
        XML_Load()
    }

    func XML_Load() {
        let nameXML_File_tmp: String = "~/Documents/Config.XML"
        let nameXML_File = ((nameXML_File_tmp as NSString).expandingTildeInPath)
        
        array_Connect.removeAll(keepingCapacity: false);
        
        let Data: Foundation.Data? = try? Foundation.Data(contentsOf: URL(fileURLWithPath: nameXML_File))
        
        print ("=====")
        print (URL(fileURLWithPath: nameXML_File))
        
        if(Data != nil) {
            //print ("Data no nil")
            
            let delegate: ParserDelegate = ParserDelegate()
            delegate.m_ListConnect = self;
            
            let parser: XMLParser = XMLParser(data: Data!)
            
            parser.delegate = delegate
            
            parser.parse()
            
            print("- - - - - -")
            for i in array_Connect {
                print ("\(i.nameConnect) - typeServer: \(i.typeServer)")
            }
            print("- - - - - -")
        }
    } //XML_Load
    
    //Запись данных в xml файл
    func XML_Save() {
        let nameXML_File: String = "~/Documents/Config.XML"
        var body: String = "<?xml version=\"1.0\"?>"
        
        body += String(format: "<%@ >", xml_CFG)
        
        for i in array_Connect {
            body += String(format: "<%@ ", xml_CONNECT)
            
            body += String(format: "%@=\"%@\" ", xml_NameConnect, i.nameConnect)
            body += String(format: "%@=\"%@\" ", xml_TypeServer, String(i.typeServer))
            body += String(format: "%@=\"%@\" ", xml_Organization, i.organization)
            body += String(format: "%@=\"%@\" ", xml_IP_Address, i.ip_Address)
            body += String(format: "%@=\"%d\" ", xml_UDP_Port, i.UDP_Port)
            body += String(format: "%@=\"%d\" ", xml_TCP_Port, i.TCP_Port)
            body += String(format: "%@=\"%@\" ", xml_UserName, i.userName)
            body += String(format: "%@=\"%@\" ", xml_UserPassword, i.userPassword)
            body += String(format: "%@=\"%@\" ", xml_SystemKey, i.systemKey)
            body += String(format: "%@=\"%@\" ", xml_SubNet, String(i.subNet))
            body += String(format: "%@=\"%@\" ", xml_UM, String(i.UM))
            body += String(format: "%@=\"%@\" ", xml_Slot, String(i.slot))
            body += String(format: "%@=\"%@\" ", xml_Address, String(i.address))
            body += String(format: "%@=\"%@\" ", xml_Last, String(i.last))
            body += String(format: "%@=\"%@\" ", xml_AlertAsk, String(i.alertAsk))
            
            body += "/>"
        }
        
        body += String(format: "</%@>", xml_CFG)
        
        do {
            try body.write(toFile: (nameXML_File as NSString).expandingTildeInPath, atomically: false, encoding: String.Encoding.unicode)
            print ("Запись в файл завершена: " + (nameXML_File as NSString).expandingTildeInPath)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        
    } //XML_Save
    
    // Запустить чтение из файла xml и вернуть массив с полученными данными
    func Get_Array() -> [Connect]{
        XML_Load()
        return array_Connect
    } //Get_Array
    
} //ListConnect

class Connect {
    let id = UUID()
    
    enum TypeServerSelect {
        static let tsDisp = 0
        static let tsCloud = 1
        static let tsDomain = 2
    }
    
    func TypeServer(typeServerReturn: Int) -> String {
        switch (typeServerReturn) {
            case TypeServerSelect.tsDisp: return "Disp"
            case TypeServerSelect.tsCloud: return "Cloud"
            case TypeServerSelect.tsDomain: return "Domain"
            default: return ""
        }
    }
    
    var nameConnect: String = ""
    var typeServer: Int = TypeServerSelect.tsDisp
    var organization: String = ""
    var ip_Address: String = ""
    var UDP_Port: Int = 0
    var TCP_Port: Int = 0
    var userName: String = ""
    var userPassword: String = ""
    
    var systemKey: String = ""
    var subNet: Int = 2
    var UM: Int = 0
    var slot: Int = 0
    var address: Int = 0
    var last: Int = 0
    var alertAsk: Int = 0
    var addressIP: in_addr_t = 0
} //Connect

extension Connect: Identifiable { }

class ParserDelegate: NSObject, XMLParserDelegate
{
    var m_Lvl: Int = 0
    var m_isExistCFG: Bool = false
    var m_ListConnect: ListConnect?
    
    func parserDidStartDocument(_ parser: XMLParser)
    {
        m_Lvl = 0;
        m_isExistCFG = false;
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName: String?, attributes attributeDict: [String : String]) {
        let attrs = attributeDict
        
        m_Lvl += 1;
    
        switch(m_Lvl)
        {
        case 1:
            if elementName == xml_CFG
            {
                m_isExistCFG = true;
            }
        case 2:
            if elementName == xml_CONNECT && m_isExistCFG
            {
                let pConnect: Connect = Connect()
                var value: String?
                
                value = attrs[xml_NameConnect]
                if value != nil
                {
                    pConnect.nameConnect = value!
                }
                
                value = attrs[xml_TypeServer]
                if value != nil
                {
                    pConnect.typeServer = Int(value!)!
                }
                
                value = attrs[xml_Organization]
                if value != nil
                {
                    pConnect.organization = value!
                }
                
                value = attrs[xml_IP_Address]
                if value != nil
                {
                    pConnect.ip_Address = value!
                }
                
                value = attrs[xml_UDP_Port]
                if value != nil
                {
                    pConnect.UDP_Port = Int(value!)!
                }
                
                value = attrs[xml_TCP_Port]
                if value != nil
                {
                    pConnect.TCP_Port = Int(value!)!
                }
                
                value = attrs[xml_UserName]
                if value != nil
                {
                    pConnect.userName = value!
                }
                
                value = attrs[xml_SystemKey]
                if value != nil
                {
                    pConnect.systemKey = value!
                }
                value = attrs[xml_SubNet]
                if value != nil
                {
                    pConnect.subNet = Int(value!)!
                }
                value = attrs[xml_UM]
                if value != nil
                {
                    pConnect.UM = Int(value!)!
                }
                value = attrs[xml_Slot]
                if value != nil
                {
                    pConnect.slot = Int(value!)!
                }
                value = attrs[xml_Address]
                if value != nil
                {
                    pConnect.address = Int(value!)!
                }
                value = attrs[xml_Last]
                if value != nil
                {
                    pConnect.last = Int(value!)!
                }
                value = attrs[xml_AlertAsk]
                if value != nil
                {
                    pConnect.alertAsk = Int(value!)!
                }
                m_ListConnect?.array_Connect.append(pConnect)
            }
        default:
            break
        } //switch(m_Lvl)
    } //func parser
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        m_Lvl -= 1;
    }
} //ParserDelegate

let xml_CFG: String = "CFG"
let xml_CONNECT: String = "CONNECT"
var xml_NameConnect: String = "NameConnect"
var xml_TypeServer: String = "TypeServer"
let xml_Organization: String = "Organization"
let xml_IP_Address: String = "IP_Address"
let xml_UDP_Port: String = "UDP_Port"
let xml_TCP_Port: String = "TCP_Port"
let xml_UserName: String = "UserName"
let xml_UserPassword: String = "UserPassword"

let xml_SystemKey: String = "SystemKey"
let xml_SubNet: String = "SubNet"
let xml_UM: String = "UM"
let xml_Slot: String = "Slot"
let xml_Address: String = "Address"
let xml_Last: String = "Last"
let xml_AlertAsk: String = "AlertAsk"
