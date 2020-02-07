import Foundation

struct PowerPlantFetchingService {
    static func getTestPowerPlantJSONData() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "PowerPlantData", ofType: "json") else {
            fatalError("PowerPlantData.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            return data
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
    }
}
