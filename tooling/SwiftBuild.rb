
ARGS = '-module-cache-path build -Onone'
SOURCES = 'source/DataStore.swift source/AnalogReader.swift source/LightSwitch.swift'

def build_module
    sh "swiftc #{SOURCES} #{ARGS} -emit-library -module-name Home -emit-module -o build/libHome.dylib -emit-dependencies"
end

def build_main
    sh "swiftc #{ARGS} -I build -L build -lHome source/main.swift -o build/main -emit-dependencies"
end

def self.clean
    sh 'rm -rf build/*'
end

class SwiftBuild
    def self.build_module
        sh "swiftc #{SOURCES} #{ARGS} -emit-library -module-name Home -emit-module -o build/libHome.dylib"
    end

    def self.build_main
        sh "swift #{ARGS} -I build -L build -lHome source/main.swift -o build/main"
    end

    def self.clean
        sh 'rm -rf build/*'
    end
end
