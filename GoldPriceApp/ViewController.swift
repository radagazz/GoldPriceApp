//
//  ViewController.swift
//  GoldPriceApp
//
//  Created by anurak teerarattananukulchai on 25/1/2564 BE.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var buyPriceLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getGoldPrice()
    }

    @IBAction func getPricePressed(_ sender: UIButton) {
        getGoldPrice()
    }
    func getGoldPrice(){
        //get JSON file from the web
        Alamofire.request("http://www.thaigold.info/RealTimeDataV2/gtdata_.txt").responseJSON { response in
        
            //Checking internet connection
            if response.result.isSuccess == true {
                
        let goldPriceJSON : JSON = JSON(response.result.value!)
        self.updateGoldPrice(json: goldPriceJSON)
                
            }else{
                
            let alert = UIAlertController(title: "Error", message: "Can not get gold price. Please try again later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alert, animated: true, completion: nil)
                
            }

        }
    }
    
    func updateGoldPrice (json : JSON) {
        
        let goldPrice = json[4]["ask"].intValue
        
        self.sellPriceLabel.text = "\(goldPrice)"
        self.buyPriceLabel.text = "\(goldPrice - 100)"
    }

}

