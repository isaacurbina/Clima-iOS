//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
	
	// MARK: - Dependencies/attributes
	var weatherManager = WeatherManager()
	let locationManager = CLLocationManager()

	// MARK: - Outlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var searchTextField: UITextField!
	
	// MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
		weatherManager.delegate = self
		searchTextField.delegate = self
    }

	// MARK: - Actions
	@IBAction func searchPressed(_ sender: UIButton) {
		searchTextField.endEditing(true)
	}
	
	@IBAction func currentLocationPressed(_ sender: UIButton) {
		locationManager.requestLocation()
	}
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		searchTextField.endEditing(true)
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		searchTextField.endEditing(true)
		Task { await performSearch()}
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		if textField.text != "" {
			return true
		} else {
			textField.placeholder = "Type something..."
			return false
		}
	}
	
	// MARK: private functions
	private final func performSearch() async -> Void {
		if let cityName = searchTextField.text {
			weatherManager.fetchWeather(cityName: cityName)
		}
		searchTextField.text = ""
	}
}

// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
	
	func didUpdateWeather(_ weather: WeatherModel) {
		DispatchQueue.main.async {
			self.temperatureLabel.text = weather.temperatureString
			self.conditionImageView.image = UIImage(systemName: weather.conditionName)
			self.cityLabel.text = weather.cityName
		}
	}
	
	func didFailWithError(_ error: Error) {
		print("didFailWithError(\(error))")
	}
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			let lat = location.coordinate.latitude
			let long = location.coordinate.longitude
			weatherManager.fetchWeather(lat: lat, long: long)
		}
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
		print(error)
	}
}
