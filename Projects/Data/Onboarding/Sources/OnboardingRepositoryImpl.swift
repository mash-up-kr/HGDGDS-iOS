//
//  OnboardingRepositoryImpl.swift
//  Onboarding
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

import OnboardingDomain
import HGNetwork

public final class OnboardingRepositoryImpl: OnboardingRepository {
        
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
    
    public func signUp(
        deviceId: String,
        nickname: String,
        profileType: ProfileType
    ) async throws -> SignUpResponse {
        let parameters: HGParameters = [
            "deviceId": deviceId,
            "nickname": nickname,
            "profileImageCode": profileType.rawValue
        ]
        let api = SignUpAPI(parameters: parameters)
        
        do {
            guard let dtoModel = try await network.send(api, intercepter: nil),
                  let data = dtoModel.data else {
                throw NetworkError.timeout // TODO: #44 합쳐지면 변경
            }
            
            return data.toDomain
        } catch {
            throw NetworkError.timeout // TODO: #44 합쳐지면 변경
        }
    }

    public func updateFCM(fcmToken: String) async throws {
        let parameters: HGParameters = [
            "fcmToken": fcmToken,
        ]
        let api = UpdateFcmAPI(parameters: parameters)
        
        do {
            guard let _ = try await network.send(api) else {
                throw NetworkError.timeout // TODO: #44 합쳐지면 변경
            }
            
            return
        } catch {
            throw NetworkError.timeout // TODO: #44 합쳐지면 변경
        }
    }
    
    public func getProfileList() async throws -> [ProfileEntity] {
        let api = GetProfileListAPI(parameters: nil)
        
        do {
            guard let dtoModel = try await network.send(api, intercepter: nil) else {
                throw NetworkError.timeout // TODO: #44 합쳐지면 변경
            }
            
            return dtoModel.data?.map { $0.toDmomain } ?? []
        } catch {
            throw NetworkError.timeout // TODO: #44 합쳐지면 변경
        }
    }
}
