import UIKit

struct Constants {
    
    static let leadingMargin:CGFloat = 16
    static let trailingMargin:CGFloat = -16
    static let indent:CGFloat = 16
    
    static let logoImage: UIImage? = UIImage(named: .logoImageNamed)
    static let logoImageViewFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)
    static let logoImageViewBorderWidth: CGFloat = 3.0
    static let logoImageViewCornerRadius: CGFloat = 50
    static let logoImageViewBorderColor: CGColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
    static let logoImageViewWidth: CGFloat = 100
    
    static let nameLabelFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    static let nameLabelColor: UIColor = .black
    
    static let statusLabelFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let statusLabelColor: UIColor = .gray
    static let statusLabelBottomAnchor: CGFloat = 6
    static let statusLabelNumberOfLines: Int = 2

    static let statusTextFieldFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    static let statusTextFieldCornerRadius: CGFloat = 12
    static let statusTextFieldColor: UIColor = .black
    static let statusTextFieldBackgroundColor: UIColor = .white
    static let statusTextFieldBorderWidth: CGFloat = 1
    static let statusTextFieldBorderColor: CGColor = UIColor.black.cgColor
    static let statusTextFieldHeight: CGFloat = 40.0
    static let statusTextFieldWidth: CGFloat = 226.0
    static let statusTextFieldBottomAnchor: CGFloat = 10
    
    static let showStatusButtonColor: UIColor = .systemBlue
    static let showStatusButtonCornerRadius: CGFloat = 12.0
    static let showStatusShadowOffset: CGSize = CGSize(width: 4, height: 4)
    static let showStatusShadowRadius: CGFloat = 4.0
    static let showStatusShadowColor: CGColor = UIColor.black.cgColor
    static let showStatusShadowOpacity: Float = 0.7
    static let showStatusButtonHeight: CGFloat = 50.0
    static let showStatusButtonWidth: CGFloat = 345.0

    
    static let padding: CGFloat = 16
    static let labelPadding: CGFloat = 16
    static let statusLabelPadding: CGFloat = 80

    static let textPadding: CGFloat = 27
    static let showStatusButtonPadding: CGFloat = 10
    static let contentViewHeight: CGFloat = 220
    static let vkIconLoginFormHeightWidth: CGFloat = 100
    static let vkIconLoginFormTop: CGFloat = 120
    static let logInButtonHeight: CGFloat = 50
    static let borderWidth: CGFloat = 0.25
    
    static let photosLabelFont: UIFont = UIFont.systemFont(ofSize: 24, weight: .bold)
    static let photoTableViewConst: CGFloat = 12
    static let photoTableViewArrowImageConst: CGFloat = 40
    static let photoTableViewPreviewImageConst: CGFloat = 16


}
