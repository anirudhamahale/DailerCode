//
//  ViewController.swift
//  DailerTree
//
//  Created by Anirudha on 05/09/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import UIKit

extension String {
    func getCharacterAt(_ index: Int) -> String? {
        if self.characters.count > index {
            let characterIndex = self.characters.index(self.startIndex, offsetBy: index)
            let character = self[characterIndex]
            return "\(character)"
        }
        return nil
    }
}

class ViewController: UIViewController {

    let phoneNumber = "+1 6489637892151"
    // let phoneNumber = "+919637892151"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let countryCode = parse(phoneNumber) {
            print(countryCode)
        }
    }
    
    func parse(_ number: String) -> String? {
        var countryCode = "+"
        if let json = readJson() {
            if let first = parseFirstNumber(number, json: json) {
                countryCode.append(first["code"] as! String)
                let json = first["json"] as! [String: Any]
                print(json)
            }
            return countryCode
        }
        return nil
    }
    
    private func parseFirstNumber(_ number: String, json: [String: Any]) -> [String: Any]? {
        // Get the Number at Index 1
        // Read the json
        // check if the second number is there
        // If found return 
        // If not found just check if the done is there.
        if let first = number.getCharacterAt(1) {
            if let json_first = json[first] as? [String: Any] {
                if let second = number.getCharacterAt(2) {
                    if let temp = json_first[second] as? [String: Any] {
                        return ["code": first, "json": temp]
                    } else {
                        if json_first["done"] as? Bool == true {
                            print(true)
                        } else {
                            print(false)
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    func readJson() -> [String: Any]? {
        if let fileUrl = Bundle.main.url(forResource: "DailerCodeTree", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! [String: Any]
                let plusDictionary = dictionary["+"] as! [String: Any]
                return plusDictionary
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        print("File not found!")
        return nil
    }
}
