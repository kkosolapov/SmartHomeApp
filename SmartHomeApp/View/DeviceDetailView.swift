import UIKit

class DeviceDetailView: UIView {
    
    var colorViewHeightConstraint: NSLayoutConstraint? = nil
    
    var delegate: DeviceDetailDelegate? = nil

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     
    let switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        return switchButton
    }()

    let verticalSlider = CustomSlider()

    init(frame: CGRect, device: Any) {
        super.init(frame: frame)
                
        backgroundColor = .white

        if device is Light {
            setupColorView()
            setupSlider()
            setupSwitchButton()
        }
        if device is RollerShutter {
            setupColorView(upside: true)
            setupSlider()
        }
        if device is Heater {
            setupColorView()
            setupSwitchButton()
            setupHeaterControlButton()
        }
        setupNameLabel()
        setupValueLabel()
        setupDeletebutton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        nameLabel.text = "NAME"
    }
    
    private func setupValueLabel() {
        addSubview(valueLabel)
        valueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        valueLabel.text = "VALUE"
    }
    
    private func setupColorView(upside: Bool = false) {
        addSubview(colorView)
        colorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        colorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        colorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = !upside
        colorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = upside
        colorViewHeightConstraint = colorView.heightAnchor.constraint(equalToConstant: 0)
        colorViewHeightConstraint?.isActive = true
    }

    private func setupSlider() {
        addSubview(verticalSlider)
        verticalSlider.delegate = self
        verticalSlider.center = center
    }
    
    
    private func setupSwitchButton() {
        addSubview(switchButton)
        switchButton.addTarget(self, action: #selector(onClickSwitch), for: .touchUpInside)
        switchButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        switchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
    
    private func setupHeaterControlButton() {
        let upButton = UIButton()
        let downButton = UIButton()
        
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.setImage(Asset.arrowUp.image, for: .normal)
        upButton.addTarget(self, action: #selector(onTapArrowUp), for: .touchUpInside)
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.setImage(Asset.arrowDown.image, for: .normal)
        downButton.addTarget(self, action: #selector(onTapArrowDown), for: .touchUpInside)

        addSubview(upButton)
        addSubview(downButton)
        
        upButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        upButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        downButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        downButton.topAnchor.constraint(equalTo: centerYAnchor, constant: 4).isActive = true
    }
    
    // TODO UP/DOWN ARROW
    
    @objc func onTapArrowUp() {
        delegate?.onTapArrowUp()
    }

    @objc func onTapArrowDown() {
        delegate?.onTapArrowDown()
    }

    
    @objc func onClickSwitch() {
        delegate?.onClickSwitch(isOn: switchButton.isOn)
    }
    
    func setNameText(text: String?) {
        nameLabel.text = text
    }
    
    func setValueText(text: String?) {
        valueLabel.text = text
    }
    
    func setSliderValue(value: Float) {
        verticalSlider.setValue(value, animated: true)
    }
    
    func setColorViewColor(color: UIColor) {
        colorView.backgroundColor = color
    }
    
    func setColorViewHeight(height: CGFloat) {
        colorViewHeightConstraint?.constant = height
    }

    func setColorViewHidden(isHidden: Bool) {
        colorView.isHidden = isHidden
    }
    
    func setSwitchButton(isOn: Bool) {
        switchButton.isOn = isOn
    }

}

extension DeviceDetailView: CustomSliderDelegate {

    func onValueChange(value: Float) {
        delegate?.onValueChanged(value: value)
    }
}
