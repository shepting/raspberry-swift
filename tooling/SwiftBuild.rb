
ARGS = '-module-cache-path build -Onone'
# SOURCES = 'source/Home/DataStore.swift source/Home/AnalogReader.swift source/Home/LightSwitch.swift'
SOURCES = 'DataStore.swift'


def build_home
    sh "swiftc #{SOURCES} #{ARGS} -emit-library -module-name Home -emit-module -o build/libHome.dylib -emit-dependencies -v"
    # sh "swiftc #{SOURCES} -v"

end

def build_main
    sh "swiftc #{ARGS} -I build -L build -lHome source/main.swift -o build/main -emit-dependencies"
end

def self.clean
    sh 'rm -rf build/*'
end
