//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
	
	var weatherManager = WeatherManager()

	// MARK: - Outlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var searchTextField: UITextField!
	
	// MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
		weatherManager.delegate = self
		searchTextField.delegate = self
    }

	// MARK: - Actions
	@IBAction func searchPressed(_ sender: UIButton) {
		searchTextField.endEditing(true)
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
		}
	}
	
	func didFailWithError(_ error: Error) {
		print("didFailWithError(\(error))")
	}
}
