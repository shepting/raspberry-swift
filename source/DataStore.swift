import Foundation

public class DataStore {
    var data = [Date: Float]()

    func saveValue(_ value: Float) {
        let date = Date()
        data[date] = value
        print(data)
    }

    func writeData() {
        let bundle = Bundle(for: DataStore.self)
        let bundleURL = bundle.bundleURL
        if #available(OSX 10.11, *) {
            let dataLogURL = URL(fileURLWithPath: "data.plist", relativeTo:bundleURL)
            print(dataLogURL)
            print(dataLogURL.path)wwqc  d

            let data_copy = data as NSDictionary
            print(data_copy)
            data_copy.write(to: dataLogURL, atomically: true)

        }
        // print(Bundle())
        // print(Bundle.allBundles)
        // let url = Bundle.main
        // print(url)
    }
}
