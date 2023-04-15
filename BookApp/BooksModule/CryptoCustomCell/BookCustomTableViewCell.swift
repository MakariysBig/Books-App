import UIKit
import SnapKit

final class BookCustomTableViewCell: UITableViewCell {
    
    //MARK: - Cell identifier
    
    static let identifier = "BookCustomTableViewCell"
    
    //MARK: - Properties
    
    private let bookImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let bookName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let publishYear: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bookName, publishYear])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    //MARK: - Initialise
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookName.text    = nil
        bookImage.image  = nil
        publishYear.text = nil
    }
    
    //MARK: - Update cell
    
    func updateCell(model: Book) {
        bookImage.loadImageFromUrl(path: model.coverI, size: .m)
        bookName.text = model.title
        publishYear.text = "First publication: " + String(model.firstPublishYear)
    }
    
    //MARK: - Add subviews
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle  = .blue
        contentView.addSubview(bookImage)
        contentView.addSubview(mainStackView)
        updateConstraintsIfNeeded()
    }
    
    //MARK: - Set constrains
    
    override func updateConstraints() {
        super.updateConstraints()
        
        bookImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.left.equalToSuperview().offset(14)
            $0.width.equalTo(80)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(bookImage.snp.right).offset(14)
            $0.right.lessThanOrEqualTo(self.snp.right).inset(10)
            $0.bottom.lessThanOrEqualToSuperview().inset(10)
        }
    }
}
