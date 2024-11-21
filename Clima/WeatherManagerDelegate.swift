//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Isaac Urbina on 11/21/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
	func didUpdateWeather(_ weather: WeatherModel)
}
