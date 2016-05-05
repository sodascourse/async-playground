//: # Asynchronous Tasks

import Foundation
import XCPlayground

// Set this property to make the Playground keep executing for async tasks
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//:
//: ## Using `libdispatch`
//:
//: Try to uncomment some lines of code if you think the output is too tedious to read.
//:
//: ### Create queues
//:
//: Use QOS attribute to set the priority of your custom queues.

// Use global queue from OS
let defaultGlobalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
let userInteractiveQueue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
let mainQueue = dispatch_get_main_queue()
// Create custom queue
let mySerialQueue = dispatch_queue_create("tw.sodas.myqueue", DISPATCH_QUEUE_SERIAL)
let qos = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1)
let mySerailLowQueue = dispatch_queue_create("tw.sodas.myqueue-low", qos)

//:
//: ### Using `dispatch_async` and **global queues**
//:
//: The `dispatch_async` function just enqueues your task (closure) into specified dispatch queue.
//: It doesn't wait for the task completion.
//:

//print("01: Start: \(NSDate().timeIntervalSince1970)")
//dispatch_async(defaultGlobalQueue) {
//    sleep(1)  // C's sleep call to make current thread sleep
//    NSThread.isMainThread()
//    print("01: Async: \(NSDate().timeIntervalSince1970)")
//}
//print("01: After: \(NSDate().timeIntervalSince1970)")

//: ### Using `dispatch_sync` and **global queues**
//:
//: The `dispatch_sync` function enqueues your task (closure) into specified dispatch queue and
//: wait for the task completion.
//:
//: NOTE: be careful about the dead lock issue when using `dispatch_sync` and serial queues
//:

//print("02: Start: \(NSDate().timeIntervalSince1970)")
//dispatch_sync(defaultGlobalQueue) {
//    sleep(1)  // C's sleep call to make current thread sleep
//    print("02: Sync:  \(NSDate().timeIntervalSince1970)")
//}
//print("02: After: \(NSDate().timeIntervalSince1970)")

//: ## Using `Async` library

print("03: Start: \(NSDate().timeIntervalSince1970)")
Async.background {
    sleep(1)  // C's sleep call to make current thread sleep
    print("03: Async-Background: \(NSDate().timeIntervalSince1970)")
}.main {
    print("03: Async-Main: \(NSDate().timeIntervalSince1970)")
}.userInitiated {
    print("03: Async-High: \(NSDate().timeIntervalSince1970)")
}
print("03: After: \(NSDate().timeIntervalSince1970)")

//: ### dispatch_group with Async lib

//let taskGroup = AsyncGroup()
//print("group: Start: \(NSDate().timeIntervalSince1970)")
//taskGroup.userInitiated { 
//    sleep(2)
//    print("group: First task done: \(NSDate().timeIntervalSince1970)")
//}
//taskGroup.background { 
//    sleep(1)
//    print("group: Second task done: \(NSDate().timeIntervalSince1970)")
//}
//taskGroup.wait()
//print("group: Finished: \(NSDate().timeIntervalSince1970)")
