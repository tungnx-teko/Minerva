//
//  ScanOverlayView.swift
//  Minerva
//
//  Created by Anh Tran on 11/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import SnapKit

class ScanOverlayView: UIView {

    let transparentHoleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "Di chuyển Camera đến vùng chứa mã QR, tiến trình quét mã sẽ diễn ra tự động"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configTransparentHoleView(rect)
    }
}

extension ScanOverlayView {
    
    private func setupViews() {
        addSubview(transparentHoleView)
        addSubview(guideLabel)
        
        transparentHoleView.snp.makeConstraints { maker in
            maker.centerY.equalTo(self).offset(-48)
            maker.leading.equalTo(self.snp.leading).offset(48)
            maker.trailing.equalTo(self.snp.trailing).offset(-48)
            maker.width.equalTo(transparentHoleView.snp.height).multipliedBy(1)
        }
        
        guideLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(transparentHoleView)
            maker.top.equalTo(transparentHoleView.snp.bottom).offset(16)
        }
    }
    
    private func configTransparentHoleView(_ rect: CGRect) {
        backgroundColor?.setFill()
        UIRectFill(rect)
        let layer = CAShapeLayer()
        let path = CGMutablePath()
        path.addRect(transparentHoleView.frame)
        path.addRect(bounds)
        
        layer.path = path
        layer.fillRule = .evenOdd
        self.layer.mask = layer
    }
}
