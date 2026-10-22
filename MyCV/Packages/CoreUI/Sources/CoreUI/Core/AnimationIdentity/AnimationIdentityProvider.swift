//
//  AnimationIdentityProvider.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 30.06.2025.
//

@MainActor
public protocol AnimationIdentityProvider {

    /// Layout animation identity. Only properties that may affect layout
    /// changes should be part of the identity.
    var layoutAnimationIdentity: AnyHashable { get }
}
