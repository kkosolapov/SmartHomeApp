import XCTest
@testable import ModuloTech

class LightTests: XCTestCase {

    var viewModel: DeviceDetailViewModel!

    override func setUpWithError() throws {
        super.setUp()
        viewModel = DeviceDetailViewModel()
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        super.tearDown()
    }

    func testValueInViewModel() throws {

        let device = Light(id: 1, deviceName: "Lumière - SDB", intensity: 80, mode: "ON", productType: "Light")
        
        viewModel = DeviceDetailViewModel(device: device)
        
        XCTAssertEqual(viewModel.valueText, "80% On")
        XCTAssertEqual(viewModel.value, 80)
        XCTAssertEqual(viewModel.productType, "Light")
        XCTAssertEqual(viewModel.name, "Lumière - SDB")
        XCTAssertEqual(viewModel.isOn, true)
    }
}
