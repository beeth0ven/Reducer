//
//  Reducer.swift
//  Reducer
//
//  Created by luojie on 2017/10/26.
//  Copyright © 2017年 luojie. All rights reserved.
//

import Foundation

public protocol Action {}
public typealias Reducer<State> = (State, Action) -> State
public typealias Observer<State> = (State) -> ()

public class Store<State> {
    
    fileprivate var _state: State
    private let _reducer: Reducer<State>
    private var _observers: [Observer<State>] = []
    
    public init(state: State, reducer: @escaping Reducer<State>) {
        _state = state
        _reducer = reducer
    }
    
    public func dispatch(action: Action) {
        _state = _reducer(_state, action)
        _observers.forEach { $0(_state) }
    }
    
    public func subscribe(_ observer: @escaping Observer<State>) {
        _observers.append(observer)
    }
}

public class ComposeStore<State0, State1> {
    
    public typealias State = (State0, State1)
    public var stores: (Store<State0>, Store<State1>)
    private var _observers: [Observer<State>] = []
    private var _state: State { return (stores.0._state, stores.1._state) }
    
    public init(store0: Store<State0>, store1: Store<State1>) {
        stores = (store0, store1)
    }
    
    public func dispatch(action: Action) {
        stores.0.dispatch(action: action)
        stores.1.dispatch(action: action)
        _observers.forEach { $0(_state) }
    }
    
    public func subscribe(_ observer: @escaping Observer<State>) {
        _observers.append(observer)
    }
}
