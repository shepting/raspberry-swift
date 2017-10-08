
ARGS = '-module-cache-path build -Onone'
SOURCES = 'source/Home/DataStore.swift source/Home/AnalogReader.swift source/Home/LightSwitch.swift'
# SOURCES = 'DataStore.swift'

def log(message)
  blue_color_code = 34
  puts "\e[#{blue_color_code}m#{message}\e[0m"
end

def build_home
  log 'Building Home'
  sh "swiftc #{SOURCES} #{ARGS} -emit-library -module-name Home -emit-module -o build/libHome.dylib -v -num-threads 4 -emit-dependencies"
    # sh "swiftc #{SOURCES} -v"

end

def build_main
  log 'Building main'
  system 'LD_LIBRARY_PATH=/home/steven/workspace/raspberry-swift/build'
  system 'echo $LD_LIBRARY_PATH'
  sh "swiftc #{ARGS} -I build -L build -lHome source/main.swift -o build/main -v -Xlinker -v"
end

def self.clean
    sh 'rm -rf build/*'
end
