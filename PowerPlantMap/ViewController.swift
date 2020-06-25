import UIKit
import MapKit

class ViewController: UIViewController {
    
    var power = [PowerPlant]()
    
    lazy var map: MKMapView = {
        let m = MKMapView()
        m.delegate = self
        
        
        return m
    }()
    
    func getData(){
        let data = PowerPlantFetchingService.getTestPowerPlantJSONData()
        power = PowerPlant.makePowerPlants(from: data)
    }
    
    func setRegion(){
        let initialLocation = CLLocationCoordinate2D(latitude: -32.395, longitude: 150.9492)
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.setRegion(region, animated: true)
    }
    
    func addAnnotations(plants: [PowerPlant]){
        
        for location in plants {
            let pins = MKPointAnnotation()
            pins.title = location.plant_name
            pins.subtitle = location.type.rawValue
            pins.coordinate = CLLocationCoordinate2D(latitude: location.coordinate?.latitude ?? 0, longitude: location.coordinate?.longitude ?? 0)
            map.addAnnotation(pins)
        }
        print(map.annotations)
    }
    
    
    func setUp(){
        map.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(map)
        
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            map.leftAnchor.constraint(equalTo: view.leftAnchor),
            map.rightAnchor.constraint(equalTo: view.rightAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getData()
        setRegion()
        addAnnotations(plants: power)
//        print(power[0].coordinate?.longitude ?? 0)
//        print(power[0].coordinate?.latitude ?? 0 )
        //        power[0].type
        //        power[0].plant_name
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //print("test")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        print(annotation)
        
        return annotationView
    }
}
