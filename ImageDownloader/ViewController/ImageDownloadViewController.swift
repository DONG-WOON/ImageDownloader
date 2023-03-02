//
//  ImageDownloadViewController.swift
//  ImageDownloader
//
//  Created by 서동운 on 2/22/23.
//

import UIKit
import SnapKit

class ImageDownloadViewController: UIViewController {
    
    // MARK: - Properties
    
    private let imageDownloader = ImageDownloader(session: URLSession.shared)
    private let urls: [String] = URL.data
    
    private let imageDownloadTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(ImageLoadCell.self, forCellReuseIdentifier: ImageLoadCell.reuseIdentifier)
        tableView.register(AllImagesLoadCell.self, forCellReuseIdentifier: AllImagesLoadCell.reuseIdentifier)
        
        return tableView
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        imageDownloadTableView.dataSource = self
        imageDownloadTableView.delegate = self
        
        configureViews()
        setConstraints()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    
    func downloadImage(url: String, completion: @escaping (UIImage) -> Void) {
        imageDownloader.downloadImage(stringURL: url) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Configure
    
    private func configureViews() {
        view.addSubview(imageDownloadTableView)
    }
    
    // MARK: - Setting Constraints
    
    private func setConstraints() {
        imageDownloadTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDataSource

extension ImageDownloadViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return urls.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageLoadCell.reuseIdentifier, for: indexPath) as? ImageLoadCell else { return ImageLoadCell() }
            
            cell.loadButtonAction = { [self] in
                downloadImage(url: urls[indexPath.row]) { image in
                    DispatchQueue.main.async {
                        cell.configure(image: image)
                    }
                }
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AllImagesLoadCell.reuseIdentifier, for: indexPath) as? AllImagesLoadCell else { return AllImagesLoadCell() }
            
            cell.allImagesLoadButtonAction = {
                NotificationCenter.default.post(name: .allImagesLoad, object: nil)
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ImageDownloadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 60
        default:
            return 0
        }
    }
}

