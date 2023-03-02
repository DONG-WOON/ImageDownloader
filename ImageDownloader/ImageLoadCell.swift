//
//  ImageLoadCell.swift
//  ImageDownloader
//
//  Created by 서동운 on 3/2/23.
//

import UIKit
import SnapKit


class ImageLoadCell: UITableViewCell {
    // MARK: - Properties
    
    static let reuseIdentifier = "ImageLoadCell"
    
    var loadButtonAction: () -> Void = {}
    
    private let loadedImageView = UIImageView(image: UIImage(systemName: "photo"))
    private let progressView = UIProgressView()
    private let loadButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Load"
        return UIButton(configuration: configuration)
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadButton.addTarget(self, action: #selector(loadButtonDidTapped), for: .touchUpInside)
        self.selectionStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadButtonDidTapped), name: .allImagesLoad, object: nil)
        
        configureViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    
    @objc private func loadButtonDidTapped() {
        loadButtonAction()
    }
    
    func configure(image: UIImage) {
        loadedImageView.image = image
    }
    

    // MARK: - Configure
    
    private func configureViews() {
        contentView.addSubview(loadedImageView)
        contentView.addSubview(progressView)
        contentView.addSubview(loadButton)
    }
    
    // MARK: - Setting Constraints
    
    private func setConstraints() {
        loadedImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.width.equalTo(loadedImageView.snp.height).multipliedBy(1.2)
        }
        progressView.snp.makeConstraints { make in
            make.leading.equalTo(loadedImageView.snp.trailing).offset(30)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        loadButton.snp.makeConstraints { make in
            make.leading.equalTo(progressView.snp.trailing).offset(30)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
