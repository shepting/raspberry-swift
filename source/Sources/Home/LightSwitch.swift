import SwiftyGPIO

public struct LightSwitch {
    let pin13: GPIO
    let pin7: GPIO

    public init() {
        print("New light switch.")
        let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi3)
        pin13 = gpios[.P27]!
        pin7 = gpios[.P4]!
        pin13.direction = .OUT
        pin7.direction = .OUT
    }

    public func on() {
        pin13.value = 1
        pin7.value = 1
    }

    public func off() {
        pin13.value = 0
        pin7.value = 0
    }
}
