import UIKit

class DeviceDetailViewModel {
    
    var id: Int = 0
    var name: String? = nil
    var value: Float = 0
    var valueText: String? = nil
    var isOn: Bool = true
    var isHidden: Bool = false
    var color: UIColor!
    var productType: String = ""
    
    init() { }
    
    init(device: Any) {
        if let device = device as? Light {
            id = device.id
            name = device.deviceName
            isOn = device.mode == "ON"
            isHidden = !isOn
            color = .init(hexString: "#FFFACD")
            value = Float(device.intensity)
            valueText = "\(device.intensity)% \(isOn ? L10n.on : L10n.off)"
            productType = device.productType
        }
        if let device = device as? RollerShutter {
            id = device.id
            name = device.deviceName
            color = .init(hexString: "#D3D3D3")
            value = Float(device.position)
            valueText = "Position: \(device.position)"
            productType = device.productType
        }
        if let device = device as? Heater {
            id = device.id
            name = device.deviceName
            isOn = device.mode == "ON"
            isHidden = !isOn
            color = .init(hexString: "#FF7F7F")
            value = Float(device.temperature)
            valueText = "\(device.temperature)° \(isOn ? L10n.on : L10n.off)"
            productType = device.productType
        }
    }
    
    func getColorViewHeight(with height: CGFloat) -> CGFloat {
        if productType == "Heater" {
            return height * CGFloat(value / 28)
        }
        return height * CGFloat(value) / 100
    }

    func onValueChanged(value: Float) {
        self.value = value
        valueText = "\(Int(self.value))% \(isOn ? L10n.on : L10n.off)"
        updateDeviceValue()
    }
   
    func onTapArrowUp() {
        value += 5
        if value >= 28 {
            value = 28
        }
        valueText = "\(Int(value))° \(isOn ? L10n.on : L10n.off)"
        updateDeviceValue()
    }

    func onTapArrowDown() {
        value -= 5
        if value <= 7 {
            value = 7
        }
        valueText = "\(Int(value))° \(isOn ? L10n.on : L10n.off)"
        updateDeviceValue()
    }
    
    private func updateDeviceValue() {
        switch productType {
        case "Light": UserDatabase.shared.updateLightValueById(id: id, value: Int(value))
        case "RollerShutter": UserDatabase.shared.updateRollerShutterValueById(id: id, value: Int(value))
        case "Heater": UserDatabase.shared.updateHeaterValueById(id: id, value: Int(value))
        default: break
        }

    }
    
    private func updateDeviceMode() {
        switch productType {
        case "Light": UserDatabase.shared.updateLightModeById(id: id, mode: isOn)
        case "Heater": UserDatabase.shared.updateHeaterModeById(id: id, mode: isOn)
        default: break
        }
    }
}
