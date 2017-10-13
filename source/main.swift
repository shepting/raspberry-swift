
// import Foundation
// import SwiftyGPIO

public func i2c_detect() {
  let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi3)!
  let i2c = i2cs[1]

  print("Detecting devices on the I2C bus:\n")
  outer: for i in 0x0...0x7 {
      if i == 0 {
          print("    0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f")
      }
      for j in 0x0...0xf {
          if j == 0 {
              print(String(format:"%x0",i), terminator: "")
          }
          // Test within allowed range 0x3...0x77
          if (i==0) && (j<3) {print("   ", terminator: "");continue}
          if (i>=7) && (j>=7) {break outer}

          print(" \(i2c.isReachable(i<<4 + j) ? " x" : " ." )", terminator: "")
      }
      print()
  }
  print("\n")
}

public func i2c() {
  let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi3)!
  print("I2C's \(i2cs)")
  let i2c = i2cs[1]
  i2c.setPEC(0x45, enabled: True)

  // print("Read.")
  // print("Read: \(i2c.readByte(0x45))")
  // print("Read: \(i2c.readByte(0x45))")
  // sleep(0.1)
  // print("Read: \(i2c.readByte(0x45))")

  print("Write.")
  // i2c.setPEC(0x45, enabled: true)
  // let array: [UInt8] = [0x2C, 0x06]
  // print("Writing: \(i2c.writeData(0x45, command: 0, values:array))")
  // print("Writing: \(i2c.writeWord(0x45, command: 0, value:0x062C))")
  print("Writing: \(i2c.writeWord(0x45, command: 0, value:0x2C06))")


  // sleep(0.1)
  // print("Writing: \(i2c.writeByte(0x45 , value:0x06))")

  // Reading register 0 of the device with address 0x68
  print("Read: \(i2c.readWord(0x45, command: 0))")
  // Reading register 1 of the device with address 0x68
  // print("Register 1" + i2c.readByte(0x45, command: 1))

}


i2c_detect()

i2c()

func main() -> Int {


    print("Hey yo. Hi.")
    return 0
}
