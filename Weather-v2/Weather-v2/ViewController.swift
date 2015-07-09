//
//  ViewController.swift
//  Weather-v2
//
//  Created by 李正宁 on 7/8/15.
//  Copyright (c) 2015 Zhengning Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBAction func getDataButton(sender: UIButton) {
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(cityNameTextField.text)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=Beijing,ch")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getWeatherData(urlString: String) {
        let url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                self.setLabels(data)
            }
        }
        task.resume()
    }
    
    func setLabels(weatherData: NSData) {
        var jsonError: NSError?
        let json = NSJSONSerialization.JSONObjectWithData(weatherData, options: nil, error: &jsonError) as! NSDictionary
        
        if let name = json["name"] as? String{
            cityNameLabel.text = name
            
        }
        
        if let main = json["main"] as? NSDictionary {
            if let temperature = main["temp"] as? Double {
                
                temperatureLabel.text = String(format: "%.1f", temperature)
            }
        }
    }
}

