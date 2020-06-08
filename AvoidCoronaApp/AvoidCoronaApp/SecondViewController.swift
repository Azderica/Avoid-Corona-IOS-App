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

class SecondViewController: UIViewController, GMSMapViewDelegate {
    var passengerData: PassengerData?
    private var heatmapLayer: GMUHeatmapTileLayer!
    private var mapView: GMSMapView!
    
    
    // Adjust gradientStartPoints, radius, colorMapSize to change map coloring.
    // It is particularly about the difference between the gradientStartPoints, and how low they are.
    private var gradientColors = [UIColor.orange, UIColor.red]
    private var gradientStartPoints = [0.02, 0.04] as [NSNumber]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.radius = 93
        heatmapLayer.opacity = 0.6 // 0.6 is fine, no need to change this
        heatmapLayer.gradient = GMUGradient(colors: gradientColors,
                                            startPoints: gradientStartPoints,
                                            colorMapSize: 1024+512)
    }

    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 35.86784, longitude: 128.59370, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.setMinZoom(13, maxZoom: 13)
//        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        self.view = mapView

//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
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
                self?.heatmapLayer.map = self?.mapView
            }
        }
    }

//    private var heatmapLayer: GMUHeatmapTileLayer!
//
//    override func viewDidLoad() {
//      heatmapLayer = GMUHeatmapTileLayer()
//      heatmapLayer.map = mapView
//    }super.
//
    func addHeatmap() {
        print("Entered addHeatmap()")
        var list = [GMUWeightedLatLng]()
        do {
            guard let locations = passengerData?.locations else {
                return
            }

            for item in locations {
                let coords: GMUWeightedLatLng
                switch item {
                case let .busStation(_, lat, long, passengers):
                    coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat.rounded(digits: 4) , long.rounded(digits: 4) ), intensity: Float(passengers))
                case let .subwayStation(_, lat, long, passengers):
                    coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat.rounded(digits: 4) , long.rounded(digits: 4) ), intensity: Float(passengers / 6))
                }
                list.append(coords)
            }
            
            print("Length of list: \(list.count)")
            // Add the latlngs to the heatmap layer.
//            heatmapLayer.weightedData = Array(list[0..<50])
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

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
