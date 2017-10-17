//
// directMemory.swift
//

import Glibc

func with_mmap(_ path: String, protection: Int32 = PROT_READ, flags: Int32 = MAP_PRIVATE, process: (UnsafeMutableRawPointer, Int) -> Void) {
    let file = open(path, O_RDONLY);
    guard (file >= 0) else {
        perror("Cannot open \(path)")
        return
    }
    defer { close(file) }
    print(file)
    // guard let length = file_len(file) else {
    //     perror("Cannot get length of \(path)")
    //     return
    // }
    let length = 100
    guard let mem = mmap(nil, length, protection, flags, file, 0), mem != UnsafeMutableRawPointer(bitPattern: -1) else {
        perror("Cannot mmap \(length) bytes for \(path)")
        return
    }
    defer { munmap(mem, length) }
    process(mem, length)
}

func open_registers() {
    with_mmap("/dev/mem") { (pointer: UnsafeMutableRawPointer, length: Int) in
    print("Inside: \(pointer)")
    }
}

open_registers()