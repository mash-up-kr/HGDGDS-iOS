//
//  AppDelegate.swift
//  HGDGDS-iOS
//
//  Created by Enes on 5/20/25.
//

import UIKit

import HGCommon
import HGLogger
import FirebaseCore
import FirebaseMessaging
import UserDomain
import BranchSDK

final class AppDelegate: NSObject, UIApplicationDelegate {
    @Dependency private var keychain: KeychainManagerable
    @Dependency private var userUsecase: UserUseCase
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        configureBranchSDK(launchOptions: launchOptions)
        configureFireBase()
        
        Task {
            await configureNotification(application: application)
        }

        return true
    }
}

// MARK: - Branch.io 
extension AppDelegate {
    func configureBranchSDK(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        Branch.getInstance().initSession(launchOptions: launchOptions)
    }
}

// MARK: - Notification

extension AppDelegate: UNUserNotificationCenterDelegate {
    func configureNotification(application: UIApplication) async {
        UNUserNotificationCenter.current().delegate = self
        
        do {
            let didAuthorize = try await UNUserNotificationCenter
                .current()
                .requestAuthorization(options: [.alert, .sound, .badge])
            
            if didAuthorize {
                application.registerForRemoteNotifications()
                LoggerUtil.log("Notification authorization succeeded")
            } else {
                LoggerUtil.log("User denied notification permission")
            }
        } catch {
            LoggerUtil.log("Notification authorization failed: \(error.localizedDescription)")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.badge, .banner, .list, .sound]
    }
}

// MARK: - FCM

extension AppDelegate: MessagingDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        LoggerUtil.log("DeviceTokenString \(deviceTokenString)", level: .info)
    }
    
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        guard let fcmToken = fcmToken else { return }
        Task {
            try await keychain.addKeychain(key: .fcmToken, value: fcmToken)
            // TODO: [임시] 어디서 부를지 추후 논의하기
            await userUsecase.updateFCM()
        }
    }
}

// MARK: - Private Methods

private extension AppDelegate {
    func configureFireBase() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
}
