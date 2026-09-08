import UIKit

final class PhotoTableViewCell: UITableViewCell {
    static let identifier = "PhotoTableViewCell"
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var imageTask: URLSessionDataTask?
    private var dynamicAspectConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        photoImageView.image = nil
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(photoImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(sizeLabel)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            authorLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            sizeLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 2),
            sizeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            sizeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            sizeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with photo: Photo) {
        authorLabel.text = photo.author
        sizeLabel.text = "Size: \(photo.width)×\(photo.height)"
        
        // Tự động tính toán khung ảnh dựa theo tỉ lệ gốc -> Không bị móp/biến dạng ảnh
        dynamicAspectConstraint?.isActive = false
        dynamicAspectConstraint = photoImageView.heightAnchor.constraint(
            equalTo: photoImageView.widthAnchor,
            multiplier: photo.aspectRatioMultiplier
        )
        dynamicAspectConstraint?.isActive = true
        
        imageTask = ImageLoader.shared.loadImage(from: photo.downloadUrl) { [weak self] image in
            self?.photoImageView.image = image
        }
    }
}