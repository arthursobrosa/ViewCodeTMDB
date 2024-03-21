import UIKit

protocol MoviesViewProtocol {
    func didSelect(indexPath: IndexPath)
}

class MoviesView: UIView {
    var delegate: MoviesViewProtocol?
    private var content: MoviesViewController.ViewContent?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 150
        table.dataSource = self
        table.delegate = self
        table.register(MovieCell.self, forCellReuseIdentifier: "movieCell")
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviewsAndLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(content: MoviesViewController.ViewContent) {
        self.content = content
        
        reloadTable()
    }
}

// MARK: - Private functions
extension MoviesView {
    private func addSubviewsAndLayout() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table View Data Source
extension MoviesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return content?.sectionType.title ?? String()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieCell else { fatalError() }

        cell.content = content?.items[indexPath.row]

        return cell
    }
}

// MARK: - Table View Delegate
extension MoviesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(indexPath: indexPath)
    }
}
