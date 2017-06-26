//
//  TodayTableViewController.swift
//  LivioHealth
//
//  Created by Jayandhan R on 6/23/17.
//  Copyright © 2017 Jayandhan R. All rights reserved.
//

import UIKit
import GoogleMaps


enum Location {
    case startLocation
    case destinationLocation
}
class TodayTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var todayTableView: UITableView!
    
    @IBOutlet weak var googleMap: GMSMapView!
    
    var routeId: String = ""
    
    let data:[(Int,String, String, String)] = [(1,"9 AM - 11 AM", "Fairview Clinic", "3305 Central Park Commons Dr, Eagan, MN 55121, USA"),
                                               (2,"12 PM - 2 PM", "Allina Health", "7920 Old Cedar Ave S, Bloomington, MN 55425, USA")]
    
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    override func viewDidLoad() {
        todayTableView.delegate = self
        routeLookup()
         //Google maps API Key
         //AIzaSyDKkPLwXlXRa8m3FFDJCQltvw0XaDcqaRs
         GMSServices.provideAPIKey("AIzaSyAIZ3NUAZ6Y_B3XuUzxRArBmsO4S2qnhaI")

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        let camera = GMSCameraPosition.camera(withLatitude: 44.837732, longitude: -93.170299, zoom: 15.0)
        self.googleMap.camera = camera
        self.googleMap.delegate = self
        self.googleMap?.isMyLocationEnabled = true
        self.googleMap.settings.myLocationButton = true
        self.googleMap.settings.compassButton = true
        self.googleMap.settings.zoomGestures = true
    
        
        
        todayTableView.dataSource = self
        /*
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:44.854865, longitude: -93.242215)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        */
    }
    
    //function for create a marker pin oon map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMap
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Appointments"
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = todayTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let timeLabel = cell.viewWithTag(1) as! UILabel
        let pointLabel = cell.viewWithTag(2) as! UILabel
        let locationNameLabel = cell.viewWithTag(3) as! UILabel
        let addressLabel = cell.viewWithTag(4) as! UILabel
        let directionButton = cell.viewWithTag(5) as! UIButton
        
        timeLabel.text = data[indexPath.row].1
        pointLabel.text = String(data[indexPath.row].0)
        locationNameLabel.text = data[indexPath.row].2
        addressLabel.text = data[indexPath.row].3
        
        directionButton.backgroundColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.99, alpha: 1.0)
        directionButton.layer.cornerRadius = 5
        
        pointLabel.layer.cornerRadius = 20
        pointLabel.backgroundColor = UIColor(hue: 0.5528, saturation: 1, brightness: 0.99, alpha: 1.0)

        if(indexPath.row%2 == 0) {
            cell.backgroundColor = UIColor.lightGray
        }
    
        return cell
    }
    
    
    func routeLookup() {
        
        
        let urlString = "https://www.route4me.com/api.v4/route.php?api_key=620A14373BA32A92796B3D2038B65A37&query=LocalMainBuilding&format=json"
        let escaped = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: escaped!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error ) in
            
            if error != nil {
                print("ERROR")
            }
            else {
                
                if let content = data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: String]]
                        print(responseJSON)
                        
                       
 
                        
                    }
                    catch {
                        
                    }
                }
            }
            
        }
        task.resume()
        
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
