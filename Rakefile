
require_relative 'tooling/SwiftBuild.rb'

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
    system 'swiftc source/Home/DataStore.swift source/Home/AnalogReader.swift source/Home/LightSwitch.swift source/main.swift -o main'
end
