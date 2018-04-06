//
//  LocationManagerScheduler.swift
//  VIPMobile
//
//  Created by Jayant Arora on 4/3/18.
//  Copyright © 2018 Vermont Information Processing. All rights reserved.
//

import Foundation

@objc
public enum CurrentState: Int {
    case running
    case suspended
}

@objc
public class JATimer: NSObject {

    // MARK: Private Properties

    private var name: String = ""
    private var initialized = false
    private var timerState: CurrentState = .suspended
    private var queue: DispatchQueue?
    private var timerForQueue: Int = 0
    private var block: () -> Void = { }

    private override init() {
        super.init()
    }

    // MARK: Public Properties

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

    deinit {
        queue = nil
    }

    /// This function needs to be called to initialize timer after instantiation
    @objc
    public func inititalize() {
        if let _ = self.getQueue() {
            timedBlock()
        }
        initialized = true
        timerState = .running
    }

    @objc
    public func isInitialized() -> Bool{
        return initialized
    }

    @objc
    public func getCurrentState() -> CurrentState {
        return timerState
    }

    @objc
    public func pause() {
        guard initialized == true else {
            fatalError("Timer needs to be initialized before you can pause it.")
        }
        guard timerState == .running else {
            fatalError("Attempt to pause timer when it is already paused.")
        }
        queue?.suspend()
        timerState = .suspended
    }

    @objc
    public func resume() {
        guard initialized == true else {
            fatalError("Timer needs to be initialized before you can reusme it.")
        }
        guard timerState == .suspended else {
            fatalError("Attempt to resume timer when it is already running.")
        }
        queue?.resume()
        timerState = .running
    }

    // MARK: Private Properties

    private func timedBlock() {
        queue?.asyncAfter(deadline: .now() + .seconds(timerForQueue)) {
            self.block()
            self.timedBlock()
        }
        print("Timed Block set up")
    }

}
