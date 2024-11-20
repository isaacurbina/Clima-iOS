//
//  WeatherManager.swift
//  Clima
//
//  Created by Isaac Urbina on 11/19/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
	let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=2d8404c5e5ee831f0b7a2aceda7e02f7&units=metric"
	
	func fetchWeather(cityName: String) async -> String {
		let urlString = "\(weatherURL)&q=\(cityName)"
		return urlString
	}
}
