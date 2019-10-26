//
//  TabRouterTest.swift
//  ModelTests
//
//  Created by SOL on 02.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

/*
import XCTest
@testable import Model

private class OneViewController: UIViewController { }
private class AnotherViewController: UIViewController { }
private class CustomTabBarController: PresentableTabBarController { }

private class TabRouterSubcassMock: TabRouter {
    var isLoadTabBarControllerCalled = false
    
    override private func loadTabBarController() {
        isLoadTabBarControllerCalled = true
        
        super.loadTabBarController()
    }
}

class TabRouterTests: XCTestCase {
    func testDefaultLoad() {
        let tabRouter = TabRouter()
        
        XCTAssertNotNil(tabRouter.tabBarController)
        XCTAssertNil(tabRouter.activeViewController)
        XCTAssertNil(tabRouter.viewController(withType: UIViewController.self))
        XCTAssertFalse(tabRouter.containsViewController(withType: UIViewController.self))
    }
    
    func testBaseViewControllerMethod() {
        let tabRouter = TabRouter()
        let customTabBar = CustomTabBarController()

        tabRouter.tabBarController = customTabBar
        XCTAssertEqual(tabRouter.tabBarController, customTabBar)
        XCTAssertEqual(tabRouter.baseViewController, customTabBar)
    }
    
    func testActiveViewControllerMethod() {
        let tabRouter = TabRouter()
        let oneViewController = OneViewController()
        let anotherViewController = AnotherViewController()
        
        tabRouter.tabBarController.viewControllers = [oneViewController, anotherViewController]
        XCTAssertEqual(tabRouter.activeViewController, oneViewController)
        
        tabRouter.tabBarController.selectedIndex = 1
        XCTAssertEqual(tabRouter.activeViewController, anotherViewController)
        
        tabRouter.tabBarController.selectedViewController = oneViewController
        XCTAssertEqual(tabRouter.activeViewController, oneViewController)
    }
    
    func testViewControllerWithTypeMethod() {
        let tabRouter = TabRouter()
        let oneViewController = OneViewController()
        let anotherViewController = AnotherViewController()
        
        tabRouter.tabBarController.viewControllers = [oneViewController]
        
        XCTAssertEqual(tabRouter.viewController(withType: OneViewController.self), oneViewController)
        XCTAssertNil(tabRouter.viewController(withType: AnotherViewController.self))
        
        tabRouter.tabBarController.viewControllers = [oneViewController, anotherViewController]
        XCTAssertEqual(tabRouter.viewController(withType: UIViewController.self), oneViewController)

        tabRouter.tabBarController.viewControllers = [anotherViewController, oneViewController]
        XCTAssertEqual(tabRouter.viewController(withType: UIViewController.self), anotherViewController)
    }
    
    func testContainsViewControllerWithTypeMethod() {
        let tabRouter = TabRouter()
        let oneViewController = OneViewController()
        let anotherViewController = AnotherViewController()
        
        tabRouter.tabBarController.viewControllers = [oneViewController]
        
        XCTAssertTrue(tabRouter.containsViewController(withType: OneViewController.self))
        XCTAssertFalse(tabRouter.containsViewController(withType: AnotherViewController.self))
        
        tabRouter.tabBarController.viewControllers = [oneViewController, anotherViewController]
        XCTAssertTrue(tabRouter.containsViewController(withType: OneViewController.self))
        XCTAssertTrue(tabRouter.containsViewController(withType: AnotherViewController.self))
        XCTAssertTrue(tabRouter.containsViewController(withType: UIViewController.self))
    }
    
    func testSelectViewControllerWithTypeMethod() {
        let tabRouter = TabRouter()
        let oneViewController = OneViewController()
        let anotherViewController = AnotherViewController()
        
        tabRouter.tabBarController.viewControllers = [oneViewController, anotherViewController]
        
        tabRouter.selectViewController(withType: OneViewController.self)
        XCTAssertEqual(tabRouter.tabBarController.selectedViewController, oneViewController)
        
        tabRouter.selectViewController(withType: AnotherViewController.self)
        XCTAssertEqual(tabRouter.tabBarController.selectedViewController, anotherViewController)

        tabRouter.selectViewController(withType: UIViewController.self)
        XCTAssertEqual(tabRouter.tabBarController.selectedViewController, oneViewController)
        
        tabRouter.tabBarController.viewControllers = [anotherViewController, oneViewController]
        tabRouter.tabBarController.selectedViewController = oneViewController
        tabRouter.selectViewController(withType: UIViewController.self)
        XCTAssertEqual(tabRouter.tabBarController.selectedViewController, anotherViewController)
    }

    func testSelectViewControllerWithRouterTypeMethod() {
        let tabRouter = TabRouter()
        let childRouter = RouterSubclassMock()
        let childViewController = AnotherViewController()
        let anotherViewController = OneViewController()
        
        childRouter.getBaseViewControllerClosure = {
            return childViewController
        }
        
        tabRouter.tabBarController.viewControllers = [anotherViewController, childViewController]
        tabRouter.addChild(router: childRouter)
        tabRouter.selectViewController(withRouterType: RouterSubclassMock.self)
        XCTAssertEqual(tabRouter.tabBarController.selectedViewController, childViewController)
    }
    
    func testLoadTabBarControllerMethod() {
        let router1 = TabRouterSubcassMock()
        let _ = router1.tabBarController
        XCTAssertTrue(router1.isLoadTabBarControllerCalled)
        
        let router2 = TabRouterSubcassMock()
        router2.tabBarController = CustomTabBarController()
        let _ = router2.tabBarController
        XCTAssertFalse(router2.isLoadTabBarControllerCalled)
    }
}
*/
