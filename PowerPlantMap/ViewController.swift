import UIKit
import MapKit

class ViewController: UIViewController {
    
    var power = [PowerPlant]()
    
    lazy var map: MKMapView = {
        let m = MKMapView()
        m.delegate = self
        return m
    }()
    
    ///gets data from json file converting it into a readable data
    func getData(){
        let data = PowerPlantFetchingService.getTestPowerPlantJSONData()
        power = PowerPlant.makePowerPlants(from: data)
    }
    ///starts the map location at the first pin/annotation
    func setRegion(){
        let initialLocation = CLLocationCoordinate2D(latitude: -32.395, longitude: 150.9492)
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
        map.setRegion(region, animated: true)
    }
    
    ///adds the pins to the map
    func addAnnotations(plants: [PowerPlant]){
        for location in plants {
            let pins = MKPointAnnotation()
            pins.title = location.plant_name
            pins.subtitle = location.type.rawValue
            pins.coordinate = CLLocationCoordinate2D(latitude: location.coordinate?.latitude ?? 0, longitude: location.coordinate?.longitude ?? 0)
            map.addAnnotation(pins)
        }
    }
    
    
    ///sets up mapview with constraints
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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getData()
        setRegion()
        addAnnotations(plants: power)
    }
}

extension ViewController: MKMapViewDelegate {
    
    ///loads the annotations onto the map like cells for tableview
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //annotationView?.image = UIImage(named: "keyblade") this changes the image of the pin
            annotationView!.canShowCallout = true
            let image = UIImage(named: "keyblade")
            let imageView = UIImageView(image: image)
            //can't seem to use frame CGRect to adjust size does not conform to uiview
            
            
//            let btn = UIButton(type: .detailDisclosure)
            annotationView?.detailCalloutAccessoryView = imageView //or UIImageView(image: image)
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.coordinate)
    }
}
