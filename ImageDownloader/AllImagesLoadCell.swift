//
//  AllImageLoadCell.swift
//  ImageDownloader
//
//  Created by 서동운 on 3/2/23.
//

import UIKit

class AllImagesLoadCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "AllImageLoadCell"
    
    var allImagesLoadButtonAction: () -> Void = {}
    
    private let allImagesLoadButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Load All Images"
        return UIButton(configuration: configuration)
    }()
    
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        allImagesLoadButton.addTarget(self, action: #selector(allImageLoadButtonDidTapped), for: .touchUpInside)
        
        configureViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func allImageLoadButtonDidTapped() {
        allImagesLoadButtonAction()
    }
    
    // MARK: - Configure
    
    private func configureViews() {
        contentView.addSubview(allImagesLoadButton)
    }
    
    // MARK: - Setting Constraints
    
    private func setConstraints() {
        allImagesLoadButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(30)
        }
    }
}
