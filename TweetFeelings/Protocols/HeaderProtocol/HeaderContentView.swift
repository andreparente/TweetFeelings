import UIKit

public enum HeaderContentType {
    case title(text: String, logo: UIImage?)
}

public class HeaderContentView: UIStackView {
    
    lazy var logoImageView: UIImageView = {
        let frame = CGRect(origin: .zero, size: HeaderConstants.Layout.Logo.size)
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        return label
    }()
    
    init(type: HeaderContentType) {
        super.init(frame: .zero)
        axis = .horizontal
        alignment = .center
        spacing = HeaderConstants.Layout.spacing
        
        switch type {
        case let .title(text, logo):
            
            if let logo = logo {
                setup(title: text, image: logo)
            } else {
                setup(title: text)
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTitle(color: UIColor) {
        label.textColor = color
    }
    
    private func setup(image: UIImage) {
        addArrangedSubview(logoImageView)
        logoImageView.image = image
        
        logoImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func setup(title: String) {
        addArrangedSubview(label)
        label.text = title
        
        label.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func setup(title: String, image: UIImage) {
        setupView(with: title, logo: image)
        addArrangedSubview(logoImageView)
        addArrangedSubview(label)
    }
    
    private func setupView(with title: String, logo: UIImage) {
        logoImageView.image = logo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.snp.makeConstraints { make in
            
            if title.isEmpty {
                make.height.equalTo(HeaderConstants.Layout.Logo.size.height)
                make.width.equalTo(HeaderConstants.Layout.Logo.size.width)
            } else {
                make.height.equalTo(HeaderConstants.Layout.Title.logoHeight)
                make.width.equalTo(HeaderConstants.Layout.Title.logoWidth)
            }
            
        }
        label.text = title
    }
}
