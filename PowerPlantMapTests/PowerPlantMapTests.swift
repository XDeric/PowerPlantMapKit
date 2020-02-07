import XCTest
@testable import PowerPlantMap

class PowerPlantMapTests: XCTestCase {
  func testGetPowerPlants() {
        let testData = PowerPlantFetchingService.getTestPowerPlantJSONData()
        let plants = PowerPlant.makePowerPlants(from: testData)
        XCTAssert(plants.count == 14, "Error, was expecting 14 plants, but got \(plants.count)")
    }
}
