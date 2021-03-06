//
//  UserconfigViewController.swift
//  snkcooker
//
//  Created by luiyezheng on 2017/12/19.
//  Copyright © 2017年 luiyezheng. All rights reserved.
//

import Cocoa

class UserconfigViewController: NSViewController {
    @IBOutlet var shipFirstName: NSTextField!
    @IBOutlet var shipLastName: NSTextField!
    @IBOutlet var shipAddress1: NSTextField!
    @IBOutlet var shipAddress2: NSTextField!
    @IBOutlet var shipCity: NSTextField!
    @IBOutlet var shipCountry: NSTextField!
    @IBOutlet var shipProvince: NSTextField!
    @IBOutlet var shipZip: NSTextField!
    @IBOutlet var shipPhone: NSTextField!
    
    @IBOutlet var billFirstName: NSTextField!
    @IBOutlet var billLastName: NSTextField!
    @IBOutlet var billAddress1: NSTextField!
    @IBOutlet var billAddress2: NSTextField!
    @IBOutlet var billCity: NSTextField!
    @IBOutlet var billCountry: NSTextField!
    @IBOutlet var billProvince: NSTextField!
    @IBOutlet var billZip: NSTextField!
    @IBOutlet var billPhone: NSTextField!
    
    @IBOutlet var cardNumber: NSTextField!
    @IBOutlet var nameOnCard: NSTextField!
    @IBOutlet var expireData: NSTextField!
    @IBOutlet var cvv: NSTextField!
    
    @IBOutlet var emailTableView: NSTableView!
    
    var emailData:emails?
    
    override func viewDidLoad() {
        PlistDicManager.checkExist()
        self.loadUserConfig()
        
        self.emailTableView.delegate = self
        self.emailTableView.dataSource = self
        self.emailData = EmailsData().values
        self.emailTableView.reloadData()
        
        super.viewDidLoad()

        // Do view setup here.
    }
    
    @IBAction func addressEndediting(_ sender: NSTextField) {
        let row = emailTableView.row(for: sender)
        
        if var data = self.emailData {
            data[row]["address"] = sender.stringValue
            self.emailData = data
            }
    }
    
    @IBAction func abbrEndediting(_ sender: NSTextField) {
        let row = emailTableView.row(for: sender)
        
        if var data = self.emailData {
            data[row]["abbr"] = sender.stringValue
            self.emailData = data
        }
    }
    
    @IBAction func emailAddandRemove(_ sender: NSSegmentedCell) {
        let tag = sender.selectedSegment
        if tag == 0 {
            self.emailData?.append(["abbr":"","address":""])
            self.emailTableView.reloadData()
            
        }else {
            let selectedRow = self.emailTableView.selectedRow
            self.emailData?.remove(at: selectedRow)
            self.emailTableView.reloadData()
        }
    }
    
    @IBAction func updateUserConfig(_ sender: NSButton) {
        self.updateCreditInfo()
        self.updateBillAddress()
        self.updateShipAddress()
        self.updateEmails()
    }
    
