import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }

        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            self.window?.rootViewController = createTabBar()
            self.window?.makeKeyAndVisible()
        }
        createPhotosArray()
    }
    
    func createNC_1() -> UINavigationController {
        let feedVC = FeedVC()
        let feedImage = UIImage(systemName: "house")
        feedVC.title = "Feed"
        feedVC.tabBarItem = UITabBarItem(
            title: "Feed",
            image: feedImage,
            selectedImage: nil
        )
        return UINavigationController(rootViewController: feedVC)
    }
    
    func createNC_2() -> UINavigationController {
        let logInVC = LogInVC()
        
        let profileImage = UIImage(systemName: "person")
        logInVC.navigationController?.navigationBar.barTintColor = UIColor.systemGray
        logInVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: profileImage,
            selectedImage: nil
        )
        return UINavigationController(rootViewController: logInVC)
    }
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemBlue
        tabBar.tabBar.backgroundColor = .white
        tabBar.viewControllers = [createNC_1(), createNC_2()]
        
        return tabBar
    }

}

