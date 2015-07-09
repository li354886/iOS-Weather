//
//  ViewController.swift
//  Weather-v3
//
//  Created by 李正宁 on 7/8/15.
//  Copyright (c) 2015 Zhengning Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentPrecipientlabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    private let forecastAPIKey = "4b13341079a390268fb41a7826c4137a"
    let coordinate: (lat: Double, long: Double) = (37.8267,-122.423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        retrieveWeatherForecast()
    }
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) { (let currently) in
            if let currentWeather = currently {
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let temperature = currentWeather.temperatrue {
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    if let humidity = currentWeather.temperatrue {
                        self.currentHumidityLabel?.text = "\(humidity)"
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipientlabel?.text = "\(precipitation)"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    if let summary = currentWeather.summary {
                        self.summaryLabel?.text = summary
                    }
                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshButton(sender: UIButton) {
        retrieveWeatherForecast()
    }

}

