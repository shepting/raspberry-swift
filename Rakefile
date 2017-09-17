

LOG = 'build/swift_build.log'
SOURCES = 'source/AnalogReader.swift source/LightSwitch.swift'
ARGS = '-module-cache-path build -swift-version 4'

desc 'Build the project'
task :build do
    log 'Building project'
    build_module
    build_main
end

task :clean do
    system 'rm -rf Home.swift* libHome.dylib*'
end

def build_module
    sh "swift #{ARGS} #{SOURCES} -emit-library -module-name Home -emit-module -o build/libHome.dylib"
end

def build_main
    sh "swift #{ARGS} -I build -L build -lHome source/main.swift -o build/main"
end


def log(message)
    puts message
end
