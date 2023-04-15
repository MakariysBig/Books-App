import UIKit

final class BookViewController: UIViewController {
    
    //MARK: - Internal properties
    
    var presenter: BookPresenterProtocol?
    
    //MARK: - Private properties
        
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.register(BookCustomTableViewCell.self, forCellReuseIdentifier: BookCustomTableViewCell.identifier)
        view.rowHeight = 120
        view.tableHeaderView = UIView()
        return view
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.isHidden = true
        spinner.color = .label
        return spinner
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.down")
        button.setTitle("Sort", for: .normal)
        button.setImage(image, for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setup()
    }
    
    //MARK: - Private methods
    
    private func setup() {
        title = "Books"
        configureNavBar()
        setupDelegate()
        startSpinner()
        presenter?.getData()
    }
    
    private func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sortButton)
        sortButton.addTarget(self, action: #selector(sortData), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func startSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    private func stopSpinner() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    //MARK: - Setup layout
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.addSubview(spinner)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        spinner.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(40)
        }
    }
    
    //MARK: - Actions
    
    @objc private func sortData() {
        presenter?.sortData()
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getArrayCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCustomTableViewCell.identifier, for: indexPath) as? BookCustomTableViewCell else { return UITableViewCell() }
        let model = presenter?.getModel(with: indexPath.row)
        
        if let model = model  {
            cell.updateCell(model: model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = presenter?.getModel(with: indexPath.row)
        if let model = model  {
            presenter?.showDetailModule(model: model)
        }
    }
}

// MARK: - Extension: BookViewProtocol

extension BookViewController: BookViewProtocol {
    func updateButtonImage(with state: SortState) {
        if state == .up {
            sortButton.setImage( UIImage(systemName: "arrow.down"), for: .normal)
        } else {
            sortButton.setImage( UIImage(systemName: "arrow.up"), for: .normal)
        }
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actionCopy = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(actionCopy)
            self.present(alert, animated: true, completion: nil)
            self.stopSpinner()
        }
    }
    
    func updateView() {
        self.stopSpinner()
        self.tableView.reloadData()
    }
    
    func networkError(with error: String) {
        self.stopSpinner()
        self.showAlert(title: "We have a problem", message: error)
    }
}
