import UIKit

struct DeviceCellViewModel {

    var deviceName: String = ""
    var color: UIColor = .white
    var value: String? = nil
    var cover: UIImage? = nil
    
    init(device: Any) {
        if let light = device as? Light {
            deviceName = light.deviceName
            value = "\(light.intensity)% \(light.mode == "ON" ? L10n.on : L10n.off)"
            cover = Asset.light.image
            color = UIColor.yellow
        }
        if let rollerShutter = device as? RollerShutter {
            deviceName = rollerShutter.deviceName
            value = "Position: \(rollerShutter.position)"
            cover = Asset.rollerShutter.image
        }
        if let heater = device as? Heater {
            deviceName = heater.deviceName
            value = "\(heater.temperature)° \(heater.mode == "ON" ? L10n.on : L10n.off)"
            cover = Asset.heater.image
            color = .red
        }
    }
}
