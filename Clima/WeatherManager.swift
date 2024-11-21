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
	
	func fetchWeather(cityName: String) {
		let urlString = "\(weatherURL)&q=\(cityName)"
		performRequest(url: urlString)
	}
	
	private func performRequest(url: String) {
		//1. Create a url
		if let url = URL(string: url) {
			//2. Create a URLSession
			let session = URLSession(configuration: .default)
			//3. Give the session a task
			let task = session.dataTask(with: url) { data, response, error in
				if error != nil {
					print(error!)
					return
				}
				
				if let safeData = data {
					parseJson(weatherData: safeData)
				}
			}
			//4. Start the task
			task.resume()
		}
	}
	
	private func parseJson(weatherData: Data) {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
			print(decodedData.weather?[0]?.description!)
		} catch {
			print(error)
		}
	}
}
