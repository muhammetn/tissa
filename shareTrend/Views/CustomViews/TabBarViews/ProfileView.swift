//
//  ProfileView.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 10.05.2022.
//

import UIKit

class ProfileView: UIView {
    let tableView: UITableView = {
        let tb = UITableView()
        tb.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(tableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
