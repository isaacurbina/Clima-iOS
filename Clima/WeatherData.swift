//
//  WeatherData.swift
//  Clima
//
//  Created by Isaac Urbina on 11/20/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable{
	let name: String?
	let main: Main?
	let weather: [Weather?]?
}

struct Main: Decodable {
	let temp: Double?
}

struct Weather: Decodable {
	let main: String?
	let description: String?
	let icon: String?
}
