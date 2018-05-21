import SwiftyGPIO

public struct LightSwitch {
    let ledPin: GPIO // LED
    let relayPin: GPIO // Relay

    public init?() {
        // Create the pins
        let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi3)
        guard let ledPin = gpios[.P5] else { print("Invalid GPIO: .P5"); return nil }
        guard let relayPin = gpios[.P6] else { print("Invalid GPIO: .P6"); return nil }
        self.ledPin = ledPin
        self.relayPin = relayPin

        // Set the pins to be outputs
        ledPin.direction = .OUT
        relayPin.direction = .OUT
    }

    // Turn all of the pins on
    public func on() {
        print("🌕 On")
        ledPin.value = 1
        relayPin.value = 1
    }

    // Turn all of the pins off
    public func off() {
        print("🌒 Off")
        ledPin.value = 0
        relayPin.value = 0
    }
}