    private func loadUserConfig() {
        let shipAddressDic = PlistDicManager.readPlistObject(withkey: "ShippingAddress") as! [String:String]
        let billAddressDic = PlistDicManager.readPlistObject(withkey: "BillingAddress") as! [String:String]
        let creditInfoDic = PlistDicManager.readPlistObject(withkey: "PaymentCardInfo") as! [String:String]
        
        if let firstName = shipAddressDic["firstName"] {shipFirstName.stringValue = firstName} else {shipFirstName.stringValue = ""}
        if let lastName = shipAddressDic["lastName"] {shipLastName.stringValue = lastName} else {shipLastName.stringValue = ""}
        if let address1 = shipAddressDic["address1"] {shipAddress1.stringValue = address1} else {shipAddress1.stringValue = ""}
        if let address2 = shipAddressDic["address2"] {shipAddress2.stringValue = address2} else {shipAddress2.stringValue = ""}
        if let city = shipAddressDic["city"] {shipCity.stringValue = city} else {shipCity.stringValue = ""}
        if let country = shipAddressDic["country"] {shipCountry.stringValue = country} else {shipCountry.stringValue = ""}
        if let province = shipAddressDic["province"] {shipProvince.stringValue = province} else {shipProvince.stringValue = ""}
        if let zip = shipAddressDic["zip"] {shipZip.stringValue = zip} else {shipZip.stringValue = ""}
        if let phone = shipAddressDic["phone"] {shipPhone.stringValue = phone} else {shipPhone.stringValue = ""}
        
        if let firstName = billAddressDic["firstName"] {billFirstName.stringValue = firstName} else {billFirstName.stringValue = ""}
        if let lastName = billAddressDic["lastName"] {billLastName.stringValue = lastName} else {billLastName.stringValue = ""}
        if let address1 = billAddressDic["address1"] {billAddress1.stringValue = address1} else {billAddress1.stringValue = ""}
        if let address2 = billAddressDic["address2"] {billAddress2.stringValue = address2} else {billAddress2.stringValue = ""}
        if let city = billAddressDic["city"] {billCity.stringValue = city} else {billCity.stringValue = ""}
        if let country = billAddressDic["country"] {billCountry.stringValue = country} else {billCountry.stringValue = ""}
        if let province = billAddressDic["province"] {billProvince.stringValue = province} else {billProvince.stringValue = ""}
        if let zip = billAddressDic["zip"] {billZip.stringValue = zip} else {billZip.stringValue = ""}
        if let phone = billAddressDic["phone"] {billPhone.stringValue = phone} else {billPhone.stringValue = ""}
        
        if let cardNum = creditInfoDic["cardNumber"] {cardNumber.stringValue = cardNum} else {cardNumber.stringValue = ""}
        if let name = creditInfoDic["nameOnCard"] {nameOnCard.stringValue = name} else {nameOnCard.stringValue = ""}
        if let date = creditInfoDic["expireData"] {expireData.stringValue = date} else {expireData.stringValue = ""}
        if let cvvNum = creditInfoDic["cvv"] {cvv.stringValue = cvvNum} else {cvv.stringValue = ""}
    }
    
    
    private func updateShipAddress() {
        PlistDicManager.updatePlistObject(forKey:"ShippingAddress") {object in
            let dict = NSMutableDictionary()
            dict.setValue(shipFirstName.stringValue, forKey: "firstName")
            dict.setValue(shipLastName.stringValue, forKey: "lastName")
            dict.setValue(shipAddress1.stringValue, forKey: "address1")
            dict.setValue(shipAddress2.stringValue, forKey: "address2")
            dict.setValue(shipCity.stringValue, forKey: "city")
            dict.setValue(shipCountry.stringValue, forKey: "country")
            dict.setValue(shipProvince.stringValue, forKey: "province")
            dict.setValue(shipZip.stringValue, forKey: "zip")
            dict.setValue(shipPhone.stringValue, forKey: "phone")
            
            return dict
        }
    }
    
    private func updateBillAddress() {
        PlistDicManager.updatePlistObject(forKey:"BillingAddress") {object in
            let dict = NSMutableDictionary()
            dict.setValue(billFirstName.stringValue, forKey: "firstName")
            dict.setValue(billLastName.stringValue, forKey: "lastName")
            dict.setValue(billAddress1.stringValue, forKey: "address1")
            dict.setValue(billAddress2.stringValue, forKey: "address2")
            dict.setValue(billCity.stringValue, forKey: "city")
            dict.setValue(billCountry.stringValue, forKey: "country")
            dict.setValue(billProvince.stringValue, forKey: "province")
            dict.setValue(billZip.stringValue, forKey: "zip")
            dict.setValue(billPhone.stringValue, forKey: "phone")
            
            return dict
        }
    }
    
    
    private func updateCreditInfo() {
        PlistDicManager.updatePlistObject(forKey: "PaymentCardInfo") {object in
            let dict = NSMutableDictionary()
            
            dict.setValue(cardNumber.stringValue, forKey: "cardNumber")
            dict.setValue(nameOnCard.stringValue, forKey: "nameOnCard")
            dict.setValue(expireData.stringValue, forKey: "expireData")
            dict.setValue(cvv.stringValue, forKey: "cvv")
            
            return dict
        }
    }
    
    private func updateEmails() {
        let newData = self.emailData?.filter({$0["abbr"] != "" && $0["address"] != ""})
        PlistDicManager.updatePlistObject(forKey: "Emails") {object in
            return newData
        }
    }
}


extension UserconfigViewController:NSTableViewDelegate, NSTableViewDataSource {
    private enum CellIdentifiers {
        static let abbrCell = "abbrCellID"
        static let addressCell = "addressCellID"
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if let data = self.emailData {
            return data.count
        }else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text:String = ""
        var cellIdentity:String = ""
        guard let item = emailData?[row] else {
            return nil
        }
        
        if tableColumn == tableView.tableColumns[0] {
            if let newText = item["abbr"] {
                text = newText
                cellIdentity = CellIdentifiers.abbrCell
            }
        }else {
            if let newText = item["address"] {
                text = newText
                cellIdentity = CellIdentifiers.addressCell
            }
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentity), owner: nil) as? NSTableCellView {
            
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}

