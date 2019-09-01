//
//  ApplicationRouter.swift
//  Model-Sample
//
//  Created by SOL on 04.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class ApplicationRouter: TabRouter {
    let applicationAssembly: ApplicationAssemblyInterface
    
    init(applicationAssembly: ApplicationAssemblyInterface) {
        self.applicationAssembly = applicationAssembly
    }
    
    override public func loadTabBarController() {
        super.loadTabBarController()
        
        let newsFeedRouter = applicationAssembly.newsFeedRouter()
        newsFeedRouter.baseViewController.tabBarItem.title = "News"
        
        let profileRouter = applicationAssembly.profileRouter()
        profileRouter.baseViewController.tabBarItem.title = "Profile"
        
        tabBarController.viewControllers = [newsFeedRouter.baseViewController,
                                            profileRouter.baseViewController]
        addChild(router: newsFeedRouter)
        addChild(router: profileRouter)
        
        selectViewController(withRouterType: NewsFeedRouter.self)
    }
}

// MARK: - ApplicationRouterInterface
extension ApplicationRouter: ApplicationRouterInterface {
    // Empty
}
