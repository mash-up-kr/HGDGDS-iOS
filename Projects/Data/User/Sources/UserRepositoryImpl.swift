//
//  UserRepositoryImpl.swift
//  User
//
//  Created by 김남수 on 25/06/14.
//

import Foundation

import UserDomain
import HGNetwork
import HGCommon

public final class UserRepositoryImpl: UserRepository {
        
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
            guard let dtoModel = try await network.send(api),
                  let data = dtoModel.data else {
                throw HGError.domainError("dto model is nil")
            }
            
            return data.toDomain
        } catch {
            throw HGError.networkError(error)
        }
    }

    public func updateFCM(fcmToken: String) async throws {
        let parameters: HGParameters = [
            "fcmToken": fcmToken,
        ]
        let api = UpdateFcmAPI(parameters: parameters)
        
        do {
            guard let _ = try await network.send(api) else {
                throw HGError.domainError("dto model is nil")
            }
            
            return
        } catch {
            throw HGError.networkError(error)
        }
    }
    
    public func getProfileList() async throws -> [ProfileEntity] {
        let api = GetProfileListAPI(parameters: nil)
        
        do {
            guard let dtoModel = try await network.send(api) else {
                throw HGError.domainError("dto model is nil")
            }
            
            return dtoModel.data?.map { $0.toDomain } ?? []
        } catch {
            throw HGError.networkError(error)
        }
    }
    
    public func requestUserInfo() async throws(HGError) -> UserInfo {
        let api = UserInfoAPI()
        do {
            guard let dtoModel = try await network.send(api)?.data else {
                throw HGError.domainError("dto model is nil")
            }
            let domainModel = dtoModel.toDomain
            return domainModel
        } catch {
            throw HGError.networkError(error)
        }
    }
    
    public func requestUpdateUserInfo(
        nickname: String? = nil,
        profileImageCode: String? = nil,
        isReservationAlarm: Bool? = nil,
        isKokAlarm: Bool? = nil
    ) async throws -> StatusCode {
        let api = UserInfoUpdateAPI(
            nickname: nickname,
            profileImageCode: profileImageCode,
            isReservationAlarm: isReservationAlarm,
            isKokAlarm: isKokAlarm
        )
        do {
            guard let dtoModel = try await network.send(api) else {
                throw HGError.domainError("dto model is nil")
            }
            return 200
        } catch NetworkError.requestFailed(let statusCode) {
            return statusCode
        }
    }
}
