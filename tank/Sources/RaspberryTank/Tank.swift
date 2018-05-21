
import Foundation



public class Tank {
    let name = "Tank2"
    let left = Motor(pin1: 9, pin2: 10, pwm: 8)
    let right = Motor(pin1: 12, pin2: 11, pwm: 13)

    public func drive() {
        print("Driving forward")
        print(" - Left: \(left)")
        print(" - Right: \(right)")
        left.setSpeed(150)
        right.setSpeed(150)
        usleep(500)
        left.forward()
        right.forward()
    }

    public func stop() {
        left.stop()
        right.stop()
    }
}
