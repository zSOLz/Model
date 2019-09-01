//
//  ApplicationAssembly.swift
//  Model-Sample
//
//  Created by SOL on 04.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import Model

final class ApplicationAssembly: Assembly {
    /// One instance of this router will be assigned to all presenters inside current module.
    /// 'Weak' specifier was used to break retain cycle: View > Presenter > Router > View.
    fileprivate weak var innerApplicationRouter: ApplicationRouter?
    
    func applicationRouter() -> ApplicationRouter {
        if let applicationRouter = innerApplicationRouter {
            return applicationRouter
        } else {
            let router = ApplicationRouter(applicationAssembly: self)
            innerApplicationRouter = router
            return router
        }
    }
}

// MARK: - ApplicationAssemblyInterface
extension ApplicationAssembly: ApplicationAssemblyInterface {
    /// NewsFeedRouter is contain in another assembly. First you create assembly then router.
    /// Router's object will keep strong reference to underlined assembly.
    /// See NewsFeedAssembly.newsFeedRouter() method and NewsFeedRouter.newsFeedAssembly preperty
    func newsFeedRouter() -> NewsFeedRouter {
        return NewsFeedAssembly().newsFeedRouter()
    }
    
    /// ProfileRouter is contain in another assembly. First you create assembly then router.
    /// Router's object will keep strong reference to underlined assembly.
    /// See ProfileAssembly.profileRouter() method and ProfileRouter.profileAssembly preperty
    func profileRouter() -> ProfileRouter {
        return ProfileAssembly().profileRouter()
    }
}
