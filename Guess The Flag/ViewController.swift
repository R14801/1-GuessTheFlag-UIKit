//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Rajat Nagvenker on 3/18/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries : [String] = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var countryCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadFlags()
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
    }
    
    func loadFlags() {
        clearFlags()
        var randomCountry = countries.randomElement()
        let buttons = [button1, button2, button3]
        
        button1.setImage(UIImage(named: randomCountry ?? ""), for: .normal)
        button1.setTitle("", for: .normal)
        print("1. Part I - \(randomCountry!)")
        repeat {
            randomCountry = countries.randomElement()
        } while( UIImage(named: randomCountry ?? "") == button1.currentImage)
        
        button2.setImage(UIImage(named: randomCountry ?? ""), for: .normal)
        button2.setTitle("", for: .normal)
        print("2. Part I - \(randomCountry!)")
        repeat {
            randomCountry = countries.randomElement()
        } while( UIImage(named: randomCountry ?? "") == button1.currentImage && UIImage(named: randomCountry ?? "") == button2.currentImage)
        
        print("3. Part I - \(randomCountry!)")
        button3.setImage(UIImage(named: randomCountry ?? ""), for: .normal)
        button3.setTitle("", for: .normal)
        
//        var random = countries.randomElement()!
//        print("Part I - \(random)")
//        let selButton = buttons.randomElement()
//        print("Part I - \(selButton)")
//        navTitle.title = random.capitalized
//        if(button1.currentImage != UIImage(named: random) && button2.currentImage != UIImage(named: random) && button3.currentImage != UIImage(named: random)) {
//            selButton!?.setImage(UIImage(named: random), for: .normal)
//        } else {
//
//        }
        while countryCount < countries.count {
            print("Part II - \(countries[countryCount])")
            navTitle.title = countries[countryCount]
            if (UIImage(named: countries[countryCount]) == button1.currentImage || UIImage(named: countries[countryCount]) == button2.currentImage || UIImage(named: countries[countryCount]) == button3.currentImage) {
                print("Part II - \(countries[countryCount]) Exists")
                break
            } else {
                var selButton = buttons.randomElement()
                selButton!?.setImage(UIImage(named: countries[countryCount]), for: .normal)
                break
            }
        }
        
        if countryCount < countries.count {
            countryCount += 1
        } else {
            countryCount = 0
        }
    }
    
    func clearFlags() {
        let buttons = [button1, button2, button3]
        for item in buttons {
            item?.setImage(nil, for: .normal)
            item?.setTitle("", for: .normal)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
//        print(sender.currentImage)
        let country = navTitle.title!.lowercased()
//        print(country)
        if sender.currentImage == UIImage(named: country ?? "estonia") {
            displayAlert(result: true)
        } else {
            displayAlert(result: false)
        }
    }
    
    func displayAlert(result: Bool) {
        let nextButton = UIAlertAction(title: "Next", style: .default, handler: { (action) -> Void in
            self.loadFlags()
        })
        let retryButton = UIAlertAction(title: "Retry", style: .cancel) { (action) -> Void in
        }
        var dialogMessage = UIAlertController()
        
        if result {
            dialogMessage = UIAlertController(title: "Correct", message: "Well Done, Move on to the next question.", preferredStyle: .alert)
            dialogMessage.addAction(nextButton)
        } else {
            dialogMessage = UIAlertController(title: "Incorrect", message: "Please Retry or move on to the next question", preferredStyle: .alert)
            dialogMessage.addAction(nextButton)
            dialogMessage.addAction(retryButton)
        }
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
}

