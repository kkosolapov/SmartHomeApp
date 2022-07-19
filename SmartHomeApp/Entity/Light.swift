import Foundation

struct Light: Decodable {
    let id: Int
    let deviceName: String
    let intensity: Int
    let mode: String
    let productType: String
    
    enum CodingKeys : CodingKey { case id, deviceName, productType, intensity, mode }
    
    init(id: Int, deviceName: String, intensity: Int, mode: String, productType: String) {
        self.id = id
        self.deviceName = deviceName
        self.intensity = intensity
        self.mode = mode
        self.productType = productType
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        deviceName = try values.decode(String.self, forKey: .deviceName)
        productType = try values.decode(String.self, forKey: .productType)
        intensity = try values.decode(Int.self, forKey: .intensity)
        mode = try values.decode(String.self, forKey: .mode)
    }
}
