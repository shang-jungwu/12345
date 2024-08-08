//
//  YellowViewController.swift
//  12345
//
//  Created by Sonia Wu on 2024/8/8.
//

import UIKit

class YellowViewController: UIViewController {
    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemYellow

        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    var name: String

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = name
        label.font = .systemFont(ofSize: 24)
        return label
    }()
}
