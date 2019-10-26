//
//  StackRouterTest.swift
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
private class CustomNavigationController: PresentableNavigationController { }

private class StackRouterSubcassMock: StackRouter {
    var isLoadNavigationControllerCalled = false
    
    override private func loadNavigationController() {
        isLoadNavigationControllerCalled = true
        
        super.loadNavigationController()
    }
}

class StackRouterTests: XCTestCase {
    func testDefaultLoad() {
        let stackRouter = StackRouter()
        
        XCTAssertNotNil(stackRouter.navigationController)
        XCTAssertNil(stackRouter.activeViewController)
        XCTAssertNil(stackRouter.lastViewController(withType: UIViewController.self))
        XCTAssertFalse(stackRouter.containsViewController(withType: UIViewController.self))
        XCTAssertEqual(stackRouter.popToFirstViewController(withType: UIViewController.self, animated: false), [])
        XCTAssertTrue(stackRouter.shouldAutomaticallyRemoveUnusedChildRouters)
    }
    
    func testBaseViewControllerMethod() {
        let stackRouter = StackRouter()
        let customNavigation = CustomNavigationController()
        
        stackRouter.navigationController = customNavigation
        XCTAssertEqual(stackRouter.navigationController, customNavigation)
        XCTAssertEqual(stackRouter.baseViewController, customNavigation)
    }
    
    func testActiveViewControllerMethod() {
        let stackRouter = StackRouter()
        let oneViewController = OneViewController()
        let anotherViewController = AnotherViewController()
        
        stackRouter.navigationController.viewControllers = [oneViewController]
        XCTAssertEqual(stackRouter.activeViewController, oneViewController)
        
        stackRouter.navigationController.viewControllers = [oneViewController, anotherViewController]
        XCTAssertEqual(stackRouter.activeViewController, anotherViewController)
        
        stackRouter.navigationController.popViewController(animated: false)
        XCTAssertEqual(stackRouter.activeViewController, oneViewController)
    }
    
    func testLastViewControllerWithTypeMethod() {
        let stackRouter = StackRouter()
        let oneViewController = OneViewController()
        let secondOneViewController = OneViewController()
        let anotherViewController = AnotherViewController()
        
        stackRouter.navigationController.viewControllers = [oneViewController, anotherViewController]
        XCTAssertEqual(stackRouter.lastViewController(withType: AnotherViewController.self), anotherViewController)
        XCTAssertEqual(stackRouter.lastViewController(withType: OneViewController.self), oneViewController)
        
        stackRouter.navigationController.viewControllers = [oneViewController, secondOneViewController, anotherViewController]
        XCTAssertEqual(stackRouter.lastViewController(withType: AnotherViewController.self), anotherViewController)
        XCTAssertEqual(stackRouter.lastViewController(withType: OneViewController.self), secondOneViewController)

        stackRouter.navigationController.viewControllers = [secondOneViewController, oneViewController, anotherViewController]
        XCTAssertEqual(stackRouter.lastViewController(withType: OneViewController.self), oneViewController)
        
        stackRouter.navigationController.viewControllers = [oneViewController, secondOneViewController]
        XCTAssertNil(stackRouter.lastViewController(withType: AnotherViewController.self))
        
        stackRouter.navigationController.viewControllers = []
        XCTAssertNil(stackRouter.lastViewController(withType: AnotherViewController.self))
        XCTAssertNil(stackRouter.lastViewController(withType: OneViewController.self))
    }
    
    func testContainsViewControllerWithTypeMethod() {
        let stackRouter = StackRouter()
        let oneViewController = OneViewController()
        let secondOneViewController = OneViewController()
        let anotherViewController = AnotherViewController()
        
        stackRouter.navigationController.viewControllers = [oneViewController, secondOneViewController, anotherViewController]
        XCTAssertTrue(stackRouter.containsViewController(withType: AnotherViewController.self))
        XCTAssertTrue(stackRouter.containsViewController(withType: OneViewController.self))

        stackRouter.navigationController.viewControllers = [oneViewController, secondOneViewController]
        XCTAssertFalse(stackRouter.containsViewController(withType: AnotherViewController.self))
        XCTAssertTrue(stackRouter.containsViewController(withType: OneViewController.self))

        stackRouter.navigationController.viewControllers = []
        XCTAssertFalse(stackRouter.containsViewController(withType: AnotherViewController.self))
        XCTAssertFalse(stackRouter.containsViewController(withType: OneViewController.self))
    }
    
    func testPopToFirstViewControllerWithTypeMethod() {
        let stackRouter = StackRouter()
        let oneViewController = OneViewController()
        let secondOneViewController = OneViewController()
        let anotherViewController = AnotherViewController()
        
        stackRouter.navigationController.viewControllers = [oneViewController, anotherViewController]
        stackRouter.popToFirstViewController(withType: AnotherViewController.self, animated: false)
        XCTAssertEqual(stackRouter.activeViewController, anotherViewController)
        stackRouter.popToFirstViewController(withType: OneViewController.self, animated: false)
        XCTAssertEqual(stackRouter.activeViewController, oneViewController)
        
        stackRouter.navigationController.viewControllers = [oneViewController, secondOneViewController, anotherViewController]
        XCTAssertEqual(stackRouter.activeViewController, anotherViewController)
        stackRouter.popToFirstViewController(withType: OneViewController.self, animated: false)
        XCTAssertEqual(stackRouter.activeViewController, secondOneViewController)
        stackRouter.popToFirstViewController(withType: OneViewController.self, animated: false)
        XCTAssertEqual(stackRouter.activeViewController, secondOneViewController)
        
        stackRouter.navigationController.viewControllers = [oneViewController]
        stackRouter.popToFirstViewController(withType: UIViewController.self, animated: false)
        XCTAssertEqual(stackRouter.activeViewController, oneViewController)
    }
    
    func testLoadNavigationControllerMethod() {
        let router1 = StackRouterSubcassMock()
        let _ = router1.navigationController
        XCTAssertTrue(router1.isLoadNavigationControllerCalled)
        
        let router2 = StackRouterSubcassMock()
        router2.navigationController = CustomNavigationController()
        let _ = router2.navigationController
        XCTAssertFalse(router2.isLoadNavigationControllerCalled)
    }
    
    func testCloseCurrentViewMethod() {
        let stackRouter = StackRouter()
        let oneViewController = OneViewController()
        let anotherViewController = AnotherViewController()

        stackRouter.navigationController.viewControllers = [oneViewController, anotherViewController]
        stackRouter.closeCurrentView(animated: false, completion: nil)
        XCTAssertEqual(stackRouter.activeViewController, oneViewController)

        stackRouter.navigationController.viewControllers = [oneViewController, anotherViewController]
        stackRouter.closeCurrentView(animated: false)
        XCTAssertEqual(stackRouter.activeViewController, oneViewController)
        
        stackRouter.navigationController.viewControllers = [anotherViewController]
        stackRouter.closeCurrentView(animated: false)
        XCTAssertEqual(stackRouter.activeViewController, anotherViewController)
    }
}
*/
