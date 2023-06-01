//
//  CartCargoTypeCell.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 19.05.2022.
//

import UIKit

protocol CargoTypeSelected{
    func selected(index: Int)
}

class CargoTypeCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource{
    var delegate: CargoTypeSelected?
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(CargoCell.self, forCellReuseIdentifier: "CargoCell")
        return tb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .none)
        tableView.separatorStyle = .none
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CargoCell") as! CargoCell
        if indexPath.row == 0{
            cell.lb.text = "Normal cargo".localized()
        }else{
            cell.lb.text = "Fast cargo".localized()
        }
        cell.lb.textColor = .black
        cell.selectionStyle = .none
        cell.clicked = {[weak self] in
            self?.clickCell(index: indexPath)
        }
        return cell
    }
    
    func clickCell(index: IndexPath){
        tableView.selectRow(at: index, animated: true, scrollPosition: .none)
        delegate?.selected(index: index.row)
    }
}


class CargoCell: UITableViewCell{
    var vc = UIViewController()
    
    let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return UIImageView()
    }()
    
    let lb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        return lb
    }()
    
    let hiddenBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        return btn
    }()
    
    var clicked: (()->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            checkImageView.layer.cornerRadius = 0
            checkImageView.layer.borderWidth = 0
            checkImageView.image = UIImage(named: "check")
        }else{
            checkImageView.layer.cornerRadius = 15
            checkImageView.layer.borderWidth = 1
            checkImageView.layer.borderColor = UIColor.borderColor.cgColor
            checkImageView.image = nil
        }
    }
    
    private func setupViews(){
        addSubview(checkImageView)
        addSubview(lb)
        contentView.addSubview(hiddenBtn)
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.image = UIImage(named: "check")
        hiddenBtn.addTarget(self, action: #selector(clickCell), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            checkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkImageView.heightAnchor.constraint(equalToConstant: 30),
            checkImageView.widthAnchor.constraint(equalToConstant: 30),
            lb.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor, constant: 16),
            lb.centerYAnchor.constraint(equalTo: checkImageView.centerYAnchor),
            hiddenBtn.leadingAnchor.constraint(equalTo: leadingAnchor),
            hiddenBtn.trailingAnchor.constraint(equalTo: trailingAnchor),
            hiddenBtn.topAnchor.constraint(equalTo: topAnchor),
            hiddenBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        checkImageView.layer.borderColor = UIColor.borderColor.cgColor
        checkImageView.layer.borderWidth = 1
        checkImageView.layer.cornerRadius = 15
    }
    
    @objc func clickCell(){
        clicked?()
    }
}
