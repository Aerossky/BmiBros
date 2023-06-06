//
//  iOSConnectivityManager.swift
//  BmiBros
//
//  Created by MacBook Pro on 06/06/23.
//

import Foundation
import WatchConnectivity

final class iOSConnectivityManager: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = iOSConnectivityManager()
    private var id : String = ""

    override init() {
        super.init()
        activateSession()
    }

    private func activateSession() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle activation completion if needed
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        // Handle session becoming inactive if needed
    }

    func sessionDidDeactivate(_ session: WCSession) {
        // Handle session deactivation if needed
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        // Handle received application context if needed
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Handle received message if needed
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        // Handle received message with reply handler if needed
    }

    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        // Handle received message data if needed
    }

    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        // Handle received message data with reply handler if needed
    }

    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        // Handle received file if needed
    }

    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        // Handle file transfer completion if needed
    }

    func sendID(userID: String) {
        let session = WCSession.default
        if session.isReachable {
            let message = ["userID": userID]
            do {
                try session.updateApplicationContext(message)
            } catch {
                print("Error sending message: (error.localizedDescription)")
            }
        }
    }
    
    func sendBMI(bmi: Double) {
        let session = WCSession.default
        if session.isReachable {
            let message = ["bmi": bmi]
            do {
                try session.updateApplicationContext(message)
            } catch {
                print("Error sending message: (error.localizedDescription)")
            }
        }
    }
    
    func sendCal(cal: Double) {
        let session = WCSession.default
        if session.isReachable {
            let message = ["cal": cal]
            do {
                try session.updateApplicationContext(message)
            } catch {
                print("Error sending message: (error.localizedDescription)")
            }
        }
    }
}
