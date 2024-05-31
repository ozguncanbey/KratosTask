//
//  LaunchScreen.swift
//  KratosTask
//
//  Created by Özgün Can Beydili on 31.05.2024.
//

import UIKit
import SwiftyGif

// MARK: - Protocol
protocol LaunchScreenProtocol: AnyObject {
    func configureVC()
    func playGif()
}

final class LaunchScreen: UIViewController {
    
    // MARK: - Variables
    private let viewModel = LaunchViewModel()
    
    private var gifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: - Extensions
extension LaunchScreen: LaunchScreenProtocol {
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    func playGif() {
        gifImageView = UIImageView()
        
        do {
            let gif = try UIImage(gifName: "launch_gif")
            gifImageView = UIImageView(gifImage: gif, loopCount: 3)
        } catch {
            print(error)
        }
        
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gifImageView)
        
        NSLayoutConstraint.activate([
            gifImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gifImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigateToNextScreen()
        }
    }
    
    private func navigateToNextScreen() {
        let loginScreen = LoginScreen()
        let navigationController = UINavigationController(rootViewController: loginScreen)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}
