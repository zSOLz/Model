//
//  Resolver.swift
//  Model
//
//  Created by SOL on 02.10.2018.
//  Copyright © 2018 SOL. All rights reserved.
//

// Implement this protocol ONLY for classes that could be registered or resolved.
// It was added by security reasons - to avoid registration of any other type
public protocol Resolvable {
    // Empty
}

public protocol Resolver: class {
    func resolve<ContentType: Resolvable>(_: ContentType.Type, keypath: AnyHashable?) -> ContentType
}

public extension Resolver {
    func resolve<ContentType: Resolvable>(_: ContentType.Type) -> ContentType {
        return resolve(ContentType.self, keypath: nil)
    }
}

public class ContainerItem {
    let content: Any
    let identifier: AnyHashable?
    
    fileprivate init(content: Any, identifier: AnyHashable?) {
        self.content = content
        self.identifier = identifier
    }
}

public protocol Continer: Resolver {
    var parentResolver: Resolver? { get }
    var containers: [ContainerItem] { get set }

    func register<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?)
    func remove<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?)
    func renew<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?)
}

public extension Continer {
    func register<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?) {
        if index(of: ContentType.self, keypath: keypath) != nil {
            assertionFailure("Attempt to register the same content \(content)" +
                " of type: \(ContentType.self) kaypath: \(String(describing: keypath))")
        }
        containers.append(ContainerItem(content: content, identifier: keypath))
    }

    func remove<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?) {
        guard let index = index(of: ContentType.self, keypath: keypath) else {
            assertionFailure("Attempt to remove content \(content)" +
                " of type: \(ContentType.self) kaypath: \(String(describing: keypath))" +
                " which does not exists")
            return
        }
        containers.remove(at: index)
    }

    func renew<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?) {
        if let index = index(of: ContentType.self, keypath: keypath),
            let oldContent = containers[index].content as? ContentType {
            remove(oldContent, keypath: keypath)
        }
        register(content, keypath: keypath)
    }
    
    func resolve<ContentType: Resolvable>(_: ContentType.Type, keypath: AnyHashable?) -> ContentType {
        guard let index = index(of: ContentType.self, keypath: keypath) else {
            guard let parent = parentResolver else {
                fatalError("Unable to resolve \(ContentType.self), keypath: \(String(describing: keypath))")
            }
            return parent.resolve(ContentType.self, keypath: keypath)
        }
        guard let content = containers[index].content as? ContentType else {
            fatalError("Unable to cast conten: \(containers[index].content), to \(ContentType.self), keypath: \(String(describing: keypath))")
        }
        return content
    }
    
    func register<ContentType: Resolvable>(_ content: ContentType) {
        register(content, keypath: nil)
    }
    
    func remove<ContentType: Resolvable>(_ content: ContentType) {
        remove(content, keypath: nil)
    }
    
    func renew<ContentType: Resolvable>(_ content: ContentType) {
        renew(content, keypath: nil)
    }
}

private extension Continer {
    func index<ContentType>(of _: ContentType.Type, keypath: AnyHashable?) -> Int? {
        return containers.firstIndex(where: { $0.content is ContentType && $0.identifier == keypath })
    }
}
