import Foundation

struct RollerShutter: Decodable {
    let id: Int
    let deviceName: String
    let position: Int
    let productType: String
    
    enum CodingKeys : CodingKey { case id, deviceName, productType, position }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        deviceName = try values.decode(String.self, forKey: .deviceName)
        productType = try values.decode(String.self, forKey: .productType)
        position = try values.decode(Int.self, forKey: .position)
    }
}
