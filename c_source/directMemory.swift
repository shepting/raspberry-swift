//
// directMemory.swift
//

import Glibc

func with_mmap() {
    let file = open("/dev/mem", O_RDONLY | O_SYNC);
    guard (file >= 0) else {
        perror("Cannot open path")
        return
    }
    defer { close(file) }

    guard let rawPointer = mmap(nil, 1024 * 4, PROT_READ | PROT_WRITE, MAP_PRIVATE, file, 0x3f200000), rawPointer != UnsafeMutableRawPointer(bitPattern: -1) else {
        perror("Cannot mmap bytes for path")
        return
    }
    let basePointer: UnsafeMutablePointer<UInt32> = rawPointer.bindMemory(to: UInt32.self, capacity: 1024)

    basePointer.pointee = 0x1000
    print("Output type pointer \(basePointer) 0x\(String(basePointer.pointee, radix: 16, uppercase: false))")

    let setPointer = basePointer + 0x1C/4
    print("Set pointer: \(setPointer)")
    let clearPointer = basePointer + 0x28/4
    print("Clear pointer: \(clearPointer)")

    for i in 0...5 {
        print("High \(i) \(setPointer)")
        setPointer.pointee = 0x10
        sleep(1)
        print("Low \(clearPointer)")
        clearPointer.pointee = 0x10
        sleep(1)
    }
}

with_mmap()