import UIKit
import SnapKit

final class DescribeViewController: UIViewController {
    
    //MARK: - Internal properties
    
    var presenter: DescribePresenterProtocol?
    
    //MARK: - Private properties
    
    private let ratingAverage = UILabel()
    private let publishYear   = UILabel()
    
    private let firstSentence: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.isEditable = false
        view.textAlignment = .justified
        return view
    }()
    
    private let bookTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.numberOfLines = 0
        return label
    }()
    
    private let bookImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var rightStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bookTitle, publishYear, ratingAverage])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter?.getData()
    }
    
    //MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(bookImage)
        view.addSubview(rightStack)
        view.addSubview(firstSentence)
        
        bookImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalToSuperview().multipliedBy(0.45)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        rightStack.snp.makeConstraints {
            $0.top.equalTo(bookImage.snp.top)
            $0.left.equalTo(bookImage.snp.right).offset(6)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.lessThanOrEqualTo(bookImage.snp.bottom)
        }
        
        firstSentence.snp.makeConstraints {
            $0.top.equalTo(bookImage.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//MARK: - Extension: DescribeViewProtocol

extension DescribeViewController: DescribeViewProtocol {
    func updateView(with model: Book) {
        bookImage.loadImageFromUrl(path: model.coverI, size: .l)

        let rating = model.ratingsAverage ?? 0
        bookTitle.text = model.title
        publishYear.text = "First publication: " + String(model.firstPublishYear)
        firstSentence.text = model.firstSentence?[0]
        ratingAverage.text = "Average rating: " + String(format: "%.2f", rating)
    }
}
