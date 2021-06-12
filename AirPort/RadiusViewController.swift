//
//  RadiusViewController.swift
//  AirPort
//
//  Created by Juan Antonio Martin on 08/06/21.
//

import Foundation
import UIKit
import CoreLocation


class RadiusViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var numberLabel : UILabel!
    @IBOutlet weak var searchButton : UIButton!
    var km : Int!
    
    var location: CLLocationManager!
    var DataItem1: DataItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel.text = "\(Int(radiusSlider.value))"
        searchButton.backgroundColor = UIColor(red: 66/255, green: 174/255, blue: 217/255, alpha: 1)
        searchButton.layer.cornerRadius = 8
        searchButton.setTitleColor(.white, for: .normal)
        
        location = CLLocationManager()
        self.location.requestAlwaysAuthorization()
        self.location.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            
            location.delegate = self
            location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            location.startUpdatingLocation()
        }
    }
    
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        var currentValue = Int(radiusSlider.value)
        self.km = Int(radiusSlider.value)
        numberLabel.text = "\(currentValue)"
        
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        self.searchAirport()
    }
    
    func searchAirport()  {

        let headers = [
            "x-rapidapi-key": "675cdd74c6mshd9c7ea26c9b2e72p182a14jsn15a90722c86d",
            "x-rapidapi-host": "aerodatabox.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://aerodatabox.p.rapidapi.com/airports/search/location/40.7600000/-73.9840000/km/" + "\(String(self.km))" + "/16?withFlightInfoOnly=false")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        DispatchQueue.global(qos: .utility).async {
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                self.DataItem1 = try JSONDecoder().decode(DataItem.self, from: data)
            } catch {
                print("Error took place\(error).")
            }
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard (name: "Main", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")as! TabBarViewController
                resultVC.modalPresentationStyle = .fullScreen
                resultVC.data = self.DataItem1
                self.present(resultVC, animated: true, completion: nil)
            }
        }
        task.resume()
        }
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        
        print("locations = \(locations)") // Imprime las localizaciones
        
    }
}


