//
//  ViewController.swift
//  WeatherProject
//
//  Created by 김미주 on 08/07/2024.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var weather: Weather?
    var main: Main?
    var name: String?
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconImageVIew: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var city: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherService().getWeather(for: city) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                    self.setWeatherUI()
                }
            case .failure(_ ):
                print("error")
            }
        }
    }
    
    private func setWeatherUI() {
        let url = URL(string: "https://openweathermap.org/img/wn/\(self.weather?.icon ?? "00")@2x.png")
        let data = try? Data(contentsOf: url!)
        if let data = data {
            iconImageVIew.image = UIImage(data: data)
        }
        
        cityLabel.text = city
        tempLabel.text = "\(main!.temp)°C"
        minTempLabel.text = "최저: \(main!.temp_min)°C"
        maxTempLabel.text = "최고: \(main!.temp_max)°C"
    }
}

