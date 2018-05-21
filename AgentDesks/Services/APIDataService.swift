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
    let dataRequestService = APIDataRequestService()

    init() {
        self.cacheTimer.startTimer()
        self.cacheTimer.signalChange
                .subscribe(onNext: { signalBool in
            if signalBool {
                //if timer is done request a fresh batch of data from the API
                print("Request New Batch")
                self.requestData()
            }
        })
    }

    func process() {
        self.requestData()
    }

    private func requestData() {
        self.dataRequestService.requestDataFromAPI(completion: { () in
            self.coreDataService.fetchData()
        })
    }
}
