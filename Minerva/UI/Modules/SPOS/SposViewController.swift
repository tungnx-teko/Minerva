//
//  SposViewController.swift
//  Pods
//
//  Created by Tung Nguyen on 7/6/20.
//

import UIKit

class SposViewController: UIViewController, SposViewProtocol {
    
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(red: 235, green: 31, blue: 58)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let spinner = UIActivityIndicatorView(style: .white)
    
    let waitingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.text = Minerva.Strings.sposWaitingResult
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let transactionCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var presenter: SposPresenterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = Minerva.Strings.paymentSPOSMethod
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = Minerva.Strings.paymentSPOSMethod
        addSubviews()
        presenter?.viewDidLoad()
        spinner.startAnimating()
    }
    
}

// MARK: - Add subviews
extension SposViewController {
    
    func addSubviews() {
        addTotalView()
        addSeparatorView()
        addSpinner()
        addWaitingLabel()
        addTransactionCodeLabel()
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
    
    private func addSpinner() {
        spinner.color = .black
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func addWaitingLabel() {
        view.addSubview(waitingLabel)
        
        NSLayoutConstraint.activate([
            waitingLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 16),
            waitingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            waitingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    private func addTransactionCodeLabel() {
        view.addSubview(transactionCodeLabel)
        
        NSLayoutConstraint.activate([
            transactionCodeLabel.topAnchor.constraint(equalTo: waitingLabel.bottomAnchor, constant: 8),
            transactionCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            transactionCodeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    func showAmount(_ amount: Double) {
        totalValueLabel.text = amount.toCurrencyString()
    }
    
    func showTransactionCode(_ code: String) {
        let attributedText = NSMutableAttributedString()
        let grayStyle: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 14)]
        attributedText.append(NSAttributedString(string: Minerva.Strings.transactionCodeTitle, attributes: grayStyle))
        let defaultStyle: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 14)]
        attributedText.append(NSAttributedString(string: "#" + code, attributes: defaultStyle))
        transactionCodeLabel.attributedText = attributedText
    }

}
