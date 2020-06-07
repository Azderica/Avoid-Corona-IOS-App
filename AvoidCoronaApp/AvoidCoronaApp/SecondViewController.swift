//
//  SecondViewController.swift
//  AvoidCoronaApp
//
//  Created by Azderica on 2020/06/02.
//  Copyright © 2020 Azderica. All rights reserved.
//

import UIKit
import GoogleMaps


class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
         let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
               let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
               mapView.isMyLocationEnabled = true
               view = mapView
               
               // Creates a marker in the center of the map.
               let marker = GMSMarker()
               marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
               marker.title = "Sydney"
               marker.snippet = "Australia"
               marker.map = mapView
    }
    
    
    
//    private var heatmapLayer: GMUHeatmapTileLayer!
//
//    override func viewDidLoad() {
//      heatmapLayer = GMUHeatmapTileLayer()
//      heatmapLayer.map = mapView
//    }
//
//    func addHeatmap()  {
//      var list = [GMUWeightedLatLng]()
//      do {
//        // Get the data: latitude/longitude positions of police stations.
//        if let path = Bundle.main.url(forResource: "police_stations", withExtension: "json") {
//          let data = try Data(contentsOf: path)
//          let json = try JSONSerialization.jsonObject(with: data, options: [])
//          if let object = json as? [[String: Any]] {
//            for item in object {
//              let lat = item["lat"]
//              let lng = item["lng"]
//              let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as! CLLocationDegrees), intensity: 1.0)
//              list.append(coords)
//            }
//          } else {
//            print("Could not read the JSON.")
//          }
//        }
//      } catch {
//        print(error.localizedDescription)
//      }
//      // Add the latlngs to the heatmap layer.
//      heatmapLayer.weightedData = list
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
