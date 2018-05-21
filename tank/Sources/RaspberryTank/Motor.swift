import Foundation 
import SwiftyGPIO

enum level {
    case LOW
    case HIGH
}

let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi3)!
let i2c = i2cs[1]
let MOTOR_HAT_ADDRESS = 0x6f


// Registers/etc.
let __MODE1             : UInt8 = 0x00
let __MODE2             : UInt8 = 0x01
let __SUBADR1           : UInt8 = 0x02
let __SUBADR2           : UInt8 = 0x03
let __SUBADR3           : UInt8 = 0x04
let __PRESCALE          : UInt8 = 0xFE
let __LED0_ON_L         : UInt8 = 0x06
let __LED0_ON_H         : UInt8 = 0x07
let __LED0_OFF_L        : UInt8 = 0x08
let __LED0_OFF_H        : UInt8 = 0x09
let __ALL_LED_ON_L      : UInt8 = 0xFA
let __ALL_LED_ON_H      : UInt8 = 0xFB
let __ALL_LED_OFF_L     : UInt8 = 0xFC
let __ALL_LED_OFF_H     : UInt8 = 0xFD
 
// Bits
let __RESTART: UInt8            = 0x80
let __SLEEP: UInt8              = 0x10
let __ALLCALL: UInt8            = 0x01
let __INVRT: UInt8              = 0x10
let __OUTDRV: UInt8             = 0x04

func startPWM() {
    print("Starting PWM")
    print(" - Reachable: \(i2c.isReachable(0x6f))")
    print(" - I2Cs: \(i2cs)")

    // setAllPWM(on: 0, off: 0)
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __MODE2, value: __OUTDRV)
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __MODE1, value:__ALLCALL)
    usleep(50)                             //  wait for oscillator
    var mode1 = i2c.readByte(MOTOR_HAT_ADDRESS, command: __MODE1)
    print(" - Read byte: \(mode1)")
    mode1 = mode1 & ~__SLEEP                 // wake up (reset sleep)
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __MODE1, value: mode1)
    usleep(50)                             //  wait for oscillator

    setPWMFreq(1600)
}

    //"Sets a single PWM channel"
func setPWM(_ channel: UInt8, _ on: UInt16, _ off: UInt16) {
    print("     - Set PWM: \(channel) on: \(on) off: \(off)")

    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __LED0_ON_L+4*channel, value:  UInt8(on & 0xFF))
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __LED0_ON_H+4*channel, value:  UInt8(on >> 8))
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __LED0_OFF_L+4*channel, value: UInt8(off & 0xFF))
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __LED0_OFF_H+4*channel, value: UInt8(off >> 8))
}

// "Sets a all PWM channels"
func setAllPWM(on: UInt16, off: UInt16) {
    print(" - Set all PWM")
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __ALL_LED_ON_L, value: UInt8(on & 0xFF))
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __ALL_LED_ON_H, value: UInt8(on >> 8))
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __ALL_LED_OFF_L, value: UInt8(off & 0xFF))
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __ALL_LED_OFF_H, value: UInt8(off >> 8))
}

//"Sets the PWM frequency"
func setPWMFreq(_ freq: Int) {
    var prescaleval = 25000000.0    // 25MHz
    prescaleval /= 4096.0       // 12-bit
    prescaleval /= Double(freq)
    prescaleval -= 1.0
    print("Setting PWM frequency to \(freq) Hz")
    print(" - Estimated pre-scale: \(prescaleval)")
    let prescale = floor(prescaleval + 0.5)
    print(" - Final pre-scale: \(prescale)")
    let oldmode: UInt8 = i2c.readByte(MOTOR_HAT_ADDRESS, command: __MODE1);
    print(" - Old mode: \(oldmode)")
    let newmode: UInt8 = (oldmode & 0x7F) | 0x10             // sleep
    print(" - New mode: \(newmode)")
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __MODE1, value: newmode)        // go to sleep
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __PRESCALE, value: UInt8(floor(prescale)))
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __MODE1, value: oldmode)
    usleep(50)
    i2c.writeByte(MOTOR_HAT_ADDRESS, command: __MODE1, value: oldmode | 0x80)
}

public struct Motor {
    let pin1: UInt8
    let pin2: UInt8
    let pwm: UInt8 

    public func backward() {
        print(" - Forward")
        setPin(pin2, .LOW)
        setPin(pin1, .HIGH)
    }

    public func forward() {
        print(" - Backward")
        setPin(pin1, .LOW)
        setPin(pin2, .HIGH)
    }

    public func stop() {
        print(" - Stop")
        setPin(pin1, .LOW)
        setPin(pin2, .LOW)
    }

    public func release() {
        print(" - Release")
        setPin(pin1, .LOW)
        setPin(pin2, .LOW)
    }

    public func setSpeed(_ speed: UInt16) {
        print("  - Set speed: \(speed)")
        // MC->setPWM(PWMpin, speed*16);
        setPWM(pwm, 0, speed*16)
    }

    func setPin(_ pin: UInt8, _ level: level) {
        print("   - Set pin: \(pin) \(level)")
        //  MC->setPin(IN1pin, HIGH);
        let value: UInt16 = (level == .HIGH) ? 4096 : 0
        setPWM(pin, value, 0)
    }
}
