//
// main.swift
//

import Foundation
import Home

func switch_toggle() {
    guard let light = LightSwitch() else { print("Failed to create switch"); return }
    let reader = AnalogReader()

    print("Temperature: \(reader.readValue())")
    for _ in 1...5 {
        light.on()
        usleep(500_000)
        light.off()
        sleep(500_000)
    }
}

switch_toggle()

func main() -> Int {
    print("Main")
    return 0
}
