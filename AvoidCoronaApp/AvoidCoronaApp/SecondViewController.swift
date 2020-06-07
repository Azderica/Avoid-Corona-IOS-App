//
//  SecondViewController.swift
//  AvoidCoronaApp
//
//  Created by Azderica on 2020/06/02.
//  Copyright © 2020 Azderica. All rights reserved.
//

import GoogleMaps
import GoogleMapsUtils
import UIKit

class SecondViewController: UIViewController {
    var passengerData: PassengerData?
    private var heatmapLayer: GMUHeatmapTileLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView

        // Creates a marker in the center of the map.6
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.map = mapView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if passengerData == nil {
            loadData()
        }
    }

    private func loadData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.passengerData = PassengerData()
            // Add to UI

            DispatchQueue.main.async {
                self?.addHeatmap()
            }
        }
    }

//    private var heatmapLayer: GMUHeatmapTileLayer!
//
//    override func viewDidLoad() {
//      heatmapLayer = GMUHeatmapTileLayer()
//      heatmapLayer.map = mapView
//    }
//
    func addHeatmap() {
        
        var list = [GMUWeightedLatLng]()
        do {
            guard let locations = passengerData?.locations else {
                return
            }

            for item in locations {
                switch item {
                case let .busStation(station, lat, long, passengers), let .subwayStation(station, lat, long, passengers):
                    let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, long as! CLLocationDegrees), intensity: passengers)
                    list.append(coords)
                }
            }

            // Add the latlngs to the heatmap layer.
            heatmapLayer.weightedData = list
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
