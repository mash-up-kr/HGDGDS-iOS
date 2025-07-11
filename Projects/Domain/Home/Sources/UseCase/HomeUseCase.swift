//
//  HomeUseCase.swift
//  HomeDomain
//
//  Created by 박병호 on 7/9/25.
//

import Foundation

public protocol HomeUseCase {
    func getReservationList(request: ReservationListRequest) async throws -> ReservationList
}

public class HomeUseCaseImpl: HomeUseCase {
    private let homeRepo: HomeRepository
    
    public init(homeRepo: HomeRepository) {
        self.homeRepo = homeRepo
    }
    
    public func getReservationList(request: ReservationListRequest) async throws -> ReservationList {
        try await homeRepo.getReservationList(request: request)
    }
}
