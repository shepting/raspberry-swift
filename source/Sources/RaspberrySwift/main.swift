//
// main.swift
//

import Foundation
import SwiftyGPIO
import Home

public func i2c() {
    let analogReader = AnalogReader()

    for _ in 1...12 {    
        analogReader.readValue()
        sleep(1)
    }
}

func switch_toggle() {
    guard let light = LightSwitch() else { print("Failed to create switch"); return }

    for _ in 1...5 {
        print("On.")
        light.on()
        sleep(1)
        print("Off.")
        light.off()
        sleep(1)
    }
}

switch_toggle()
//i2c()

func main() -> Int {
    print("Main")
    return 0
}
