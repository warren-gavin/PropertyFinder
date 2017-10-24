//
//  NetworkIndicator.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import UIKit

/**
 *  Helper class that shows the network activity indicator when the network is busy
 *
 *  This can be used with concurrent network operations and will keep the activity
 *  indicator running until the last of the operations finishes
 */
public struct NetworkIndicator {
    static private var counter = 0
    static var mutex = pthread_mutex_t()
    
    public static func startNetworkActivity() {
        self.setNetworkActivity(true)

        pthread_mutex_lock(&mutex)
        self.counter += 1
        pthread_mutex_unlock(&mutex)
    }
    
    public static func stopNetworkActivity() {
        defer {
            pthread_mutex_unlock(&mutex)
        }

        pthread_mutex_lock(&mutex)

        guard self.counter > 0 else {
            self.setNetworkActivity(false)
            return
        }
        
        self.counter -= 1
        self.setNetworkActivity(self.counter != 0)
    }
    
    static private func setNetworkActivity(_ active: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = active
        }
    }
}
