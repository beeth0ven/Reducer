//
//  ReducerTests.swift
//  ReducerTests
//
//  Created by luojie on 2017/10/26.
//  Copyright © 2017年 luojie. All rights reserved.
//

import XCTest
@testable import Reducer

class ReducerTests: XCTestCase {
    
    
    func testExample() {
        
        struct Increase: Action {}
        struct Decrease: Action {}
        
        let numberStore = Store<Int>(
            state: 0,
            reducer: { (state, action) in
                switch action {
                case _ as Increase:
                    return state + 1
                case _ as Decrease:
                    return state - 1
                default:
                    return state
                }
        })
        
        struct Toggle: Action {}
        
        let boolStore = Store<Bool>(
            state: false,
            reducer: { (state, action) in
                switch action {
                case _ as Toggle:
                    return !state
                default:
                    return state
                }
        })
        
        let composeStore = ComposeStore(store0: numberStore, store1: boolStore)
        
        numberStore.subscribe { (state) in
            print("Number State:", state)
        }
        
        boolStore.subscribe { (state) in
            print("Bool State:", state)
        }
        
        composeStore.subscribe { (state) in
            print("Compose State:", state)
        }
        
        print("--------Increase--------")
        numberStore.dispatch(action: Increase())
        print("--------Decrease--------")
        numberStore.dispatch(action: Decrease())
        print("--------Toggle--------")
        boolStore.dispatch(action: Toggle())
        print("--------Compose Toggle--------")
        composeStore.dispatch(action: Toggle())
        print("--------End--------")

    }
    
    
}
