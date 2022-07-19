import UIKit

class DevicesViewController: UIViewController {

    var viewModel: DevicesViewModel
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DeviceViewCell.self, forCellReuseIdentifier: DeviceViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(type: String) {
        viewModel = DevicesViewModel(type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .red
                
        setupTableView()
    }
    
    private func setupTableView() {

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension DevicesViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table View Data Source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeviceViewCell.identifier, for: indexPath) as? DeviceViewCell else { fatalError("UITableViewCell must be downcasted to DeviceViewCell") }
        return cell
    }

    // MARK: - Table View Delegate methods
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let deviceCell = cell as? DeviceViewCell else { return }
        let deviceVM = viewModel.getDeviceViewModel(at: indexPath.row)
        deviceCell.configure(viewModel: deviceVM)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedDevice = viewModel.didSelectRow(at: indexPath.row)
        navigationController?.pushViewController(DeviceDetailViewController(device: selectedDevice), animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
