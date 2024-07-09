//
//  ListViewController.swift
//  WeatherProject
//
//  Created by 김미주 on 09/07/2024.
//

import UIKit

class ListViewController: UIViewController {
    // MARK: - Properties
    var weather: Weather?
    var main: Main?
    var name: String?
    @IBOutlet weak var tabelView: UITableView!
    
    let weatherService = WeatherService()
    let data = ["Seoul", "London", "Paris", "Madrid", "Tokyo"]
    var weatherData: [String: (weather: Weather?, main: Main?)] = [:]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        // 각 도시의 날씨 데이터를 가져와서 저장
        for city in data {
            weatherService.getWeather(for: city) { result in
                switch result {
                case .success(let weatherResponse):
                    DispatchQueue.main.async {
                        self.weatherData[city] = (weatherResponse.weather.first, weatherResponse.main)
                        self.tabelView.reloadData()
                    }
                case .failure(_ ):
                    print("error")
                }
            }
        }
        
        let listNib = UINib(nibName: "ListTableViewCell", bundle: nil)
        tabelView.register(listNib, forCellReuseIdentifier: "ListTableViewCell")
        
        tabelView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let city = data[indexPath.row]
        cell.locationLabel.text = city
        
        if let weatherData = self.weatherData[city], let main = weatherData.main {
            cell.tempLabel.text = "\(main.temp)°C"
            cell.minTempLabel.text = "최저: \(main.temp_min)°C"
            cell.maxTempLabel.text = "최고: \(main.temp_max)°C"
        } else {
            cell.tempLabel.text = "N/A"
            cell.minTempLabel.text = "N/A"
            cell.maxTempLabel.text = "N/A"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        detailVC.city = data[indexPath.row]
        detailVC.modalTransitionStyle = .coverVertical
        self.present(detailVC, animated: true, completion: nil)
    }

}
