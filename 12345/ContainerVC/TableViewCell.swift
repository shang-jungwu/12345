//
//  TableViewCell.swift
//  12345
//
//  Created by Sonia Wu on 2024/8/8.
//

import UIKit

class TableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(20)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        return label
    }()
}
