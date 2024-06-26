//
//  SceneDelegate.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/4/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else {return}
        window = UIWindow(windowScene: windowScene) // SceneDelegate의 window 프로퍼티에 설정해줌 windowScene을 대입해줌
        
        let rxViewController = RxViewController()
        let testViewController = TestViewController()
        let memberListViewController = UINavigationController(rootViewController: MemberListViewController())
        let subwayViewController = SubwayViewController()
        
        // 탭바 설정
        let mainTabBarController = UITabBarController()
        mainTabBarController.setViewControllers([rxViewController, subwayViewController, testViewController, memberListViewController], animated: true)
        if let items = mainTabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "graduationcap.circle")
            items[0].image = UIImage(systemName: "graduationcap.circle")
            items[0].title = "Rx공부용"
            
            items[1].selectedImage = UIImage(systemName: "tram.circle.fill")
            items[1].image = UIImage(systemName: "tram.circle.fill")
            items[1].title = "지하철"
            
            items[2].selectedImage = UIImage(systemName: "1.circle")
            items[2].image = UIImage(systemName: "1.circle")
            items[2].title = "Rx테스트1"
            
            items[3].selectedImage = UIImage(systemName: "2.circle")
            items[3].image = UIImage(systemName: "2.circle")
            items[3].title = "Rx테스트2"
        }
        
        window?.rootViewController = mainTabBarController // rootViewController -> Is Initial View Controller 설정
        window?.makeKeyAndVisible() // 화면에 표시
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

