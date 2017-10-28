import SwiftyGPIO

public struct LightSwitch {
    let gpio4: GPIO // LED
    let gpio6: GPIO // Relay

    public init?() {
        print("New light switch.")
        let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi3)
        guard let gpio4 = gpios[.P4] else { print("Invalid GPIO: .P4"); return nil }
        self.gpio4 = gpio4
        guard let gpio6 = gpios[.P6] else { print("Invalid GPIO: .P6"); return nil }
        self.gpio6 = gpio6
        gpio4.direction = .OUT
        gpio6.direction = .OUT
    }

    public func on() {
        gpio4.value = 1
        gpio6.value = 1
    }

    public func off() {
        gpio4.value = 0
        gpio6.value = 0
    }
}
