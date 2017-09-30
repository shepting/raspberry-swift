
require_relative 'Path.rb'

ARGS = '-module-cache-path build -Onone'

def build_module
    sh "swiftc #{Path.sources} #{ARGS} -emit-library -module-name Home -emit-module -o build/libHome.dylib"
end

def build_main
    sh "swift #{ARGS} -I build -L build -lHome source/main.swift -o build/main"
end

def self.clean
    sh 'rm -rf build/*'
end

class SwiftBuild
    def self.build_module
        sh "swiftc #{Path.sources} #{ARGS} -emit-library -module-name Home -emit-module -o build/libHome.dylib"
    end

    def self.build_main
        sh "swift #{ARGS} -I build -L build -lHome source/main.swift -o build/main"
    end

    def self.clean
        sh 'rm -rf build/*'
    end
end
