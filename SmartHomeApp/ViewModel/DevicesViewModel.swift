import Foundation

class DevicesViewModel {
    
    private var devices: [Any] = []
    private var type: String = ""
    
    init(type: String) {
        self.type = type
    }
    
    var numberOfRowsInSection: Int {
        return devices.count
    }
    
    func fetchData() {
        switch type {
        case "all":
            devices = []
            devices.append(contentsOf: UserDatabase.shared.getLights())
            devices.append(contentsOf: UserDatabase.shared.getRollerShutters())
            devices.append(contentsOf:UserDatabase.shared.getHeaters())
        case "lights": devices = UserDatabase.shared.getLights()
        case "rollerShutters": devices = UserDatabase.shared.getRollerShutters()
        case "heaters": devices = UserDatabase.shared.getHeaters()
        default: break
        }
    }
    
    func getDeviceViewModel(at idx: Int) -> DeviceCellViewModel {
        return DeviceCellViewModel(device: devices[idx])
    }
    
    func didSelectRow(at idx: Int) -> Any {
        return devices[idx]
    }
}
