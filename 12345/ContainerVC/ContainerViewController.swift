//
//  ContainerViewController.swift
//  12345
//
//  Created by Sonia Wu on 2024/8/8.
//

import UIKit

class ContainerViewController: UIViewController {
    init(person: Person, data: [Person]) {
        self.person = person
        self.data = data

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = titleView
        removePreviousVCAndAddChildVC()
    }

    private func removePreviousVCAndAddChildVC() {
        if let childVC {
            removeChildViewController(childVC: childVC)
            self.childVC = nil
        }

        let vc = getChildVC(fruit: data[currentIndex].fruit)
        childVC = vc
        addChildViewController(child: vc, toParentView: view, toParentViewController: self)
    }

    private func addChildViewController(child: UIViewController, toParentView: UIView, toParentViewController: UIViewController) {
        toParentViewController.addChild(child)
        toParentView.addSubview(child.view)
        child.view.snp.makeConstraints { make in
            make.top.equalTo(toParentView.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }

        child.didMove(toParent: toParentViewController)
    }

    private func removeChildViewController(childVC: UIViewController) {
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }

    func getChildVC(fruit: Fruit) -> UIViewController {
        switch fruit {
        case .orange:
            return OrangeViewController(name: person.name)
        case .banana:
            return YellowViewController(name: person.name)
        }
    }

    func showPreviousPerson() {
        let index = currentIndex - 1
        guard data.indices.contains(index) else {
            print("index out of bounds")
            return
        }

        person = data[index]

        removePreviousVCAndAddChildVC()

        titleView.titleLabel.text = data[index].name
    }

    func showNextPerson() {
        let index = currentIndex + 1
        guard data.indices.contains(index) else {
            print("index out of bounds")
            return
        }

        person = data[index]

        removePreviousVCAndAddChildVC()

        titleView.titleLabel.text = data[index].name
    }

    var person: Person

    var data: [Person]

    var currentIndex: Int {
        return data.firstIndex {
            $0.name == person.name
        } ?? 0
    }

    private var childVC: UIViewController?

    lazy var titleView: NavTitleView = {
        let view = NavTitleView()

        view.titleLabel.text = person.name

        view.nButtonClicked = { [weak self] in
            guard let self = self else { return }
            showNextPerson()
        }
        view.pButtonClicked = { [weak self] in
            guard let self = self else { return }
            showPreviousPerson()
        }

        return view
    }()
}

extension ContainerViewController {
    class NavTitleView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)

            snp.makeConstraints { make in
                make.width.greaterThanOrEqualTo(150)
                make.height.equalTo(44)
            }

            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
                make.height.equalTo(44)
            }

            addSubview(previousbutton)
            previousbutton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.height.equalTo(44)
                make.leading.equalToSuperview()
            }

            addSubview(nextbutton)
            nextbutton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.height.equalTo(44)
                make.trailing.equalToSuperview()
            }
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 24)
            label.sizeToFit()
            return label
        }()

        lazy var previousbutton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("<<<", for: .normal)
            button.addTarget(self, action: #selector(pButtonDidClick), for: .touchUpInside)
            return button
        }()

        @objc func pButtonDidClick() {
            pButtonClicked?()
        }

        var pButtonClicked: (() -> Void)?

        lazy var nextbutton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle(">>>", for: .normal)
            button.addTarget(self, action: #selector(nButtonDidClick), for: .touchUpInside)
            return button
        }()

        @objc func nButtonDidClick() {
            nButtonClicked?()
        }

        var nButtonClicked: (() -> Void)?
    }
}
