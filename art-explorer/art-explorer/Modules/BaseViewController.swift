//
//  BaseViewController.swift
//  art-explorer
//
//  Created by Pedro Freddi on 21/06/25.
//

import UIKit
import Combine
import OSLog

class BaseViewController: UIViewController {

    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCancelables()
    }

    deinit {
        #if DEBUG
        Logger.viewCycle.info("\(type(of: self)) deallocated")
        #endif
    }

    func setupCancelables() {}

    func showAlert(title: String, message: String, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        _ = actions.map { alert.addAction($0) }
        present(alert, animated: true)
    }

}
