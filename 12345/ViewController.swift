//
//  ViewController.swift
//  12345
//
//  Created by Sonia Wu on 2024/8/6.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    lazy var infoViewA: InfoView = {
        let view = InfoView()
        view.spacing = 8
        view.verticalMargin = 15
        view.contentLabel.text = "1111111"
        return view
    }()

    lazy var infoViewB: InfoView = {
        let view = InfoView()
        view.spacing = 0
        view.verticalMargin = 0
        view.contentLabel.text = "123456788"
        return view
    }()

    lazy var infoViewC: InfoView = {
        let view = InfoView()
        view.spacing = 0
        view.verticalMargin = 0
        view.contentLabel.text = "132323456783238"
        return view
    }()

    func setupUI() {
        view.addSubview(infoViewA)
        view.addSubview(infoViewB)
        view.addSubview(infoViewC)

        infoViewA.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(100)
        }

        infoViewB.snp.makeConstraints { make in
            make.leading.equalTo(infoViewA.snp.trailing).offset(10)
            make.top.equalTo(infoViewA)
            make.width.equalTo(100)
            make.height.equalTo(45)
        }

        infoViewC.snp.makeConstraints { make in
            make.leading.equalTo(infoViewB)
            make.top.equalTo(infoViewB.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
    }
}

extension ViewController {
    class InfoView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        var spacing: CGFloat = 0.0 {
            didSet {
                stack.spacing = spacing
            }
        }

        var verticalMargin: CGFloat? {
            didSet {
                stack.snp.remakeConstraints { make in
                    if let verticalMargin {
                        make.top.bottom.equalToSuperview().inset(verticalMargin)
                    } else {
                        make.centerY.equalToSuperview()
                    }
                    make.leading.trailing.equalToSuperview().inset(4)
                }
            }
        }

        lazy var stack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [titleLabel, contentLabel])
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.alignment = .center
            stack.spacing = spacing
            stack.layer.borderWidth = 1
            stack.layer.borderColor = UIColor.black.cgColor
            return stack
        }()

        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "標題"
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textAlignment = .center
            label.backgroundColor = .systemYellow
            return label
        }()

        lazy var contentLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = .systemOrange
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            label.numberOfLines = 0
            return label
        }()

        func setupUI() {
            backgroundColor = .systemCyan

            addSubview(stack)
            stack.snp.makeConstraints { make in
                if let verticalMargin {
                    make.top.bottom.equalToSuperview().inset(verticalMargin)
                } else {
                    make.centerY.equalToSuperview()
                }
                make.leading.trailing.equalToSuperview().inset(4)
            }

            contentLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.8)
            }
        }
    }
}
