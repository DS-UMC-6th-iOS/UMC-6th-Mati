//
//  Weather.swift
//  WeatherProject
//
//  Created by 김미주 on 08/07/2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
