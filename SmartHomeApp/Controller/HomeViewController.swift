import UIKit

protocol HomeViewDelegate {
    func didSelectDevices(for type: String)
}

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let homeView = HomeView(frame: view.frame)
        homeView.delegate = self
        view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension HomeViewController: HomeViewDelegate {

    func didSelectDevices(for type: String) {
        self.navigationController?.pushViewController(DevicesViewController(type: type), animated: true)
    }
}
