
require_relative 'tooling/SwiftBuild.rb'

def system_and_log(message)
  gray = 37
  puts "\e[#{gray}m#{message}\e[0m"
  system message
end

def log(message)
  blue_color_code = 34
  puts "\e[#{blue_color_code}m#{message}\e[0m"
  system message
end

task :default do
    system 'rake --tasks'
end

desc 'Build the project'
task :build do
    puts 'Building project'
    build_home
    build_main
end

desc 'Clean the intermediate build files'
task :clean do
    SwiftBuild.clean
end

desc 'Build on Linux'
task :linux do
    system_and_log 'swiftc -j4 \
    source/SwiftyGPIO/Mailbox.swift source/SwiftyGPIO/SunXi.swift source/SwiftyGPIO/UART.swift source/SwiftyGPIO/I2C.swift  source/SwiftyGPIO/Presets.swift source/SwiftyGPIO/SwiftyGPIO.swift source/main.swift -o build/main -v'
    system_and_log './build/main'
end

def build_all
  system 'swiftc -module-cache-path build source/SwiftyGPIO/Mailbox.swift source/SwiftyGPIO/SunXi.swift       source/SwiftyGPIO/UART.swift source/SwiftyGPIO/I2C.swift  source/SwiftyGPIO/Presets.swift  source/SwiftyGPIO/SwiftyGPIO.swift source/i2cdetect.swift source/main.swift -o build/i2cdetect -v -Xlinker -v'
end

def build_gpio
  # system_and_log 'swiftc source/SwiftyGPIO/Mailbox.swift -emit-object'
  system_and_log 'swiftc source/SwiftyGPIO/Mailbox.swift source/SwiftyGPIO/SunXi.swift source/SwiftyGPIO/UART.swift source/SwiftyGPIO/I2C.swift  source/SwiftyGPIO/Presets.swift source/SwiftyGPIO/SwiftyGPIO.swift \
   -v -Xlinker -v -module-name SwiftyGPIO -emit-module-path build/SwiftyGPIO.swiftmodule'
   # -emit-object -emit-library
  # -emit-module \
  # -module-name SwiftyGPIO \
  # -emit-module-path build/SwiftyGPIO.swiftmodule \
  # -v -Xlinker -v'
end

def build_main
  system_and_log 'swiftc source/main.swift -module-link-name SwiftyGPIO -I build -v -Xlinker -v'
  # -lSwiftyGPIO -o source/i2c \ -emit-object
  # -Xlinker -add_ast_path -Xlinker build/SwiftyGPIO.swiftmodule'
end

def build_with_module
  # First, compile the Foo.swiftmodule and libFoo.dylib that the executable depends upon.
  system_and_log 'mkdir -p build/gpio-out'
  system_and_log 'swiftc \
    -Onone -c -j4 source/SwiftyGPIO/Mailbox.swift \
    source/SwiftyGPIO/SunXi.swift source/SwiftyGPIO/UART.swift \
    source/SwiftyGPIO/I2C.swift  source/SwiftyGPIO/Presets.swift \
    source/SwiftyGPIO/SwiftyGPIO.swift \
    -emit-module -emit-module-path build/gpio-out/SwiftyGPIO.swiftmodule \
    -module-name SwiftyGPIO \
    -emit-library -o build/gpio-out/libSwiftyGPIO.so -v'

    # Then, compile the main executable.
  system_and_log 'mkdir -p build/main-out'
  system_and_log 'swiftc \
    -Onone -c -j4 source/main.swift \
    -emit-module -emit-module-path build/main-out/Main.swiftmodule \
    -module-name Main -module-link-name Main \
    -Ibuild/gpio-out -v\
    -emit-library -o build/main-out/main.o'

  # Link the final executable.
  system_and_log 'clang \
    build/main-out/main.o \
    -o build/main-out/Main \
    -I build \
    -L/home/steven/workspace/raspberry-swift/build/gpio-out -lSwiftyGPIO -v'

end

task :build_and_run do
  log 'Building'
  system_and_log 'swift build'

  log 'Running'
  system_and_log '.build/debug/RaspberrySwift'
end


task :i2c do
  build_with_module

  # Execute the executable.
  # system 'DYLD_LIBRARY_PATH=foo-out ./main-out/Main'
end
