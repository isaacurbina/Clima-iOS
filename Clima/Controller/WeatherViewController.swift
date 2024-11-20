//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

	// MARK: - Outlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var searchTextField: UITextField!
	
	// MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
		searchTextField.delegate = self
    }

	// MARK: - Actions
	@IBAction func searchPressed(_ sender: UIButton) {
		performSearch()
	}
	
	// MARK: UITextFieldDelegate
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		performSearch()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		// TODO(use searchTextField.text to get the weather for that city.)
		searchTextField.text = ""
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
	private final func performSearch() {
		searchTextField.endEditing(true)
		print(searchTextField.text!)
	}
}



