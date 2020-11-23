//
//  ResultViewController.swift
//  Pods
//
//  Created by Tung Nguyen on 7/4/20.
//

import UIKit

class ResultViewController: UIViewController, ResultViewProtocol {
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Minerva.Strings.closeButtonTitle, for: .normal)
        button.backgroundColor = Minerva.Theme.primaryColor
        button.cornerRadius = 8
        button.addTarget(self, action: #selector(closeButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    var presenter: ResultPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setupNavigationView()
        presenter?.viewDidLoad()
    }
    
    func setupNavigationView() {
        guard let paymentVC = navigationController?.parent as? PaymentViewController else { return }
        paymentVC.titleLabel.text = Minerva.Strings.resultTitle
        paymentVC.cancelButton.isHidden = true
        paymentVC.backButton.isHidden = true
    }
    
    @objc
    func closeButtonWasTapped() {
        presenter?.handleClose()
    }
    
    func showResult(_ result: PaymentResult) {
        switch result {
        case .success(let transaction):
            iconImage.image = ImagesHelper.imageFor(name: "success")
            resultLabel.text = Minerva.Strings.paymentSuccessTitle
            let attributedText = NSMutableAttributedString()
            let grayStyle: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 14)]
            attributedText.append(NSAttributedString(string: Minerva.Strings.transactionCodeTitle, attributes: grayStyle))
            let defaultStyle: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 14)]
            attributedText.append(NSAttributedString(string: "#" + (transaction.transactionCode ?? ""), attributes: defaultStyle))
            detailLabel.attributedText = attributedText
        case .failure:
            iconImage.image = ImagesHelper.imageFor(name: "fail")
            resultLabel.text = Minerva.Strings.paymentFailureTitle
        }
    }
    
}

// MARK: - Add subviews
extension ResultViewController {
    
    private func addSubviews() {
        addIconImage()
        addCloseButton()
        addResultLabel()
        addDetailLabel()
    }
    
    private func addIconImage() {
        view.addSubview(iconImage)
        
        NSLayoutConstraint.activate([
            iconImage.widthAnchor.constraint(equalToConstant: 128.0),
            iconImage.heightAnchor.constraint(equalToConstant: 128.0),
            iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -48),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func addCloseButton() {
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 48.0),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }
    
    private func addResultLabel() {
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 24),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func addDetailLabel() {
        view.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 8),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
}

