//
//  QRScanViewController.swift
//  Minerva
//
//  Created Anh Tran on 11/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import SnapKit

public class QRScanViewController: UIViewController, QRScanViewProtocol {

    let overlayView: UIView = {
        let view = ScanOverlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.overlay
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(ImagesHelper.assestFor(name: "ic_close_white"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let flashButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(ImagesHelper.assestFor(name: "ic_flash"), for: .normal)
        button.addTarget(self, action: #selector(flashButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let markImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = ImagesHelper.imageFor(name: "scan_mark")
        return imgView
    }()
    
	var presenter: QRScanPresenterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.startScanQR()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.stopScanQR()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter?.qrReader.previewLayer.frame = view.bounds
    }
}

extension QRScanViewController {
    
    private func addSubviews() {
        view.addSubview(overlayView)
        view.addSubview(backButton)
        view.addSubview(flashButton)
        view.addSubview(markImgView)
        
        if let scanLayer = presenter?.qrReader.previewLayer {
            view.layer.insertSublayer(scanLayer, at: 0)
        }
        
        overlayView.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
        
        backButton.snp.makeConstraints { maker in
            maker.width.height.equalTo(40)
            maker.top.equalTo(view.safeArea.top).offset(16)
            maker.leading.equalTo(view.safeArea.leading).offset(16)
        }
        
        flashButton.snp.makeConstraints { maker in
            maker.width.height.equalTo(40)
            maker.top.equalTo(view.safeArea.top).offset(16)
            maker.trailing.equalTo(view.safeArea.trailing).offset(-16)
        }
        
        markImgView.snp.makeConstraints { maker in
            maker.centerY.equalTo(view).offset(-48)
            maker.leading.equalTo(view.snp.leading).offset(48)
            maker.trailing.equalTo(view.snp.trailing).offset(-48)
            maker.width.equalTo(markImgView.snp.height).multipliedBy(1)
        }
    }
    
    @objc func backButtonTapped() {
        presenter?.goBack()
    }
    
    @objc func flashButtonTapped() {
        presenter?.toogleTorch()
    }
}
