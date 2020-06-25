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
    
    func addAnnotation(){
        
        
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
//        power[0].coordinate?.longitude
//        power[0].coordinate?.latitude
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
