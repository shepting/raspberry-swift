

LOG = 'build/swift_build.log'
SOURCES = 'source/DataStore.swift source/AnalogReader.swift source/LightSwitch.swift'
# SOURCES = 'source/AnalogReader.swift source/LightSwitch.swift'

ARGS = '-module-cache-path build -Onone'
# ARGS = '-module-cache-path build'


task :default do
    system 'rake --tasks'
end

desc 'Build the project'
task :build do
    log 'Building project'
    build_module
    build_main
end

desc 'Clean the intermediate build files'
task :clean do
    sh 'rm -rf build/*'
end

# Functions

def build_module
    sh "swiftc #{SOURCES} #{ARGS} -emit-library -module-name Home -emit-module -o build/libHome.dylib"
    # sh "swiftc #{SOURCES} #{ARGS} -emit-library -module-name Home -emit-module"

end

def build_main
    sh "swift #{ARGS} -I build -L build -lHome source/main.swift -o build/main"
end


def log(message)
    puts message
end
