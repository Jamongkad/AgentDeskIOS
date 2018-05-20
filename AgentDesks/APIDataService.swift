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

    //func process(completionHandler: @escaping (NSDictionary?, JSON?, Error?) -> ()) {
    init() {
        self.cacheTimer.startTimer()
        self.cacheTimer.signalChange
                .subscribe(onNext: { [weak self] signalBool in
            if signalBool {
                print("Blow Cache: ", signalBool)
                APIDataRequestService().requestDataFromAPI()
            }
        })
    }

    func process() -> NSMutableDictionary {
        return APICoreDataService().fetchData()
    }
}
