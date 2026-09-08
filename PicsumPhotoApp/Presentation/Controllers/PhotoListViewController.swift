import UIKit

final class PhotoListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let refreshControl = UIRefreshControl()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    private var photos: [Photo] = []
    private var filteredPhotos: [Photo] = []
    
    private var currentPage = 1
    private var isFetching = false
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData(page: 1, isRefresh: false)
    }
    
    private func setupUI() {
        title = "Photos"
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        searchBar.placeholder = "Search author or ID..."
        navigationItem.titleView = searchBar
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
        // Dynamic Height theo Autolayout
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        // Pull to Refresh
        refreshControl.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        // Footer Indicator
        loadingIndicator.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44)
        tableView.tableFooterView = loadingIndicator
        
        view.addSubview(tableView)
    }
    
    @objc private func onPullToRefresh() {
        currentPage = 1
        fetchData(page: 1, isRefresh: true)
    }
    
    private func fetchData(page: Int, isRefresh: Bool) {
        guard !isFetching else { return }
        isFetching = true
        
        if !isRefresh && page > 1 {
            loadingIndicator.startAnimating()
        }
        
        guard let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=100") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            defer {
                DispatchQueue.main.async {
                    self.isFetching = false
                    self.refreshControl.endRefreshing()
                    self.loadingIndicator.stopAnimating()
                }
            }
            
            guard let data = data, error == nil else { return }
            
            do {
                let dtos = try JSONDecoder().decode([PhotoDTO].self, from: data)
                let newItems = dtos.map { $0.toDomain() }
                
                DispatchQueue.main.async {
                    if isRefresh {
                        self.photos = newItems
                    } else {
                        self.photos.append(contentsOf: newItems)
                    }
                    self.applySearchFilter(query: self.searchBar.text ?? "")
                }
            } catch {
                print("Decode error: \(error)")
            }
        }.resume()
    }
    
    private func applySearchFilter(query: String) {
        let cleanQuery = SearchQueryValidator.sanitize(input: query)
        
        if cleanQuery.isEmpty {
            isSearching = false
            filteredPhotos = photos
        } else {
            isSearching = true
            let lower = cleanQuery.lowercased()
            filteredPhotos = photos.filter {
                $0.author.lowercased().contains(lower) || $0.id.contains(lower)
            }
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & Delegate
extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredPhotos.count : photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        let photo = isSearching ? filteredPhotos[indexPath.row] : photos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
    
    // Paging (Load More)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isFetching, !isSearching else { return }
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > (contentHeight - frameHeight - 200) {
            currentPage += 1
            fetchData(page: currentPage, isRefresh: false)
        }
    }
}

// MARK: - UISearchBarDelegate (Validation + Swipe Typing & Paste)
extension PhotoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let validatedText = SearchQueryValidator.sanitize(input: searchText)
        
        // Nếu chứa ký tự lỗi (do paste/swipe typing/tiếng Việt), gán lại text đã lọc sạch cho SearchBar
        if validatedText != searchText {
            searchBar.text = validatedText
        }
        
        applySearchFilter(query: validatedText)
    }
}