
import Foundation

public struct AnalogReader {
    let dataStore = DataStore()

    public init() {

    }

    public func beginReading() {
        for _ in 0..<3 {
            let temp = read()
            dataStore.saveValue(temp)
            sleep(1)
        }
    }

    func read() -> Float {
        print("Reading")
        return 72.1
    }
}
