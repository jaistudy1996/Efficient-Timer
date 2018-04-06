//
//  LocationManagerScheduler.swift
//  VIPMobile
//
//  Created by Jayant Arora on 4/3/18.
//  Copyright © 2018 Vermont Information Processing. All rights reserved.
//

import Foundation

enum CurrentState {
    case running
    case suspended
}

@objc
public class JATimer: NSObject {

    private var name: String = ""
    private var initialized = false
    private var running: CurrentState = .suspended
    private var queue: DispatchQueue?
    private var timerForQueue: Int = 0
    private var block: () -> Void = { }

    private override init() {
        super.init()
    }

    @objc
    public convenience init(name: String, interval: Int, completion: (@escaping () -> Void)) {
        self.init()
        self.name = name
        self.timerForQueue = interval
        self.queue = DispatchQueue(label: name)
        self.block = completion
    }

    @objc
    public func getQueue() -> DispatchQueue? {
        guard let queue = self.queue else { return nil }
        return queue
    }

    @objc
    public func inititalize() {
        if let _ = self.getQueue() {
            timedBlock()
        }
        initialized = true
    }

    private func timedBlock() {
        queue?.asyncAfter(deadline: .now() + .seconds(timerForQueue)) {
            self.block()
            self.timedBlock()
        }
        print("Test: seconds: \(timerForQueue)")
    }

}

//
//import Foundation
//
//@objc
//public class LocationManagerScheduler: NSObject {
//    private static var frequentCounter = 0
//    private static var occasionalCounter = 0
//    private static let frequentInterval = DispatchQueue(label: "com.vtinfo.locationScheduler.Frequent")
//    private static let occasionalInterval = DispatchQueue(label: "com.vtinfo.locationScheduler.Occasional")
//
//    @objc
//    static var currentInterval: locationUpdateInterval = .occasional {
//        didSet {
//            guard currentInterval != oldValue else { return }
//
//            switch currentInterval {
//            case .frequent:
//                switchQueue()
//            case .occasional:
//                switchQueue()
//            case .none:
//                suspendAllQueues()
//            }
//        }
//    }
//
//    private class func switchQueue() {
//        if occasionalCounter == 0 {
//            occasionalInterval.suspend()
//            occasionalCounter -= 1
//
//            frequentInterval.resume()
//            frequentCounter = 1
//        }
//
//        if frequentCounter == 0 {
//            frequentInterval.suspend()
//            frequentCounter -= 1
//
//            occasionalInterval.resume()
//            occasionalCounter = 1
//        }
//    }
//
//    private class func suspendAllQueues() {
//        if occasionalCounter == 0 {
//            occasionalInterval.suspend()
//            occasionalCounter -= 1
//        }
//
//        if frequentCounter == 0 {
//            frequentInterval.suspend()
//            frequentCounter -= 1
//        }
//    }
//
//    private func frequentIntervalHandler() {
//        print("[LOC TEST] Frequent running")
//        LocationManagerScheduler.frequentInterval.asyncAfter(deadline: .now()  10) {
//            self.frequentIntervalHandler()
//        }
//    }
//
//    private func occassionalIntervalHandler() {
//        print("[LOC TEST] Occassional running")
//        LocationManagerScheduler.occasionalInterval.asyncAfter(deadline: .now()  30) {
//            self.occassionalIntervalHandler()
//        }
//    }
//
//    public override init() {
//        LocationManagerScheduler.frequentInterval.asyncAfter(deadline: .now()  10) {
//            self.frequentIntervalHandler()
//        }
//
//        LocationManagerScheduler.occasionalInterval.asyncAfter(deadline: .now()  30) {
//            self.occassionalIntervalHandler()
//        }
//
//
//    }
//}

