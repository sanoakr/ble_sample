//
//  ViewController.swift
//  ble_sample
//
//  Created by sano on 20180411.
//  Copyright © 2018年 slab. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralManagerDelegate {
    var centralManager: CBCentralManager!
    var peripheralManager: CBPeripheralManager!
    
    @IBOutlet weak var logView: UITextView!
    @IBOutlet weak var centralSW: UISwitch!
    @IBOutlet weak var textPeripheral: UILabel!
    @IBOutlet weak var textCentral: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logView.text = "Start BLE_Sample.app\n"
        // セントラルマネージャ、ペリフェラルマネージャの初期化
        centralManager = CBCentralManager(delegate: self, queue: nil)
        //peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)

        Thread.sleep(forTimeInterval: 10.0)
        // セントラルのスキャン開始
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        logView.insertText("Start Central Scan\n")
    }

    @IBAction func toggleCentral(_ sender: Any) {
        if centralSW.isOn {
            // ペリフェラルのアドバタイズ停止
            //peripheralManager.stopAdvertising()
            //logView.insertText("Stop Peripheral Advertising\n")
            // セントラルの再初期化
            //centralManager = CBCentralManager(delegate: self, queue: nil)
            // セントラルのスキャン開始
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            logView.insertText("Start Central Scan\n")

        } else {
            // セントラルのスキャン停止
            centralManager.stopScan()
            logView.insertText("Stop Central Scan\n")
            // ペリフェラルの再初期化
            //peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
            // ペリフェラルのアドバタイズ開始
            //let advertisementData = [CBAdvertisementDataLocalNameKey: "BLE Sample"]
            //peripheralManager.startAdvertising(advertisementData)
            //logView.insertText("Start Peripheral Advertising\n")
        }
    }
    // セントラルマネージャの状態変化を取得
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        logView.insertText("central state: \(central.state)\n")
    }
    // セントラルマネージャのスキャン結果を取得
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        logView.insertText("advertisementData: \(advertisementData)\n")
        //logView.insertText("peripheral: \(peripheral)\n")
    }
    // ペリフェラルマネージャの状態変化を取得
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        logView.insertText("peripheral state: \(peripheral.state)\n")
    }
    // ペリフェラルのアドバタイズ開始処理結果を取得
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            logView.insertText("Advertising Failed: \(error)\n")
            return
        }
        logView.insertText("Advertising Succeeded\n")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

