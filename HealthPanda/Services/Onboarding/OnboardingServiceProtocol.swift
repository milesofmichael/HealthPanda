//
//  OnboardingServiceProtocol.swift
//  HealthPanda
//
//  Protocol for onboarding flow management.
//  Enables dependency injection and testability for components that depend on onboarding state.
//

import Foundation

/// Protocol defining the onboarding service interface.
/// Consumers should depend on this protocol rather than the concrete implementation
/// to enable mocking in unit tests.
protocol OnboardingServiceProtocol: AnyObject {

    // MARK: - State Properties

    /// Device compatibility status (e.g., whether HealthKit and AI are supported)
    var deviceCompatibility: DeviceCompatibilityStatus { get }

    /// Current Apple Intelligence availability status
    var aiStatus: AiAvailabilityStatus { get }

    /// Current HealthKit authorization status
    var healthStatus: HealthAuthorizationStatus { get }

    /// Whether the user has completed the onboarding flow
    var hasCompletedOnboarding: Bool { get }

    /// Whether the service is currently loading initial state
    var isLoading: Bool { get }

    /// Current error message, if any
    var errorMessage: String? { get }

    // MARK: - Computed Properties

    /// Convenience check for HealthKit authorization
    var isHealthAuthorized: Bool { get }

    /// Convenience check for Apple Intelligence availability
    var isAiEnabled: Bool { get }

    /// Whether all requirements are met to complete onboarding
    var canCompleteOnboarding: Bool { get }

    /// User-friendly message describing current onboarding status
    var statusMessage: String { get }

    // MARK: - Actions

    /// Loads initial state including device compatibility and persisted user state.
    /// Call this when the onboarding view appears.
    func loadInitialState() async

    /// Refreshes permission states by querying system APIs directly.
    /// Use this after returning from Settings or when the app becomes active.
    func refreshPermissionStates() async

    /// Requests HealthKit authorization from the user.
    /// - Returns: true if authorization was granted
    func requestHealthAuthorization() async -> Bool

    /// Opens the Settings app for the user to enable Apple Intelligence.
    func openAppleIntelligenceSettings()

    /// Re-checks Apple Intelligence status after user returns from Settings.
    func confirmAppleIntelligenceEnabled() async

    /// Marks onboarding as complete and persists the state.
    func completeOnboarding() async
}
