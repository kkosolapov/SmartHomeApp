import UIKit

protocol DeviceDetailDelegate {

    func onValueChanged(value: Float)
    func onTapArrowUp()
    func onTapArrowDown()
}

class DeviceDetailViewController: UIViewController {
    
    var viewModel: DeviceDetailViewModel!

    init(device: Any) {
        super.init(nibName: nil, bundle: nil)
        setupView(for: device)
        initViewModel(for: device)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(for device: Any) {
        let v = DeviceDetailView(frame: view.frame, device: device)
        v.delegate = self
        view = v
    }
    
    func initViewModel(for device: Any) {
        viewModel = DeviceDetailViewModel(device: device)
        if let view = self.view as? DeviceDetailView {
            view.setNameText(text: viewModel.name)
            view.setValueText(text: viewModel.valueText)
            view.setColorViewHidden(isHidden: viewModel.isHidden)
            view.setSwitchButton(isOn: viewModel.isOn)
            view.setSliderValue(value: viewModel.value)
            view.setColorViewColor(color: viewModel.color)
            view.setColorViewHeight(height: viewModel.getColorViewHeight(with: view.frame.height))
        }
    }
}

extension DeviceDetailViewController: DeviceDetailDelegate {
        
    func onValueChanged(value: Float) {
        viewModel.onValueChanged(value: value)
        (view as? DeviceDetailView)?.setColorViewHeight(height: viewModel.getColorViewHeight(with: view.frame.height))
        (view as? DeviceDetailView)?.setValueText(text: viewModel.valueText)
    }

    func onTapArrowUp() {
        viewModel.onTapArrowUp()
        (view as? DeviceDetailView)?.setColorViewHeight(height: viewModel.getColorViewHeight(with: view.frame.height))
        (view as? DeviceDetailView)?.setValueText(text: viewModel.valueText)
    }

    func onTapArrowDown() {
        viewModel.onTapArrowDown()
        (view as? DeviceDetailView)?.setColorViewHeight(height: viewModel.getColorViewHeight(with: view.frame.height))
        (view as? DeviceDetailView)?.setValueText(text: viewModel.valueText)
    }
}
