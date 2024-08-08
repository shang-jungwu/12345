//
//  TableViewController.swift
//  12345
//
//  Created by Sonia Wu on 2024/8/8.
//

import UIKit

enum Fruit {
    case orange
    case banana
}

struct Person {
    let name: String
    let fruit: Fruit
}

class TableViewController: UIViewController {
    let data: [Person] = [
        Person(name: "Alice", fruit: .orange),
        Person(name: "Bob", fruit: .banana),
        Person(name: "Charlie", fruit: .orange),
        Person(name: "David", fruit: .banana),
        Person(name: "Eve", fruit: .orange),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Home"
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.description())
        return tableView
    }()
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.description(), for: indexPath) as? TableViewCell, data.indices.contains(indexPath.row) else { return UITableViewCell() }

        let person = data[indexPath.row]

        cell.nameLabel.text = person.name

        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let containerVC = ContainerViewController(person: data[indexPath.row], data: data)
        navigationController?.pushViewController(containerVC, animated: true)
    }
}
