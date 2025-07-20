//
//  StarshipViewController.swift
//  StarWars
//
//  Created by Zaid Tayyab on 8/4/23.
//

import UIKit
import Combine

class StarshipViewController: UIViewController {
    private lazy var tableView: UITableView = setupTableView()
    private lazy var manufacturerPicker: UIPickerView = setupManufacturerPicker()

    private var viewModel: StarshipViewModel!
    private var cancellables: Set<AnyCancellable> = []

    private var dataSource: UITableViewDiffableDataSource<Int, Starship>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupViewModel()
        fetchStarships()
    }
    private func configureViews() {
        buildHierarchy()
        setConstraints()
        setupRefreshFilterButton()
        setUpPullToRefresh()
        
    }
    private func buildHierarchy() {
        view.addSubview(tableView)
        view.addSubview(manufacturerPicker)
        
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        NSLayoutConstraint.activate([
            manufacturerPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            manufacturerPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            manufacturerPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            manufacturerPicker.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    private func setupViewModel() {
        viewModel = StarshipViewModel(starshipRepository: StarShipRepository())
        
        viewModel.filteredStarshipsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
                self?.manufacturerPicker.reloadAllComponents()
            }
            .store(in: &cancellables)
    }

    private func setupTableView() -> UITableView {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StarshipCell")
        tableView.delegate = self
        // Create the DiffableDataSource
        dataSource = UITableViewDiffableDataSource<Int, Starship>(tableView: tableView, cellProvider: { tableView, indexPath, starship in
            let cell = tableView.dequeueReusableCell(withIdentifier: "StarshipCell", for: indexPath)
            cell.textLabel?.text = starship.name
            return cell
        })
        return tableView
    }
    private func setupRefreshFilterButton() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        
        navigationItem.rightBarButtonItem = refreshButton
    }
    private func setUpPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    @objc private func refreshData() {
        viewModel.refreshStarships()
        tableView.refreshControl?.endRefreshing()
    }
    @objc private func refreshButtonTapped() {
        viewModel.applyFilter(manufacturer: nil)
        applySnapshot()
    }
    private func setupManufacturerPicker() -> UIPickerView {
        let manufacturerPicker = UIPickerView()
        
        manufacturerPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        manufacturerPicker.dataSource = self
        manufacturerPicker.delegate = self
        return manufacturerPicker
    }

    private func fetchStarships() {
        viewModel.fetchStarships()
    }
    private func refreshFilters() {
        viewModel.fetchStarships()
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Starship>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.filteredStarships, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension StarshipViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.availableManufacturers.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.availableManufacturers[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row >= 0, row < viewModel.availableManufacturers.count else {
            print("Invalid selected row: \(row)")
            return
        }
        let selectedManufacturer = viewModel.availableManufacturers[row]
        
        viewModel.applyFilter(manufacturer: selectedManufacturer)
        
        applySnapshot()
    }
}
extension StarshipViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height

        if offsetY > contentHeight - screenHeight {
            viewModel.fetchNextPage()
        }
    }
}
