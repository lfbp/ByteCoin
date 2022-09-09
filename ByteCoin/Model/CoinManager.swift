//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerProtocol: AnyObject {
    func processCoinDTO(_ obj: CoinDTO?)
    func processError(_ error: Error)
}

struct CoinManager {
    
    static let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    static let apiKey = "CF92B6D1-E185-4EA9-8EA2-F5546040BA32"
    weak static var delegate: CoinManagerProtocol?
    static let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    static func fetchExchangeRate(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Error in url parsing")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url, completionHandler: {data, responde, error in
            if let error = error {
                print("error response")
                delegate?.processError(error)
            } else if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print("data string:")
                print(dataString!)
                let dataObject = parseJson(data)
                delegate?.processCoinDTO(dataObject)
                
            }
        })
        dataTask.resume()
    }
    
    static private func parseJson(_ data: Data) -> CoinDTO? {
        let decoder = JSONDecoder()
        do {
            let dataObject = try decoder.decode(CoinDTO.self, from: data)
            return dataObject
        } catch {
            return nil
        }
    }
}
