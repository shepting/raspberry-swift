#!/usr/bin/swift

import Foundation // for String(format, )
import Glibc // for mmap

func loopGPIO() {
    let file = open("/dev/mem", O_RDWR | O_SYNC);
    defer { close(file) }

    // Open the /dev/mem file (all memory) with read and write
    // privileges (we want to turn on output pins) at the proper
    // offset (we don't care about the rest of the addresses)
    // 0x3f200000
    guard let rawPointer = mmap(nil, 1024 * 4, PROT_READ | PROT_WRITE, MAP_SHARED, file, 0x3f200000) else {
        perror("Cannot mmap bytes for path")
        return
    }
    // This is a typed pointer to the root of the GPIO configuration 
    // registers. Pointer math will increment by 4 bytes at a time.
    let basePointer: UnsafeMutablePointer<UInt32> = rawPointer.bindMemory(to: UInt32.self, capacity: 30)

    // Configure GPIO pin 4 & 6 as output (3 bits/pin) 
    // pin numbers:           6  5  4  3  2  1  0
    basePointer.pointee = 0b001001000000000000000

    // Set up set/clear pointer objects
    // Offsets from docs were given in byte-size values
    // since our pointers are smart and expecting word 
    // size values we convert
    let setPointer = basePointer + 0x1C/4
    let clearPointer = basePointer + 0x28/4

    // Print the details for sanity sake
    print("Configuration Details")
    print("  address: \(basePointer)")
    print(String(format: "  format: 0x%X", basePointer.pointee))

    print("Set pointer: \(setPointer)")
    print("Clear pointer: \(clearPointer)")

    // Loop through and show the LED turning on and off
    for i in 0...5 {
        print("High \(setPointer)")
        setPointer.pointee = 0b1100000 // Pin 6 & 4
        usleep(500000)
        print("Counter: \(i)")
        print("Low \(clearPointer)")
        clearPointer.pointee = 0b1100000 // Pin 6 & 4
        usleep(500000)
    }
}

loopGPIO()