import Foundation

public class Tank {
    let right = Motor(pin1: 9, pin2: 10, pwm: 8, name: "Right")
    let left = Motor(pin1: 12, pin2: 11, pwm: 13, name: "Left")

    init() {
        print("Tank Created:")
        print(" Left: \(left)")
        print(" Right: \(right)")
    }

    public func drive() {
        print("Forward")
        left.forward()
        right.forward()
        sleep(1)
        stop()
    }

    public func turnLeft() {
        print("Left")
        left.backward()
        right.forward()
        sleep(1)
        stop()
    }

    public func turnRight() {
        print("Right")
        left.forward()
        right.backward()
        sleep(1)
        stop()
    }

    public func stop() {
        print("Stop")
        left.stop()
        right.stop()
    }
}
