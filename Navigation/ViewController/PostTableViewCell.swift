import UIKit
import iOSIntPackage
import StorageService


class PostTableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let views: [UIView] = [
            postTitle,
            postImage,
            postDescription,
            postLikes,
            postViews
        ]
        contentView.addSubviews(views)
        setupConstraints()
    }
    
    // MARK: Cell config
    public func configureCell(title: String, image: String, description: String, likes: Int, views: Int) {
        self.postTitle.text = title
        self.postImage.image = UIImage(named: image)
        self.postDescription.text = description
        
        let imageForLike = NSTextAttachment()
        imageForLike.image = UIImage(systemName: "heart")
        let stringForLike = NSMutableAttributedString(string: "")
        stringForLike.append(NSAttributedString(attachment: imageForLike))
        stringForLike.append(NSAttributedString(string: " \(likes)"))

        self.postLikes.attributedText = stringForLike

        let imageForViews = NSTextAttachment()
        imageForViews.image = UIImage(systemName: "eye.circle")
        let stringForViews = NSMutableAttributedString(string: "")
        stringForViews.append(NSAttributedString(attachment: imageForViews))
        stringForViews.append(NSAttributedString(string: " \(views)"))

        self.postViews.attributedText = stringForViews

    }
    
    public func configure(with post: PostData) {
        randomFilterImage(with: post.image)
    }
    
    // MARK: Post title
    private lazy var postTitle: UILabel = {
        let postTitle = UILabel()
        postTitle.toAutoLayout()
        postTitle.numberOfLines = 0
        postTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return postTitle
    }()
    
    // MARK: Post image
    private lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.toAutoLayout()
        postImage.backgroundColor = .black
        postImage.contentMode = .scaleAspectFit
        return postImage
    }()
    
    // MARK: Post description
    private lazy var postDescription: UILabel = {
        let postDescription = UILabel()
        postDescription.toAutoLayout()
        postDescription.font = UIFont.systemFont(ofSize: 14)
        postDescription.textColor = .systemGray
        postDescription.numberOfLines = 0
        postDescription.textAlignment = .justified
        
        return postDescription
    }()
    
    // MARK: Post likes
    private lazy var postLikes: UILabel = {
        let postLikes = UILabel()
        postLikes.toAutoLayout()
        postLikes.font = UIFont.systemFont(ofSize: 16)
        postLikes.textColor = .black
        return postLikes
    }()
    
    // MARK: Post views
    private lazy var postViews: UILabel = {
        let postViews = UILabel()
        postViews.toAutoLayout()
        postLikes.font = UIFont.systemFont(ofSize: 16)
        postLikes.textColor = .black
        return postViews
    }()

    
    // MARK: Constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 16),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostTableViewCell {
    
    private func randomFilterImage(with namedImage: String) {
        let imageProcessor = ImageProcessor()
        
        guard let image = UIImage(named: namedImage) else { return }
        guard let filter = ColorFilter.allCases.randomElement() else { return }
        
        DispatchQueue.main.async {
            imageProcessor.processImage(
                sourceImage: image,
                filter: filter,
                completion: { image in
                    self.postImage.image = image
                }
            )
        }
    }
}

