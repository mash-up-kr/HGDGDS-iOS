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

final class AppDelegate: NSObject, UIApplicationDelegate {
    private let keychain: KeychainManager = .init()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        Task {
            await configureNotification(application: application)
            configureFireBase()
        }

        return true
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
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
}

// MARK: - FCM

extension AppDelegate: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        Task {
            guard let fcmToken = fcmToken else { return }
            try await keychain.addKeychain(key: .fcmToken, value: fcmToken)
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
