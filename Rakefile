
require_relative 'tooling/SwiftBuild.rb'
require_relative 'tooling/common.rb'


task :default do
  system 'rake --tasks'
end

desc 'Build the project'
task :build do
  log 'Building project'
  system_and_log 'swift build'
end

desc 'Build and run the project using Swift PM'
task run: :build do
  log 'Running project'
  system_and_log '.build/debug/RaspberrySwift'
end

desc 'Clean the intermediate build files'
task :clean do
  SwiftBuild.clean
end

desc 'Build on Linux'
task :linux do
  system_and_log 'swiftc -j4 \
  source/SwiftyGPIO/Mailbox.swift source/SwiftyGPIO/SunXi.swift source/SwiftyGPIO/UART.swift source/SwiftyGPIO/I2C.swift  source/SwiftyGPIO/Presets.swift source/SwiftyGPIO/SwiftyGPIO.swift source/main.swift -o .build/main -v'
  system_and_log './build/main'
end

# Logging to Amazon Cloudwatch
namespace :log do
  desc 'Log the processor temperature to Cloudwatch'
  task :processor_temp do
    log 'Logging CPU temp'
    system_and_log 'aws cloudwatch put-metric-data --metric-name ProcessorTemperatureCelcius --namespace RaspberrySwift --unit Count --value $(expr `cat /sys/class/thermal/thermal_zone0/temp` / 1000)'
  end

  task :gpu_temp do
    require 'open3'
    temp_string, success = Open3.capture2e('/opt/vc/bin/vcgencmd', 'measure_temp')
    temp_value = temp_string.match(/=(.*)'/)[1]
    command = 'aws cloudwatch put-metric-data --metric-name GPUTemperatureCelcius --namespace RaspberrySwift --unit Count --value ' + temp_value
    system_and_log command
  end

  task :boot do
    system_and_log 'aws cloudwatch put-metric-data --metric-name Boot --namespace RaspberrySwift --unit Count --value 1'
  end
end

namespace :view do
  desc 'View the crontab log'
  task :crontab_log do
    system_and_log 'grep CRON /var/log/syslog'
  end

  desc 'View memory offsets'
  task :memory_offsets do
    system_and_log 'cat /proc/iomem'
  end
end

task :i2c do
  build_with_module

  # Execute the executable.
  # system 'DYLD_LIBRARY_PATH=foo-out ./main-out/Main'
end
