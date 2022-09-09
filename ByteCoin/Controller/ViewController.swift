//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var selectedCoin: String = CoinManager.currencyArray[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        CoinManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CoinManager.fetchExchangeRate(for: selectedCoin)
    }

}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CoinManager.currencyArray.count
    }
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CoinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("currency selected:\(CoinManager.currencyArray[row])")
        selectedCoin = CoinManager.currencyArray[row]
        CoinManager.fetchExchangeRate(for: selectedCoin)
        
    }
}


extension ViewController: CoinManagerProtocol {
    func processCoinDTO(_ obj: CoinDTO?) {
        if let obj = obj {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                let roundedValue = Double(round(obj.rate*100)/100)
                self.currencyLabel.text = "\(self.selectedCoin)"
                self.bitCoinLabel.text = "\(roundedValue)"
            }
        }
    }
    
    func processError(_ error: Error) {
        
    }

}
