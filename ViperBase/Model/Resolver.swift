//
//  ContainerProtocol.swift
//  Model
//
//  Created by SOL on 02.10.2018.
//  Copyright © 2018 SOL. All rights reserved.
//

public class Container {
    let content: Any
    let identifier: AnyHashable?
    
    fileprivate init(content: Any, identifier: AnyHashable?) {
        self.content = content
        self.identifier = identifier
    }
}

public protocol Resolver: class {
    var parentResolver: Resolver? { get }
    var containers: [Container] { get set }
}

// Implement this protocol ONLY for classes that should be reusable.
// It was added by security reasons - to avoid registration of any other type
public protocol Resolvable {
    // Empty
}

public extension Resolver {
    func register<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable? = nil) {
        if index(of: ContentType.self, keypath: keypath) != nil {
            assertionFailure("Attempt to register the same content \(content)" +
                " of type: \(ContentType.self) kaypath: \(String(describing: keypath))")
        }
        containers.append(Container(content: content, identifier: keypath))
    }

    func remove<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable? = nil) {
        guard let index = index(of: ContentType.self, keypath: keypath) else {
            assertionFailure("Attempt to remove content \(content)" +
                " of type: \(ContentType.self) kaypath: \(String(describing: keypath))" +
                " which does not exists")
            return
        }
        containers.remove(at: index)
    }

    func resolve<ContentType: Resolvable>(of _: ContentType.Type, keypath: AnyHashable? = nil) -> ContentType {
        guard let index = index(of: ContentType.self, keypath: keypath) else {
            guard let parent = parentResolver else {
                fatalError("Unalbe to resolve \(ContentType.self), keypath: \(String(describing: keypath))")
            }
            return parent.resolve(of: ContentType.self, keypath: keypath)
        }
        guard let content = containers[index].content as? ContentType else {
            fatalError("Unalbe to cast conten: \(containers[index].content), to \(ContentType.self), keypath: \(String(describing: keypath))")
        }
        return content

    }

    func renew<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable? = nil) {
        if let index = index(of: ContentType.self, keypath: keypath),
            let oldContent = containers[index].content as? ContentType {
            remove(oldContent, keypath: keypath)
        }
        register(content, keypath: keypath)
    }
    
    func clearContent() {
        containers.removeAll()
    }
}

private extension Resolver {
    func index<ContentType>(of _: ContentType.Type, keypath: AnyHashable?) -> Int? {
        return containers.firstIndex(where: { $0.content is ContentType && $0.identifier == keypath })
    }
}
