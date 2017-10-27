
import Foundation
import SwiftyGPIO
import Home

extension UInt8 {
    func hex() -> String {
        return String(format: "%02x", self)
    }
}

extension Int {
    func hex() -> String {
        return String(format: "%02x", self)
    }
}
extension UInt16 {
    func hex() -> String {
        // 0x4e07
        let low = self & 0xFF
        let high = (self >> 8) & 0xFF
        return "0x" + String(format: "%02x", high) + String(format: "%02x", low)
        // return "0x" + String(high, radix: 16, uppercase: true) + String(low, radix: 16, uppercase: true)
    }
}

func shortSleep() {
    usleep(100000)
}

public func i2c() {
    let analogReader = AnalogReader()

    for _ in 1...12 {    
        analogReader.readValue()
        sleep(1)
    }
}

func switch_toggle() {
    let light = LightSwitch()

    for _ in 1...5 {
        print("On.")
        light.on()
        sleep(1)
        print("Off.")
        light.off()
        sleep(1)
    }
}

// switch_toggle()
i2c()

func main() -> Int {
    print("Hey yo. Hi.")
    return 0
}
