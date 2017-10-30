
import Foundation
import SwiftyGPIO
import DS18B20

func shortSleep() {
    usleep(100000)
}

public struct AnalogReader {
    let ds: DS18B20
    public init() {
        let onewires = SwiftyGPIO.hardware1Wires(for:.RaspberryPi3)!
        print("One wires: \(onewires)")
        let onewire = onewires[0]
        // let slaveId = onewire.getSlaves()[]
        print("Slaves: \(onewire.getSlaves())")
        ds = DS18B20(onewire, slaveId: "28-0000097eb360")
        // GPIO16
    }

    public func readValue() -> Float {
        return ds.Temperature
    }
}
