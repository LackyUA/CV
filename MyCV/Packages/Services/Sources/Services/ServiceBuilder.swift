//
//  ServiceBuilder.swift
//  Services
//

/// Builds the services of the package behind their public protocols.
///
/// The implementations are internal to the package. Clients depend on the
/// protocols only, so the package can replace an implementation without a client change.
public enum ServiceBuilder {

    /// Builds the service that loads the CV content.
    public static func makeAPIService() -> any APIService {
        DefaultService()
    }
}
