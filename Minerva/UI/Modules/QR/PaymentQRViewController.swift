//
//  PaymentQRViewController.swift
//  Pods
//
//  Created by Tung Nguyen on 7/2/20.
//

import UIKit
//import MinervaCore

class PaymentQRViewController: UIViewController, PaymentQRViewProtocol {
    
    let totalContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Minerva.Strings.totalMoneyTitle
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0 đ"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(red: 235, green: 31, blue: 58)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let qrFrameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImagesHelper.imageFor(name: "qr_frame")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247, green: 130, blue: 18)
        view.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let expireLabel: UILabel = {
        let label = UILabel()
        label.text = "Hết hạn sau"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var presenter: PaymentQRPresenterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "VNPayQR"
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        guard let qrContent = (presenter?.transaction)?.qrContent else { return }
        qrImageView.image = ImagesHelper.generateQRCode(from: qrContent)
    }

}

// MARK: - Add subviews
extension PaymentQRViewController {
    
    func addSubviews() {
        addTotalView()
        addSeparatorView()
        addQRFrameView()
        addQRImageView()
        addTimerView()
    }
    
    private func addTotalView() {
        view.addSubview(totalContainerView)
        
        NSLayoutConstraint.activate([
            totalContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            totalContainerView.heightAnchor.constraint(equalToConstant: 64),
            totalContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        totalContainerView.addSubview(totalTitleLabel)
        totalContainerView.addSubview(totalValueLabel)
        
        NSLayoutConstraint.activate([
            totalTitleLabel.centerYAnchor.constraint(equalTo: totalContainerView.centerYAnchor),
            totalTitleLabel.leadingAnchor.constraint(equalTo: totalContainerView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            totalValueLabel.centerYAnchor.constraint(equalTo: totalContainerView.centerYAnchor),
            totalValueLabel.trailingAnchor.constraint(equalTo: totalContainerView.trailingAnchor, constant: -16)
        ])
    }
    
    private func addSeparatorView() {
        view.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: totalContainerView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 8),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func addQRFrameView() {
        view.addSubview(qrFrameImageView)
        NSLayoutConstraint.activate([
            qrFrameImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            qrFrameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            qrFrameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            qrFrameImageView.heightAnchor.constraint(equalTo: qrFrameImageView.widthAnchor)
        ])
    }
    
    private func addQRImageView() {
        view.addSubview(qrImageView)
        NSLayoutConstraint.activate([
            qrImageView.widthAnchor.constraint(equalTo: qrFrameImageView.widthAnchor, constant: -64),
            qrImageView.heightAnchor.constraint(equalTo: qrImageView.widthAnchor),
            qrImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func addTimerView() {
        view.addSubview(timerView)
        
        
        NSLayoutConstraint.activate([
            timerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            timerView.heightAnchor.constraint(equalToConstant: 48),
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
        ])
        
        timerView.addSubview(expireLabel)
        NSLayoutConstraint.activate([
            expireLabel.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            expireLabel.leadingAnchor.constraint(equalTo: timerView.leadingAnchor, constant: 16)
        ])
        
        timerView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: timerView.trailingAnchor, constant: -16)
        ])
    }
    
    func showTime(interval: Int) {
        timeLabel.text = String.init(format: "%02d:%02d", interval / 60, interval % 60)
    }
    
    func showAmount(amount: Double) {
        totalValueLabel.text = amount.toCurrencyString()
    }
    
}
