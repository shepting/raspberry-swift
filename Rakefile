
require_relative 'tooling/SwiftBuild.rb'

def system_and_log(message)
  puts message
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
    system 'swiftc source/Home/DataStore.swift source/Home/AnalogReader.swift source/Home/LightSwitch.swift source/SwiftyGPIO/*.swift source/main.swift -o build/main'
    system './build/main'
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



task :i2c do
  build_gpio
  build_main
  # system './build/i2cdetect'
end
