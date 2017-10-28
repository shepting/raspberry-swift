
import Foundation
import SwiftyGPIO

func shortSleep() {
    usleep(100000)
}

public struct AnalogReader {
    let dataStore = DataStore()
    let i2c: SysFSI2C

    public init() {
        let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi3)!
        i2c = i2cs[1] as! SysFSI2C
    }

    public func readValue() {
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
        print("Value: \(value)")
        // let values = i2c.readData(0x48, command:0)
        // let high = value & 0xFF
        // let low = (value >> 8) & 0xFF

        // let value = i2c.readData(0x48, command: 0)
        // let high: UInt16 = UInt16(value[0]) << 8
        // let low: UInt16 = UInt16(value[1])
        // let calculated = Double(high | low) * 4096 / 32768.0
        // print("Calculated: \(calculated)")

        // print("Read: \(i2c.readWord(0x48, command: 0).hex())")
    }
}
