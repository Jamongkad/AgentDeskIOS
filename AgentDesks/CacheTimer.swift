//
// Created by Mathew Wong on 5/20/18.
// Copyright (c) 2018 yidgetsoft. All rights reserved.
//

import Foundation
import RxSwift

class CacheTimer {

    var timer: Timer?
    private let signal = Variable(false)
    var signalChange:Observable<Bool> {
        return signal.asObservable()
    }

    func startTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: AppConstants.refreshTimeInSeconds, target: self, selector: #selector(blowCache), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }

    @objc func blowCache() {
        self.signal.value = true
    }

    deinit {
        self.stopTimer()
    }
}
