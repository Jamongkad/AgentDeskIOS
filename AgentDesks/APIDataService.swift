//
//  APIDataService.swift
//  AgentDesks
//
//  Created by Mathew Wong on 5/20/18.
//  Copyright © 2018 yidgetsoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData
import RxSwift

class APIDataService {

    let disposeBag = DisposeBag()
    let cacheTimer = CacheTimer()
    let coreDataService = APICoreDataService()

    init() {
        self.cacheTimer.startTimer()
        self.cacheTimer.signalChange
                .subscribe(onNext: { signalBool in
            if signalBool {
                let requestService = APIDataRequestService()
                requestService.requestDataFromAPI(completion: { () in
                    self.coreDataService.fetchData()
                })
            }
        })
    }

    func process() {
        self.coreDataService.fetchData()
    }
}
