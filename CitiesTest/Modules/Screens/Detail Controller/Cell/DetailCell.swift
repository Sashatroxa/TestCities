//
//  DetailCell.swift
//  CitiesTest
//
//  Created by Aleksandr on 06.10.2022.
//

import UIKit

final class DetailCell: UITableViewCell {
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

//MARK: - Open methods
extension DetailCell {
    func setText(_ text: String) {
        self.descriptionLabel.text = text
    }
}

//MARK: - Setup
private extension DetailCell {
    func setup() {
        setupUI()
    }
    
    func setupUI() {
        descriptionLabel.font = .systemFont(ofSize: 17)
    }
}
