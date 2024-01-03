//
//  InternetConnectionManager.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 03/01/2024.
//

import Foundation
import Reachability

class InternetConnectionManager {

    static let shared = InternetConnectionManager() // Singleton

    private let reachability = try! Reachability()

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged), name: .reachabilityChanged, object: reachability)
        try? reachability.startNotifier()
    }

    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    func isConnectedToNetwork() -> Bool {
        return reachability.connection != .unavailable
    }

    @objc private func networkStatusChanged() {
        print("Network status changed: \(reachability.connection)")
    }
}
