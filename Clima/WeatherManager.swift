//
//  WeatherManager.swift
//  Clima
//
//  Created by Isaac Urbina on 11/19/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
	
	var delegate: WeatherManagerDelegate? 
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
					self.delegate?.didFailWithError(error!)
					return
				}
				
				if let safeData = data {
					if let weather = parseJson(weatherData: safeData) {
						self.delegate?.didUpdateWeather(weather)
					}
				}
			}
			//4. Start the task
			task.resume()
		}
	}
	
	private func parseJson(weatherData: Data) -> WeatherModel? {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
			if let weather = decodedData.weather?[0] {
				let conditionId = weather.id ?? 0
				let temp = decodedData.main?.temp ?? 0.0
				let cityName = decodedData.name ?? "No city name available"
				
				let weatherModel = WeatherModel(conditionId: conditionId, cityName: cityName, temperature: temp)
				return weatherModel
				
			} else {
				print("No weather ID available")
				return nil
			}
		} catch {
			self.delegate?.didFailWithError(error)
			return nil
		}
	}
	
}
