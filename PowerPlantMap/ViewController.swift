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
    
    func addAnnotations(plants: [PowerPlant]){
        let pins = MKPointAnnotation()
        for location in plants {
            pins.title = location.plant_name
            //if let long = location {}
            pins.coordinate = CLLocationCoordinate2D(latitude: location.coordinate?.latitude ?? 0, longitude: location.coordinate?.longitude ?? 0)
            
            map.addAnnotation(pins)
        }
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
    
    func setRegion(){
        let initialLocation = CLLocationCoordinate2D(latitude: 150.9492, longitude: -32.395)
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getData()
        //setRegion()
        addAnnotations(plants: power)
        print(power[0].coordinate?.longitude ?? 0)
        print(power[0].coordinate?.latitude ?? 0 )
        //        power[0].type
        //        power[0].plant_name
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("test")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return MKAnnotationView()
    }
    
    
    
}
