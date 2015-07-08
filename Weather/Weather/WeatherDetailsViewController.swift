//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by 李正宁 on 7/7/15.
//  Copyright (c) 2015 Zhengning Li. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureSummary: UILabel!
    
    var weather = Weather()
    var session: NSURLSession!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extractingForecastWeatherInfo()
    }
    
    func extractingForecastWeatherInfo()
    {
            let urlString = "http://api.openweathermap.org/data/2.5/weather?q=Washingto,us"
            let forecastURL = NSURL(string: urlString)!
            
            let urlRequest = NSURLRequest(URL: forecastURL)
        
            session = NSURLSession.sharedSession()
            let task = self.session.dataTaskWithRequest(urlRequest) { data, response, downloadError in
                
                if let error = downloadError {
                    println("Could not complete the request \(error)")
                } else {
                    
                    var parsingError: NSError? = nil
                    let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
                    
                    if let error = parsingError {
                        println(error)
                    } else {
                        if let results = parsedResult["main"] as? [String: AnyObject] {
                            self.weather.temperature! = results["temp"] as! Int
                        }
                        if let results_2 = parsedResult["weather"] as? [[String: AnyObject]] {
                            self.weather.summary! = results_2[0]["main"] as! String
                        }
                    }
                }
                dispatch_async(dispatch_get_main_queue())
                {
                    self.temperatureLabel.text = String(format: "%i F", self.weather.temperature!)
                    self.temperatureSummary.text = self.weather.summary
                    println(self.weather.summary)
                }
            }
            task.resume()
        
    }
}
