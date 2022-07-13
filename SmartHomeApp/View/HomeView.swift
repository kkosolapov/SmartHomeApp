import UIKit

class CustomTapGesture: UITapGestureRecognizer {
    var identifier: String = ""
}

class HomeView: UIView {

    let allDevicesButtonView: ButtonView = {
        let view = ButtonView(title: L10n.all.capitalized, image: Asset.all.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let lightDevicesButtonView: ButtonView = {
        let view = ButtonView(title: L10n.lights.capitalized, image: Asset.light.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let rollerShutterDevicesButtonView: ButtonView = {
        let view = ButtonView(title: L10n.rollerShutters.capitalized, image: Asset.rollerShutter.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let heaterDevicesButtonView: ButtonView = {
        let view = ButtonView(title: L10n.heaters.capitalized, image: Asset.heater.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var delegate: HomeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        setupAllDevicesButtonView()
        setupLightDevicesButtonView()
        setupRollerShutterDevicesButtonView()
        setupHeaterDevicesButtonView()
        
        UserDatabase.shared.initData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAllDevicesButtonView() {
        addSubview(allDevicesButtonView)

        let tap = CustomTapGesture(target: self, action: #selector(onClick(_:)))
        tap.identifier = "all"
        allDevicesButtonView.isUserInteractionEnabled = true
        allDevicesButtonView.addGestureRecognizer(tap)

        allDevicesButtonView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true
        allDevicesButtonView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8).isActive = true
        allDevicesButtonView.heightAnchor.constraint(equalToConstant: (frame.width/2)-20).isActive = true
        allDevicesButtonView.widthAnchor.constraint(equalToConstant: (frame.width/2)-20).isActive = true
    }
    
    private func setupLightDevicesButtonView() {
        addSubview(lightDevicesButtonView)

        let tap = CustomTapGesture(target: self, action: #selector(onClick(_:)))
        tap.identifier = "lights"
        lightDevicesButtonView.isUserInteractionEnabled = true
        lightDevicesButtonView.addGestureRecognizer(tap)

        lightDevicesButtonView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true
        lightDevicesButtonView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 8).isActive = true
        lightDevicesButtonView.heightAnchor.constraint(equalToConstant: (frame.width/2)-20).isActive = true
        lightDevicesButtonView.widthAnchor.constraint(equalToConstant: (frame.width/2)-20).isActive = true
    }
    
    private func setupRollerShutterDevicesButtonView() {
        addSubview(rollerShutterDevicesButtonView)

        let tap = CustomTapGesture(target: self, action: #selector(onClick(_:)))
        tap.identifier = "rollerShutters"
        rollerShutterDevicesButtonView.isUserInteractionEnabled = true
        rollerShutterDevicesButtonView.addGestureRecognizer(tap)

        rollerShutterDevicesButtonView.topAnchor.constraint(equalTo: centerYAnchor, constant: 8).isActive = true
        rollerShutterDevicesButtonView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8).isActive = true
        rollerShutterDevicesButtonView.heightAnchor.constraint(equalToConstant: (frame.width/2)-20).isActive = true
        rollerShutterDevicesButtonView.widthAnchor.constraint(equalToConstant: (frame.width/2)-20).isActive = true
    }

    private func setupHeaterDevicesButtonView() {
        addSubview(heaterDevicesButtonView)

        let tap = CustomTapGesture(target: self, action: #selector(onClick(_:)))
        tap.identifier = "heaters"
        heaterDevicesButtonView.isUserInteractionEnabled = true
        heaterDevicesButtonView.addGestureRecognizer(tap)

        heaterDevicesButtonView.topAnchor.constraint(equalTo: centerYAnchor, constant: 8).isActive = true
        heaterDevicesButtonView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 8).isActive = true
        heaterDevicesButtonView.heightAnchor.constraint(equalToConstant: (frame.width/2)-20).isActive = true
        heaterDevicesButtonView.widthAnchor.constraint(equalToConstant: (frame.width/2)-20).isActive = true
    }
    
    @objc func onClick(_ sender: CustomTapGesture) {
        delegate?.didSelectDevices(for: sender.identifier)
    }
}
