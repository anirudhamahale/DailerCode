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

    // let phoneNumber = "+16489637892151"
    let phoneNumber = "+919637892151"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let countryCode = parseCountryCode(phoneNumber) {
            print(countryCode)
        }
    }
    
    func parseCountryCode(_ phoneNumber: String) -> String? {
        var countryCode = "+"
        let phoneDictionary = readJson()!
        if phoneNumber.characters.count < 5 {
            print("Invalid phone number, phone number should be atleast 5 characters.")
            return nil
        }
        if let firstNumberOfPhone = phoneNumber.getCharacterAt(1) {
            countryCode.append(firstNumberOfPhone)
            if let firstNumberOfJson = phoneDictionary[firstNumberOfPhone] as? [String: Any] {
                if firstNumberOfJson.keys.contains(phoneNumber.getCharacterAt(2)!) {
                    countryCode.append(phoneNumber.getCharacterAt(2)!)
                    let secondNumberOfJson = firstNumberOfJson[phoneNumber.getCharacterAt(2)!] as! [String: Any]
                    if secondNumberOfJson.keys.contains(phoneNumber.getCharacterAt(3)!) {
                        countryCode.append(phoneNumber.getCharacterAt(3)!)
                        let thirdNumberOfJson = secondNumberOfJson[phoneNumber.getCharacterAt(3)!] as! [String: Any]
                        if thirdNumberOfJson.keys.contains(phoneNumber.getCharacterAt(4)!) {
                            countryCode.append(phoneNumber.getCharacterAt(4)!)
                            let fourthNumberOfJson = thirdNumberOfJson[phoneNumber.getCharacterAt(4)!] as! [String: Any]
                            if fourthNumberOfJson.keys.contains(phoneNumber.getCharacterAt(5)!) {
                                countryCode.append(phoneNumber.getCharacterAt(5)!)
                                // let fifthNumberOfJson = fourthNumberOfJson[phoneNumber.getCharacterAt(5)!] as! [String: Any]
                            }
                        }
                    }
                }
            }
        }
        return countryCode
    }
    
    private func readJson() -> [String: Any]? {
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
