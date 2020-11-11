//
//  PaymentMethodsViewController.swift
//  Alamofire
//
//  Created by Tung Nguyen on 7/2/20.
//

import UIKit
//import MinervaCore
import SVProgressHUD

class PaymentMethodsViewController: UIViewController, PaymentMethodsViewProtocol {
    
//    private lazy var loading = SpinnerViewController()
    
    let totalContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tổng tiền"
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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PaymentMethodCell.self, forCellReuseIdentifier: "PaymentMethodCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.groupTableViewBackground
        return tableView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var presenter: PaymentMethodsPresenterProtocol?
    
    var appName: String {
        return presenter?.appName ?? MinervaSingleton.DEFAULT_VALUE
    }
    
    var methods: [PaymentMethod] { TerraPayment.instances[appName]?.methods ?? [] }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupNavigation()
        presenter?.viewDidLoad()
    }
    
    func showAmount(_ amount: Double) {
        totalValueLabel.text = amount.toCurrencyString()
    }
    
    func setupNavigation() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationItem.hidesBackButton = true
    }

    @objc
    func cancelWasTapped() {
        parent?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func addSubviews() {
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
        
        view.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: totalContainerView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 8),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension PaymentMethodsViewController {
    
    func showLoading() {
//        addChild(loading)
//        loading.view.frame = view.frame
//        view.addSubview(loading.view)
//        loading.didMove(toParent: self)
        
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func hideLoading() {
//        loading.willMove(toParent: nil)
//        loading.view.removeFromSuperview()
//        loading.removeFromParent()
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
}

extension PaymentMethodsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let method = methods[indexPath.row]
        presenter?.didSelectPaymentMethod(method: method)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}

extension PaymentMethodsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
        cell.configure(withMethod: methods[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
}
