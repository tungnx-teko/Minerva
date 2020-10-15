//
//  PaymentMethodCell.swift
//  Pods
//
//  Created by Tung Nguyen on 6/29/20.
//

import UIKit
//import MinervaCore

class PaymentMethodCell: UITableViewCell {
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var arrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = ImagesHelper.imageFor(name: "arrow")
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(arrowView)
        contentView.addSubview(separatorView)
        
        // Icon image constraints
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            iconImageView.widthAnchor.constraint(equalToConstant: 48.0),
            iconImageView.heightAnchor.constraint(equalToConstant: 48.0),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        // Name label constraints
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16.0),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -16.0),
        ])
        
        // Arrow view constraints
        NSLayoutConstraint.activate([
            arrowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            arrowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowView.heightAnchor.constraint(equalToConstant: 24.0),
            arrowView.widthAnchor.constraint(equalToConstant: 24.0),
        ])
        
        // Separator view constraints
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(withMethod paymentMethod: PaymentMethod) {
        switch paymentMethod {
        case is SPOSMethod:
            iconImageView.image = Minerva.Images.sposIcon
            nameLabel.text = Minerva.Strings.paymentSPOSMethod
        case is CTTMethod:
            iconImageView.image = Minerva.Images.qrIcon
            nameLabel.text = Minerva.Strings.paymentQRMethod
        case is ATMMethod:
            iconImageView.image = Minerva.Images.cardIcon
            nameLabel.text = Minerva.Strings.paymentCTTMethod
        default:
            break
        }
    }
    
}
