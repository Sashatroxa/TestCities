//
//  MainCell.swift
//  CitiesTest
//
//  Created by Aleksandr on 04.10.2022.
//

import UIKit
import SkeletonView

final class MainCell: UITableViewCell {
    @IBOutlet weak private var cityImageView: ImageLoader!
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

//MARK: - Open methods
extension MainCell {
    func setImage(_ image: UIImage) {
        self.cityImageView.image = image
    }
    
    func setText(_ text: String) {
        self.cityLabel.text = text
    }
    
    func loadImageFromString(_ string: String) {
        cityImageView.downloadImageFrom(urlString: string)
    }
    
    func isEnableSkeleton(isEnable: Bool) {
        self.cityImageView.isSkeletonable = isEnable
        self.cityLabel.isSkeletonable = isEnable
        
        if isEnable {
            self.cityImageView.showAnimatedSkeleton()
            self.cityLabel.showAnimatedSkeleton()
        } else {
            self.cityImageView.hideSkeleton()
            self.cityLabel.hideSkeleton()
        }
    }
    
    func startAnimateIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func stopAnimateIndicator() {
        self.activityIndicator.stopAnimating()
    }
}

//MARK: - Setup
private extension MainCell {
    func setup() {
        setupUI()
    }
    
    func setupUI() {
        cityImageView.skeletonCornerRadius = 4
        cityImageView.layer.cornerRadius = 4
        
        cityLabel.skeletonCornerRadius = 4
        cityLabel.layer.cornerRadius = 4
        cityLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        self.selectionStyle = .none
    }
}
