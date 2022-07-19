import UIKit

protocol CustomSliderDelegate {
    func onValueChange(value: Float)
}

class CustomSlider : UISlider {
    
    var delegate: CustomSliderDelegate? = nil
    
    let thumb: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 6
        view.layer.borderColor = UIColor.init(hexString: "#565656").cgColor
        return view
    }()

    init() {
        super.init(frame: .init(x: 0, y: 0, width: 200, height: 20))
        transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        addTarget(self, action: #selector(onSliderChangeValue), for: .valueChanged)
        minimumTrackTintColor = .init(hexString: "#A88063")
        maximumTrackTintColor = .init(hexString: "#ECF0F1")
        setThumbImage(thumbImage(diameter: 24), for: .normal)
        maximumValue = 100
        minimumValue = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onSliderChangeValue(sender: UISlider!) {
        let newValue = Float(Int(sender.value/10) * 10)
        delegate?.onValueChange(value: newValue)
        sender.setValue(Float(newValue), animated: false)
    }
    
    private func thumbImage(diameter: CGFloat) -> UIImage {
        thumb.frame = CGRect(x: 0, y: diameter / 2, width: diameter, height: diameter)
        thumb.layer.cornerRadius = diameter / 2
        let renderer = UIGraphicsImageRenderer(bounds: thumb.bounds)
        return renderer.image { rendererContext in
            thumb.layer.render(in: rendererContext.cgContext)
        }
    }
}
