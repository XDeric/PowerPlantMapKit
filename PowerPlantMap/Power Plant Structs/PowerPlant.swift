import Foundation

struct APIResponse: Codable {
    let nhits: Int
    let parameters: ResponseParameters
    let records: [PowerPlantWrapper]
}

struct ResponseParameters: Codable {
    let rows: Int
    let start: Int?
}

struct PowerPlantWrapper: Codable {
    let fields: PowerPlant
    let geometry: GeometryWrapper
}

struct PowerPlant: Codable {
    static func makePowerPlants(from jsonData: Data) -> [PowerPlant] {
        do {
            let json = try JSONDecoder().decode(APIResponse.self, from: jsonData)
            return json.records.map { (wrapper) in
                var powerPlant = wrapper.fields
                powerPlant.coordinate = Coordinate(latitude: wrapper.geometry.coordinates[1],
                                                   longitude: wrapper.geometry.coordinates[0])
                
                return powerPlant
            }
        } catch {
            print(error)
        }
        return []
    }
    let plant_name: String
    let type: EnergyType
    var coordinate: Coordinate?
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

struct GeometryWrapper: Codable {
    let coordinates: [Double]
}

enum EnergyType: String, Codable  {
    case coal = "COAL"
    case gas = "GAS"
    case geothermal = "GEOTHERMAL"
    case hydro = "HYDRO"
    case nuclear = "NUCLEAR"
    case oil = "OIL"
    case solar_vc = "SOLAR_PV"
    case solar_thermal = "SOLAR_THERMAL"
    case waster = "WASTE"
    case wind = "WIND"
}
