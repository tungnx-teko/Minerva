//
//  QRInfoCell.swift
//  Minerva
//
//  Created by Anh Tran on 13/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import SnapKit

typealias InfoItem = (title: String, value: String)

class QRInfoCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.neutral02PrimaryText
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.neutral01TitleText
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
            make.width.equalTo(140)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
        }
    }
    
    func configure(_ info: InfoItem?) {
        titleLabel.text = info?.title
        valueLabel.text = info?.value
    }
}
