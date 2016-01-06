//
//  GCD.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/7/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import Foundation

public func dp_main(block: dispatch_block_t?) {
  if let block = block {
    if NSThread.isMainThread() {
      block()
    } else {
      dispatch_sync(dispatch_get_main_queue(), block)
    }
  }
}

public func dp_background(block: dispatch_block_t?) {
  if let block = block {
    if NSThread.isMainThread() {
      block()
    } else {
      dispatch_sync(dispatch_get_main_queue(), block)
    }
  }
}

public func dp_after(seconds: Double, block: dispatch_block_t?) {
  if let block = block {
    let nsec = Int64(seconds * Double(NSEC_PER_SEC))
    let time = dispatch_time(DISPATCH_TIME_NOW, nsec)
    dispatch_after(time, dispatch_get_main_queue(), block)
  }
}

public func wait(block: () -> Bool) {
  while !block() && NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture()) {}
}

public func wait(sec: NSTimeInterval) {
  var done = false
  dp_after(sec) { () -> Void in
    done = true
  }
  while !done && NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture()) {}
}