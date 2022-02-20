import UIKit
import SnapKit

protocol ProfileHeaderViewProtocol {
    var nameLabel: UILabel { get set }
    var usernameLabel: UILabel { get set }
    var userImageView: UIImageView { get set }
}

final class ProfileHeaderView: UITableViewHeaderFooterView,
                               Reusable,
                               ProfileHeaderViewProtocol{
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileHeaderView: ViewCodable {
    func setupViews() {
        addSubview(userImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
    }
    
    func setupAnchors() {
        userImageView.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.left.top.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(8)
            make.right.lessThanOrEqualToSuperview()
            make.bottom.equalTo(userImageView.snp.centerY)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(8)
            make.right.lessThanOrEqualToSuperview()
            make.top.equalTo(userImageView.snp.centerY)
        }
    }
    
    func setupLayouts() {
        
    }
}
