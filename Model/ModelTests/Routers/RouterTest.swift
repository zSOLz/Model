//
//  RouterTest.swift
//  ModelTests
//
//  Created by SOL on 28.04.17.
//  Copyright © 2017 SOL. All rights reserved.
//

/*
import XCTest
@testable import Model

private class UIViewControllerSublassMock: UIViewController {
    var isPresentModalControllerCalled = false
    var isDismissModalControllerCalled = false
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        isPresentModalControllerCalled = true
        
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    override private func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        isDismissModalControllerCalled = true
        
        super.dismiss(animated: flag, completion: completion)
    }
}

private class RouterSubclassCloseViewMock: RouterSubclassMock {
    var closeCurrentViewClosure: ((Bool, (() -> Void)?) -> Void)!
    
    override open func closeCurrentView(animated: Bool, completion: (() -> Void)?) {
        closeCurrentViewClosure(animated, completion)
    }
}

class RouterTest: XCTestCase {
    func testAddChildRouterMethod() {
        let parentRouter = Router()
        let childRouter1 = Router()
        let childRouter2 = Router()
        
        parentRouter.addChild(router: childRouter1)
        parentRouter.addChild(router: childRouter2)
        
        XCTAssertEqual(parentRouter.childRouters, [childRouter1, childRouter2])
        XCTAssertEqual(childRouter1.parentRouter ,  parentRouter)
        XCTAssertEqual(childRouter2.parentRouter ,  parentRouter)
    }
    
    func testRemoveChildRouterMethod() {
        let parentRouter = Router()
        let childRouter1 = Router()
        let childRouter2 = Router()
        
        parentRouter.addChild(router: childRouter1)
        parentRouter.addChild(router: childRouter2)
        
        XCTAssertEqual(parentRouter.childRouters, [childRouter1, childRouter2])

        childRouter1.removeFromParent()

        XCTAssertEqual(parentRouter.childRouters, [childRouter2])
        XCTAssertNil(childRouter1.parentRouter)

        childRouter2.removeFromParent()
        
        XCTAssertEqual(parentRouter.childRouters, [])
        XCTAssertNil(childRouter2.parentRouter)
    }
    
    func testCloseCurrentViewMethod() {
        let router = RouterSubclassCloseViewMock()
        var completionBlock: (() -> Void)?
        var isAnimated: Bool?
        var isCloseCurrentViewCalled = false
        
        router.closeCurrentViewClosure = { animated, completion in
            isCloseCurrentViewCalled = true
            isAnimated = animated
            completionBlock = completion
        }
        router.closeCurrentView()
        
        XCTAssertTrue(isCloseCurrentViewCalled)
        XCTAssertTrue(isAnimated!)
        XCTAssertNil(completionBlock)
    }
    
    func testCloseCurrentViewAnimatedMethod() {
        let router = RouterSubclassCloseViewMock()
        var completionBlock: (() -> Void)?
        var isAnimated: Bool?
        var isCloseCurrentViewCalled = false
        
        router.closeCurrentViewClosure = { animated, completion in
            isCloseCurrentViewCalled = true
            isAnimated = animated
            completionBlock = completion
        }
        router.closeCurrentView(animated: false)
        
        XCTAssertTrue(isCloseCurrentViewCalled)
        XCTAssertFalse(isAnimated!)
        XCTAssertNil(completionBlock)
        
        isAnimated = nil
        isCloseCurrentViewCalled = false
        
        router.closeCurrentView(animated: true)
        
        XCTAssertTrue(isCloseCurrentViewCalled)
        XCTAssertTrue(isAnimated!)
        XCTAssertNil(completionBlock)
    }

    func testPresentModalRouterMethod() {
        let parentViewController = UIViewControllerSublassMock()
        let parentRouter = RouterSubclassMock()
        parentRouter.getBaseViewControllerClosure = {
            return parentViewController
        }
        
        let childViewController = UIViewController()
        let childRouter = RouterSubclassMock()
        childRouter.getBaseViewControllerClosure = {
            return childViewController
        }
        
        let window = UIWindow()
        window.rootViewController = parentViewController
        window.addSubview(parentViewController.view)
        parentRouter.presentModalRouter(childRouter, animated: false)
        
        XCTAssertEqual(parentRouter.childRouters, [childRouter])
        XCTAssertEqual(childRouter.parentRouter ,  parentRouter)
        XCTAssertTrue(parentViewController.isPresentModalControllerCalled)
        XCTAssertFalse(parentViewController.isDismissModalControllerCalled)
        XCTAssertEqual(parentViewController.presentedViewController ,  childViewController)
        XCTAssertEqual(childViewController.presentingViewController ,  parentViewController)
        
        parentRouter.dismissModalRouter(childRouter, animated: false)
        
        XCTAssertEqual(parentRouter.childRouters, [])
        XCTAssertNil(childRouter.parentRouter)
        XCTAssertTrue(parentViewController.isDismissModalControllerCalled)
    }
    
    func testCloseCurrentViewMethod_Empty() {
        let viewController = UIViewControllerSublassMock()
        let router = RouterSubclassMock()
        router.getBaseViewControllerClosure = {
            return viewController
        }
        router.getShouldAutomaticallyDismissModalControllerClosure = {
            return true
        }
        router.getHasPresentedViewControllerClosure = {
            return false
        }

        var closeEmptyViewCalled = false
        router.closeCurrentView(animated: true) { 
            closeEmptyViewCalled = true
        }
        
        XCTAssertTrue(closeEmptyViewCalled)
    }
    
    func testCloseCurrentViewMethod_Presented() {
        let parentViewController = UIViewControllerSublassMock()
        let childViewController = UIViewControllerSublassMock()
        let router = RouterSubclassMock()
        router.getBaseViewControllerClosure = {
            return parentViewController
        }
        router.getShouldAutomaticallyDismissModalControllerClosure = {
            return true
        }
        router.getHasPresentedViewControllerClosure = {
            return true
        }
        
        router.baseViewController.present(childViewController, animated: false)
        XCTAssertTrue(parentViewController.isPresentModalControllerCalled)
        router.closeCurrentView(animated: false)
        XCTAssertTrue(parentViewController.isDismissModalControllerCalled)
        
        router.getShouldAutomaticallyDismissModalControllerClosure = {
            return false
        }
        
        parentViewController.isPresentModalControllerCalled = false
        parentViewController.isDismissModalControllerCalled = false
        
        router.baseViewController.present(childViewController, animated: false)
        XCTAssertTrue(parentViewController.isPresentModalControllerCalled)
        router.closeCurrentView(animated: false)
        XCTAssertFalse(parentViewController.isDismissModalControllerCalled)
    }
    
    func testCloseCurrentViewMethod_CloseParent() {
        let parentViewController = UIViewControllerSublassMock()
        let childViewController = UIViewControllerSublassMock()
        let parentRouter = RouterSubclassCloseViewMock()
        let childRouter = RouterSubclassMock()
        
        parentRouter.addChild(router: childRouter)
        
        parentRouter.getBaseViewControllerClosure = {
            return parentViewController
        }
        childRouter.getBaseViewControllerClosure = {
            return childViewController
        }
        childRouter.getShouldAutomaticallyDismissModalControllerClosure = {
            return true
        }
        childRouter.getHasPresentedViewControllerClosure = {
            return false
        }
        
        var isCloseCurrentViewClosureParentCalled = false
        parentRouter.closeCurrentViewClosure = { animated, completion in
            isCloseCurrentViewClosureParentCalled = true
        }
        
        childRouter.closeCurrentView()
        XCTAssertTrue(isCloseCurrentViewClosureParentCalled)
    }
}
*/
