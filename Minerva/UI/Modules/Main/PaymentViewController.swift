//
//  PaymentViewController.swift
//  Pods
//
//  Created by Tung Nguyen on 6/29/20.
//

import UIKit
//import MinervaCore
import SnapKit
import SVProgressHUD

public class PaymentViewController: UIViewController, PaymentViewProtocol {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = Minerva.Theme.primaryColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(Minerva.Images.backButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.imageEdgeInsets = .zero
        button.addTarget(self, action: #selector(backButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Minerva.Strings.cancelButtonTitle, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelWasTapped), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Minerva.Strings.paymentMethodsTitle
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var childNav: PaymentNavigationController!
    
    var presenter: PaymentPresenterProtocol?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        setupStatusBar()
        addSubviews()
        addChildNavigation()
        reloadBackButton()
    }
    
    func setupStatusBar() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = Minerva.Theme.primaryColor
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    @objc
    func cancelWasTapped() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
        presenter?.handleCancel()
    }
    
    @objc
    func backButtonWasTapped() {
        if childNav?.canGoBack ?? false {
            _ = childNav?.popViewController(animated: true)
        }
    }
    
    func reloadBackButton() {
//        backButton.isHidden = !childNav.canGoBack
        backButton.isHidden = true
    }
    
    func addChildNavigation() {
        guard let request = presenter?.request else { return }
        let methodsVC = PaymentMethodsRouter.createModule(request: request)
        let nav = PaymentNavigationController(rootViewController: methodsVC)
        nav.navDelegate = self
        addChild(nav)
        nav.view.frame = containerView.bounds
        containerView.addSubview(nav.view)
        self.childNav = nav
    }
    
    func addSubviews() {
        addNavigationView()
        addContainerView()
    }
    
    private func addNavigationView() {
        view.addSubview(navigationView)
        
        navigationView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.height.equalTo(Minerva.Theme.navigationViewHeight)
            
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(view)
            }
        }
        
        addBackButton()
        addCancelButton()
        addTitleLabel()
    }
    
    private func addContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func addBackButton() {
        navigationView.addSubview(backButton)
        
        backButton.imageEdgeInsets = UIEdgeInsets.init(top: 4, left: 8, bottom: 4, right: 12)
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(navigationView).offset(8)
            make.centerY.equalTo(navigationView)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    func addCancelButton() {
        navigationView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: -16),
            cancelButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func addTitleLabel() {
        navigationView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
        ])
    }
    
}

extension PaymentViewController: PaymentNavigationDelegate {
    
    func didShowViewController(_ vc: UIViewController) {
        titleLabel.text = vc.title
        reloadBackButton()
    }
    
    func didPop() {
        if childNav?.canGoBack ?? false {
            titleLabel.text = childNav?.viewControllers.last?.title
        } else {
            titleLabel.text = Minerva.Strings.paymentMethodsTitle
        }
        reloadBackButton()
    }
    
}

extension PaymentViewController: PaymentMethodDelegate {
    
    func onResult(_ result: PaymentResult) {
        presenter?.onResult(result)
    }
    
}
