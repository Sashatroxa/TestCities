//
//  AppDelegate.swift
//  CitiesTest
//
//  Created by Aleksandr on 03.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupMainScreen()
        
        return true
    }
    
    private func setupMainScreen() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let controller = MainController()
        let presenter = MainPresenter(view: controller)
        controller.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.isNavigationBarHidden = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = navigationController
    }
}
