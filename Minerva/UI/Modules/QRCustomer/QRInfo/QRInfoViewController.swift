//
//  QRInfoViewController.swift
//  Minerva
//
//  Created Anh Tran on 13/11/2020.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit

class QRInfoViewController: UIViewController, QRInfoViewProtocol {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isEmptyRowsHidden = true
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        tableView.register(QRInfoCell.self, forCellReuseIdentifier: "QRInfoCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.cornerRadius = 5
        button.setTitle(Minerva.Strings.continueButtonTitle, for: .normal)
        button.setBackgroundImage(UIImage(color: UIColor.secondaryDefault), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(ImagesHelper.assestFor(name: "ic_flash"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

	var presenter: QRInfoPresenterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = Minerva.Strings.paymentInfoTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
    }
    
    @objc func backButtonTapped() {
        presenter?.goBack()
    }
}

extension QRInfoViewController {
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(continueButton)
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        continueButton.snp.makeConstraints { maker in
            maker.leading.equalTo(view.safeArea.leading).offset(16)
            maker.trailing.equalTo(view.safeArea.trailing).offset(-16)
            maker.bottom.equalTo(view.safeArea.bottom).offset(-16)
            maker.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.leading.equalTo(view.safeArea.leading).offset(0)
            maker.top.equalTo(view.safeArea.top).offset(0)
            maker.trailing.equalTo(view.safeArea.trailing).offset(0)
            maker.bottom.equalTo(continueButton.snp.bottom).offset(16)
        }
    }
}

extension QRInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

extension QRInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.infoItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(QRInfoCell.self, idxPath: indexPath)!
        let item = presenter?.infoItems[indexPath.row]
        cell.configure(item)
        return cell
    }
}
