//
//  ServiceManagerTest.swift
//  Model
//
//  Created by SOL on 02.05.17.
//  Copyright © 2017 SOL. All rights reserved.
//

/*
import XCTest
@testable import Model

class ServiceManagerTest: XCTestCase {
    func testParentVar() {
        let generalManager = ServiceManager.general
        let childManager = ServiceManager(parent: generalManager)
        
        XCTAssertNil(generalManager.parent)
        XCTAssertEqual(generalManager, childManager.parent)
    }

    func testServicesRegistration() {
        let manager = ServiceManager.general
        let customService = CustomServiceMock()
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
        
        XCTAssertNil(parentManager.registered(serviceWithType: CustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: CustomServiceMock.self))
        XCTAssertNil(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))

        childManager.register(service: customSubclassService)
        
        XCTAssertNil(parentManager.registered(serviceWithType: CustomServiceMock.self))
        XCTAssertEqual(childManager.registered(serviceWithType: CustomServiceMock.self), customSubclassService)
        XCTAssertNil(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertEqual(childManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        
        parentManager.register(service: customSubclassService)
        
        XCTAssertEqual(parentManager.registered(serviceWithType: CustomServiceMock.self), customSubclassService)
        XCTAssertEqual(childManager.registered(serviceWithType: CustomServiceMock.self), customSubclassService)
        XCTAssertEqual(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertEqual(childManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        
        childManager.unregister(service: customSubclassService)
        
        XCTAssertEqual(parentManager.registered(serviceWithType: CustomServiceMock.self), customSubclassService)
        XCTAssertEqual(childManager.registered(serviceWithType: CustomServiceMock.self), customSubclassService)
        XCTAssertEqual(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertEqual(childManager.registered(serviceWithType: CustomServiceSubclassMock.self), customSubclassService)
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        
        parentManager.unregister(service: customSubclassService)
        
        XCTAssertNil(parentManager.registered(serviceWithType: CustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: CustomServiceMock.self))
        XCTAssertNil(parentManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: CustomServiceSubclassMock.self))
        XCTAssertNil(parentManager.registered(serviceWithType: AnotherCustomServiceMock.self))
        XCTAssertNil(childManager.registered(serviceWithType: AnotherCustomServiceMock.self))
    }
}
*/
