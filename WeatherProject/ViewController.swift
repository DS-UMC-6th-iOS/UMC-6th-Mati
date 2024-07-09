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
    @IBOutlet weak var iconImageVIew: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let city = "Paris"
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
        
        tempLabel.text = "\(main!.temp)"
        minTempLabel.text = "\(main!.temp_min)"
        maxTempLabel.text = "\(main!.temp_max)"
    }
}

