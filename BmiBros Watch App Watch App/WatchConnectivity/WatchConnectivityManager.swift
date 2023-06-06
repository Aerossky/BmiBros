//
//  WatchConnectivityManager.swift
//  BmiBros
//
//  Created by MacBook Pro on 06/06/23.
//

import Foundation
import WatchConnectivity

final class WatchConnectivityManager: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = WatchConnectivityManager()
    @Published var loggedUserID : String = ""
    @Published var bmi : Double = 0.0
    @Published var calories : Double = 0.0
    override init(){
        
        super.init()
        
        
        if WCSession.isSupported(){
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    
    
//    func send
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {}
    
    func session(_ session: WCSession,
                 didReceiveApplicationContext applicationContext: [String : Any]){
        DispatchQueue.main.async {
            if let userID = applicationContext["userID"] as? String{
                self.loggedUserID = userID
            }
            
            if let bmi = applicationContext["bmi"] as? Double{
                self.bmi = bmi
            }
            
            if let calories = applicationContext["cal"] as? Double{
                self.calories = calories
            }
        }
    }
    

//    func sessionDidBecomeInactive(_ session: WCSession) {
//        // Handle session becoming inactive if needed
//    }
//
//    func sessionDidDeactivate(_ session: WCSession) {
//        // Handle session deactivation if needed
//    }


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
}

