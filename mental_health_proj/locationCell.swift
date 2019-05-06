//
//  locationCell.swift
//  mental_health_proj
//
//  Created by Jiehong Lin on 4/25/19.
//  Copyright © 2019 Mitchell Lin. All rights reserved.
//

import UIKit

class locationCell: UITableViewCell {
    
    var name: UILabel!
    var locationImage: UIImageView!
    var locationLabel: UILabel!
    
    let labelHeight: CGFloat = 20
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        locationImage = UIImageView(image: UIImage(named:"yeet"))
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        locationImage.contentMode = .scaleToFill
        locationImage.layer.cornerRadius = 20
        locationImage.clipsToBounds = true
        contentView.addSubview(locationImage)
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 18)
        name.font = UIFont.boldSystemFont(ofSize: name.font.pointSize)
        contentView.addSubview(name)
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(locationLabel)
        
        
        
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {

        NSLayoutConstraint.activate([
            locationImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            locationImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            locationImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            locationImage.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 128)
            ])
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            name.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 8),
            name.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 2),
            locationLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure (for locate: Location){
        name.text = locate.name
        locationImage.image = UIImage(named: locate.image)
        locationLabel.text = locate.address
    }
}
