//
//  InteractiveDismissal.swift
//  Model
//
//  Created by Kirill Budevich on 11/14/19.
//  Copyright © 2019 SOL. All rights reserved.
//

/*
 Protocol provides ability to `deny` or `allow` user's pop/dismiss interactive interactions.
 */
public protocol InteractiveDismissalHandler {
    func handleInteractiveDismissal(_ interactiveDismissal: InteractiveDismissal,
                                    allow: @escaping () -> Void,
                                    deny: @escaping () -> Void)
}

/*
 List of interactive interactive dismissal
 */
public struct InteractiveDismissal: RawRepresentable, Equatable {
    public let rawValue: UInt

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    // iOS 13 Page Sheet interactive dismiss gesture
    public static let modalInteractiveGesture = InteractiveDismissal(rawValue: 1 << 0)

    // Navigation edge swipe back gesture
    public static let navigationSwipeBack = InteractiveDismissal(rawValue: 1 << 1)

    // Navigation back button interaction
    public static let navigationBackButton = InteractiveDismissal(rawValue: 1 << 2)
}
