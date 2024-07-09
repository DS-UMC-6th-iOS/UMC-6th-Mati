//
//  WeatherService.swift
//  WeatherProject
//
//  Created by 김미주 on 08/07/2024.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class WeatherService {
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "PropertyList", ofType: "plist") else  {
                fatalError()
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "APIKey") as? String else {
                fatalError()
            }
            
            return value
        }
    }
    
    func getWeather(completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=\(apiKey)")
        guard let url = url else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let weatherResponse = weatherResponse {
                print(weatherResponse)
                completion(.success(weatherResponse))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
