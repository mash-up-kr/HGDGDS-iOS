//
//  MyPageRepositoryImpl.swift
//  MyPage
//
//  Created by 김남수 on 25/06/14.
//

import Foundation
import MyPageDomain
import HGNetwork
import HGCommon

public final class MyPageRepositoryImpl: MyPageRepository {
    private let network: any Networkable
    
    public init(network: any Networkable) {
        self.network = network
    }
    
    public func requestUserInfo() async throws(HGError) -> UserInfo {
        let api = UserInfoAPI()
        do {
            guard let dtoModel = try await network.send(api) else {
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
