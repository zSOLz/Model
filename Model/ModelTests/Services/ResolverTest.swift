//
//  ResolverTest.swift
//  Model
//
//  Created by SOL on 02.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

import XCTest
@testable import Model

public class TestResolver: Resolver {
    public var parentResolver: Resolver?
    public var containers: [Container] = []
}

public class MockA: Resolvable {}
public class MockB: Resolvable {}
public class MockC: Resolvable {}
public class MockD: Resolvable {
    var identifier: String
    init (identifier: String) {
        self.identifier = identifier
    }
}
public class MockE: MockD {}

class ResolverTest: XCTestCase {
    func testResolve() {
        // given:
        let firstResolver = TestResolver()
        let secondResolver = TestResolver()
        let thirdResolver = TestResolver()
        
        firstResolver.parentResolver = rootResolver
        oneChildResolver.parentResolver = mainResolver
        anotherChildResolver.parentResolver = mainResolver
        
        rootResolver.register(MockA())
        mainResolver.register(MockB())
        oneChildResolver.register(MockC())
        anotherChildResolver.register(MockA())
        
        rootResolver.register(MockD(identifier: "root"))
        mainResolver.register(MockD(identifier: "main"))
        oneChildResolver.register(MockD(identifier: "once child"))
        anotherChildResolver.register(MockD(identifier: "ahotner child"))
        
        rootResolver.register(MockE(identifier: "root"), keypath: "root")
        mainResolver.register(MockE(identifier: "main"), keypath: "main")
        oneChildResolver.register(MockE(identifier: "once child"), keypath: "once child")
        anotherChildResolver.register(MockE(identifier: "ahotner child"), keypath: "ahotner child")
        
        // when:
        func tryResolve<T, Keypath: Hashable>(_: T.Type, keypath: Keypath? = nil, identifier: String? = nil, resolver: Resolver) {
            resolver.re
        }
        
        // then:
        
        let generalManager = ServiceManager.general
        let childManager = ServiceManager(parent: generalManager)
        
        XCTAssertNil(generalManager.parent)
        XCTAssertEqual(generalManager, childManager.parent)
    }
    
    func testServicesRegistration() {
        let manager = ServiceManager.general
        let customService = CustomResolver()
        let anotherCustomService = AnotherCustomServiceMock()
        
        XCTAssertEqual(manager.registeredServices, [])
        manager.register(service: customService)
        XCTAssertEqual(manager.registeredServices, [customService])
        manager.register(service: anotherCustomService)
        XCTAssertEqual(manager.registeredServices, [customService, anotherCustomService])
        
        manager.unregister(service: customService)
        manager.unregister(service: anotherCustomService)
        XCTAssertEqual(manager.registeredServices, [])
    }
    
    func testRegisteredServiceWithTypeMethod() {
        let customSubclassService = CustomServiceSubclassMock()
        let parentManager = ServiceManager(parent: ServiceManager.general)
        let childManager = ServiceManager(parent: parentManager)
        
        XCTAssertNil(parentManager.registered(serviceWithType: CustomResolver.self))
        XCTAssertNil(childManager.registered(serviceWithType: CustomResolver.self))
        XCTAssertNil(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        
        childManager.register(service: customSubclassService)
        
        XCTAssertNil(parentManager.registered(serviceWithType: CustomResolver.self))
        XCTAssertEqual(childManager.registered(serviceWithType: CustomResolver.self), customSubclassService)
        XCTAssertNil(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertEqual(childManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        
        parentManager.register(service: customSubclassService)
        
        XCTAssertEqual(parentManager.registered(serviceWithType: CustomResolver.self), customSubclassService)
        XCTAssertEqual(childManager.registered(serviceWithType: CustomResolver.self), customSubclassService)
        XCTAssertEqual(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertEqual(childManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        
        childManager.unregister(service: customSubclassService)
        
        XCTAssertEqual(parentManager.registered(serviceWithType: CustomResolver.self), customSubclassService)
        XCTAssertEqual(childManager.registered(serviceWithType: CustomResolver.self), customSubclassService)
        XCTAssertEqual(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertEqual(childManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        
        parentManager.unregister(service: customSubclassService)
        
        XCTAssertNil(parentManager.registered(serviceWithType: CustomResolver.self))
        XCTAssertNil(childManager.registered(serviceWithType: CustomResolver.self))
        XCTAssertNil(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))
    }
}
