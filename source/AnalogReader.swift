
import Foundation

public struct AnalogReader {

    public init() {

    }

    public func beginReading() {
        for _ in 0..<3 {
            read()
            sleep(1)
        }
    }

    func read() {
        print("Reading")
    }
}
