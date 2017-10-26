
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
    let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi3)!
    let i2c = i2cs[1]



    // TODO: set measurement values
    for _ in 1...12 {    

        // sleep(1)

        // let values: [UInt8] = [0xC3, 0xA3]
        // let values: [UInt8] = [0xA3, 0xC3]
        // let values: [UInt8] = [195, 163]
        // print("195: ", 195.hex()) // c3
        // print("163: ", 163.hex()) // a3

        // i2cset 1 0x48 0x01 0xc3a3 w
        // i2cget 1 0x48 0x0 w // 0x3bf5
        // i2cdump 1 0x48 b

        // Write config data

        // let values = [195, 163]
        i2c.writeWord(0x48, command: 1, value: (195 << 8 | 163))
        // i2c.writeData(0x48, command: 1, values: [195, 163])
        // print("Write: \(i2c.writeData(0x48, command: 1, values:values))")
        // print("Write: \(i2c.writeWord(0x48, command: 1, value: 0xc3a5))")

        shortSleep()
        let value = i2c.readWord(0x48, command: 0)
        // let values = i2c.readData(0x48, command:0)
        // let high = value & 0xFF
        // let low = (value >> 8) & 0xFF

        // let value = i2c.readData(0x48, command: 0)
        // let high: UInt16 = UInt16(value[0]) << 8
        // let low: UInt16 = UInt16(value[1])
        // let calculated = Double(high | low) * 4096 / 32768.0
        // print("Calculated: \(calculated)")

        sleep(1)
        // print("Read: \(i2c.readWord(0x48, command: 0).hex())")
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

switch_toggle()
// i2c()

func main() -> Int {
    print("Hey yo. Hi.")
    return 0
}
