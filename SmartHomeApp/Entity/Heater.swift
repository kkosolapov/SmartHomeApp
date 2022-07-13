import Foundation

struct Heater: Decodable {
    let id: Int
    let deviceName: String
    let mode: String
    let temperature: Int
    let productType: String
    
    enum CodingKeys : CodingKey { case id, deviceName, productType, temperature, mode }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        deviceName = try values.decode(String.self, forKey: .deviceName)
        productType = try values.decode(String.self, forKey: .productType)
        temperature = try values.decode(Int.self, forKey: .temperature)
        mode = try values.decode(String.self, forKey: .mode)
    }
}
