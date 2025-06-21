//
//  ViewController.swift
//  art-explorer
//
//  Created by Pedro Freddi on 16/06/25.
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

    func setupCancelables() {

    }
}
