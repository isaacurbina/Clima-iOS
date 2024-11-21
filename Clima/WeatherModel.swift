//
//  WeatherModel.swift
//  Clima
//
//  Created by Isaac Urbina on 11/20/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
	let conditionId: Int
	let cityName: String
	let temperature: Double
	var conditionName: String {
		getConditionName(weatherId: conditionId)
	}
	var temperatureString: String {
		let temperatureOneDecimal = String(format: "%.1f", temperature)
		return "\(temperatureOneDecimal)°C"
	}
	
	private func getConditionName(weatherId: Int) -> String{
		return switch weatherId {
		case 200...232:
			"cloud.bolt"
		case 300...321:
			"cloud.drizzle"
		case 500...531:
			"cloud.rain"
		case 600...622:
			"cloud.snow"
		case 701...781:
			"cloud.fog"
		case 800:
			"sun.max"
		case 801...804:
			"cloud.sun.rain"
		default:
			"cloud"
		}
	}
}
