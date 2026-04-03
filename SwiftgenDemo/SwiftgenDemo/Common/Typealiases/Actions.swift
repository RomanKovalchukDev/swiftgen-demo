//
//  Actions.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Foundation

typealias EmptyAction = () -> Void
typealias BoolAction = (Bool) -> Void
typealias OptionalBoolAction = (Bool?) -> Void
typealias TextAction = (String) -> Void
typealias OptionalTextAction = (String?) -> Void
typealias StringArrayAction = ([String]) -> Void
typealias URLAction = (URL) -> Void
typealias ErrorAction = (Error) -> Void
typealias IntAction = (Int) -> Void
typealias OptionalIntAction = (Int?) -> Void
typealias IntArrayAction = ([Int]) -> Void
typealias DoubleAction = (Double) -> Void
typealias DataAction = (Data) -> Void
typealias DataArrayAction = ([Data]) -> Void
typealias DateAction = (Date) -> Void
typealias TimeIntervalAction = (TimeInterval) -> Void
typealias FloatAction = (Float) -> Void
