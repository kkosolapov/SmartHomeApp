import UIKit

class ButtonView: UIView {
    
    var title: String = ""
    var image: UIImage? = nil
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = title
        return label
    }()
    
    private lazy var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        return imageView
    }()
    
    init(title: String, image: UIImage) {
        super.init(frame: .zero)

        self.title = title
        self.image = image

        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        backgroundColor = .white
        
        setTitleLabel()
        setCover()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    private func setCover() {
        addSubview(cover)
        cover.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        cover.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        cover.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cover.heightAnchor.constraint(equalToConstant: 48).isActive = true
        cover.widthAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveLinear, animations: {
                self.alpha = 0.5
            }, completion: nil)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveLinear, animations: {
                self.alpha = 1.0
            }, completion: nil)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveLinear, animations: {
                self.alpha = 1.0
            }, completion: nil)
        }
    }
}
