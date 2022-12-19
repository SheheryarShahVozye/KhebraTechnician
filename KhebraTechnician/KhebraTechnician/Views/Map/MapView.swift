// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import SwiftUI
import GoogleMaps
import AVFAudio
import Foundation
import UIKit
import GooglePlaces
import MapKit
import Combine

/// The wrapper for `GMSMapView` so it can be used in SwiftUI
struct MapView: UIViewRepresentable {

  @Binding var markers: [GMSMarker]
  @Binding var selectedMarker: GMSMarker?

  var onAnimationEnded: () -> ()

  private let gmsMapView = GMSMapView(frame: .zero)
  private let defaultZoomLevel: Float = 10

  func makeUIView(context: Context) -> GMSMapView {
    // Create a GMSMapView centered around the city of San Francisco, California
    let sanFrancisco = CLLocationCoordinate2D(latitude: 37.7576, longitude: -122.4194)
    gmsMapView.camera = GMSCameraPosition.camera(withTarget: sanFrancisco, zoom: defaultZoomLevel)
    gmsMapView.delegate = context.coordinator
    gmsMapView.isUserInteractionEnabled = true
    return gmsMapView
  }

  func updateUIView(_ uiView: GMSMapView, context: Context) {
    markers.forEach { marker in
      marker.map = uiView
    }
    if let selectedMarker = selectedMarker {
      let camera = GMSCameraPosition.camera(withTarget: selectedMarker.position, zoom: defaultZoomLevel)
      print("Animating to position \(selectedMarker.position)")
      CATransaction.begin()
      CATransaction.setValue(NSNumber(floatLiteral: 5), forKey: kCATransactionAnimationDuration)
      gmsMapView.animate(with: GMSCameraUpdate.setCamera(camera))
      CATransaction.commit()
    }
  }

  func makeCoordinator() -> MapViewCoordinator {
    return MapViewCoordinator(self)
  }
  

  final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
    var mapView: MapView

    init(_ mapView: MapView) {
      self.mapView = mapView
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//      let marker = GMSMarker(position: coordinate)
//      self.mapView.polygonPath.append(marker)
    }
      
     

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      self.mapView.onAnimationEnded()
    }

  }
}



struct GoogleMapsView: UIViewRepresentable {
     var longitude: Double
     var latitude: Double
    @State var marker : GMSMarker = GMSMarker()
    let cities = [
        [
            "name": "Yangon",
            "lat": 16.8409,
            "long": 96.1735
        ],
        [
            "name": "Mandalay",
            "lat": 21.9588,
            "long": 96.0891
        ]
    ]
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 0.3)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
       
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(owner: self)
    }
    
    //    func updateLocationoordinates(coordinates:CLLocationCoordinate2D) {
    //        if marker == nil
    //        {
    //            marker = GMSMarker()
    //            marker.position = coordinates
    //            let image = UIImage(named:"destinationmarker")
    //            marker.icon = image
    //            marker.map = mapPageView
    //            marker.appearAnimation = GMSMarkerAnimation.pop
    //        }
    //        else
    //        {
    //            CATransaction.begin()
    //            //            CATransaction.setAnimationDuration(0.1)
    //            marker.position =  coordinates
    //            CATransaction.commit()
    //        }
    //        print(coordinates)
    //    }
    
    
    func mapView (_ mapView: GMSMapView, didEndDragging didEndDraggingMarker: GMSMarker) {
        
        
      
        print("Drag ended!")
        print("Update Marker data if stored somewhere.")
        
        
    }
    
    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        //            for city in cities {
        //                let marker : GMSMarker = GMSMarker()
        //                marker.position = CLLocationCoordinate2D(latitude: city["lat"] as! CLLocationDegrees, longitude: city["long"] as! CLLocationDegrees)
        //                marker.title = city["name"] as? String
        //                marker.snippet = "Welcome to \(city["name"] as! String)"
        //                marker.icon = UIImage(named: "Group 8274")
        //                marker.map = mapView
        //            }
        
        // marker : GMSMarker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Your location"
        //     marker.snippet = "Welcome to \(city["name"] as! String)"
        marker.icon = UIImage(named: "Group 8274")
        marker.map = mapView
        
        mapView.animate(toZoom: 10)
        marker.isDraggable = true;
        marker.isDraggable = true
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        let owner: GoogleMapsView       // access to owner view members,
        
        init(owner: GoogleMapsView) {
            self.owner = owner
        }
        
        func mapView (_ mapView: GMSMapView, didEndDragging didEndDraggingMarker: GMSMarker) {
            
            
          
            print("Drag ended!")
            print("Update Marker data if stored somewhere.")
            
            
        }
      
        
        
    }
    
}





struct PlacePicker: UIViewControllerRepresentable {
    @ObservedObject var locationSearchService = LocationSearchService()
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var address: String
    @Binding var latitude: Double
    @Binding var longitude: Double
    @Binding var stateTogg: Bool
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacePicker>) -> GMSAutocompleteViewController {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue) | GMSPlaceField.addressComponents.rawValue)
        autocompleteController.placeFields = fields
        
        
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "Pak"
        autocompleteController.autocompleteFilter = filter
        
        return autocompleteController
    }
    
    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacePicker>) {
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {
        
        var parent: PlacePicker
        
        init(_ parent: PlacePicker) {
            self.parent = parent
            
        }
        
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            DispatchQueue.main.async {
                
                print(place.description.description as Any)
                
                
                
                self.parent.address =  place.name!
                self.parent.latitude = place.coordinate.latitude
                self.parent.longitude = place.coordinate.longitude
                self.parent.presentationMode.wrappedValue.dismiss()
                self.parent.stateTogg.toggle()
            }
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
}

struct PlaceAnnotationView: View {
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 57, height: 55, alignment: .center)
                .foregroundColor(Color("FEBB12").opacity(0.4))
            Circle()
                .frame(width: 24, height: 25, alignment: .center)
                .foregroundColor(Color("White"))
            
            Circle()
                .frame(width: 14, height: 15, alignment: .center)
                .foregroundColor(Color("FEBB12"))
            
        }.frame(width: 57, height: 55, alignment: .center)
    }
}
