import Foundation

public class DataStore {
    var data = [Date: Float]()

    func saveValue(_ value: Float) {
        let date = Date()
        data[date] = value
        print(data)
    }
}
