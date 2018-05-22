import SwiftyGPIO

private let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi3)!
private let i2c = i2cs[1]

// Registers/etc.
let ADDRESS: Int = 0x6f
let ON_L: UInt8 = 0x06
let ON_H: UInt8 = 0x07
let OFF_L: UInt8 = 0x08
let OFF_H: UInt8 = 0x09

//"Sets a single PWM channel"
func setPWM(_ channel: UInt8, _ on: UInt16, _ off: UInt16) {
    // print("     - Set PWM: \(channel) on: \(on) off: \(off)")
    i2c.writeByte(ADDRESS, command: ON_L + 4 * channel, value:  UInt8(on & 0xFF))
    i2c.writeByte(ADDRESS, command: ON_H + 4 * channel, value:  UInt8(on >> 8))
    i2c.writeByte(ADDRESS, command: OFF_L + 4 * channel, value: UInt8(off & 0xFF))
    i2c.writeByte(ADDRESS, command: OFF_H + 4 * channel, value: UInt8(off >> 8))
}

public struct Motor {
    let pin1: UInt8
    let pin2: UInt8
    let pwm: UInt8 
    let name: String

    enum level {
        case LOW
        case HIGH
    }

    public func backward() {
        print(" \(name) ⇒ Backward")
        setPin(pin2, .LOW)
        setPin(pin1, .HIGH)
    }

    public func forward() {
        print(" \(name) ⇒ Forward")
        setPin(pin1, .LOW)
        setPin(pin2, .HIGH)
    }

    public func stop() {
        print(" \(name) ⇒ Stop")
        setPin(pin1, .LOW)
        setPin(pin2, .LOW)
    }

    public func setSpeed(_ speed: UInt16) {
        // print("  - Set speed: \(speed)")
        setPWM(pwm, 0, speed*16)
    }

    func setPin(_ pin: UInt8, _ level: level) {
        // print("   - Set pin: \(pin) \(level)")
        let value: UInt16 = (level == .HIGH) ? 4096 : 0
        setPWM(pin, value, 0)
    }
}
