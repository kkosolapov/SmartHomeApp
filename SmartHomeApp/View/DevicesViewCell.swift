import UIKit

class DeviceViewCell: UITableViewCell {
    
    public static let identifier = "device_cell"
    
    var numberOfRows = 0
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.5
        view.backgroundColor = .white
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        setCover()
        setValueLabel()
        setNameLabel()    }
    
    private func setCover() {
        view.addSubview(cover)
        cover.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        cover.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cover.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cover.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.text = "Name label"
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -2).isActive = true
    }
    
    private func setValueLabel() {
        view.addSubview(valueLabel)
        valueLabel.text = "Value label"
        valueLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 2).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: cover.trailingAnchor, constant: 8).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    func configure(viewModel: DeviceCellViewModel) {
        nameLabel.text = viewModel.deviceName
        valueLabel.text = viewModel.value
        cover.image = viewModel.cover
        cover.image = cover.image?.withAlignmentRectInsets(UIEdgeInsets(top: -16, left: -16, bottom: -16, right: -16))
    }
}
