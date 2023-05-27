//
//  UITableView.swift
//  BmiBros
//
//  Created by MacBook Pro on 25/05/23.
//

import SwiftUI

struct UITableView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: FoodViewModel

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = context.coordinator

        viewController.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])

        return viewController
    }

    func updateUIViewController( _ uiViewController: UIViewController, context: Context) {
        // Update data if needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    class Coordinator: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        }
        
        var viewModel: FoodViewModel

        init(viewModel: FoodViewModel) {
            self.viewModel = viewModel
        }

        func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            viewModel.foods.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            let food = viewModel.foods[indexPath.row]
            cell.textLabel?.text = food.name
            return cell
        }
    }
}
