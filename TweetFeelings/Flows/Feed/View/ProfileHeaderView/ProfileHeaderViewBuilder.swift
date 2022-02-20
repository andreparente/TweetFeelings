import Kingfisher
import UIKit

class ProfileHeaderViewBuilder {
    var header: ProfileHeaderViewProtocol
    
    init(header: ProfileHeaderViewProtocol) {
        self.header = header
    }
    
    func build(with data: TwitterUserProtocol) {
        header.usernameLabel.text = data.username
        header.nameLabel.text = data.name
        header.userImageView.kf.setImage(with: data.profileImageUrl,
                                         placeholder: UIImage(named: "userPlaceholder"))
        header.usernameLabel.textColor = data.isVerified ? .systemGreen : .systemYellow
    }
}
